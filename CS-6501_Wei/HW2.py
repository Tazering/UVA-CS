import argparse
import random

import matplotlib.pyplot as plt
import numpy as np
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from sklearn.datasets import load_digits
from sklearn.preprocessing import StandardScaler
from torch.utils.data import DataLoader, TensorDataset
from torchvision import datasets, transforms


# Load MNIST dataset
mnist = datasets.MNIST(root="./data", train=True, download=True, transform=transforms.ToTensor())

X = mnist.data.numpy().reshape(-1, 784).astype(np.float32)
y = mnist.targets.numpy()

# Select 2500 samples per class
X_list, y_list = [], []
for digit in range(4):
    X_d, y_d = X[y == digit][:2500], y[y == digit][:2500]
    X_list.append(X_d)
    y_list.append(y_d)

# Concatenate the selected samples
X = np.vstack(X_list)
y = np.hstack(y_list)

print("X.shape (digit images)", X.shape)
print("y.shape (digit labels)", y.shape)

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
X_tensor = torch.tensor(X_scaled, dtype=torch.float32)
y_tensor = torch.tensor(y, dtype=torch.long)
train_dataset = TensorDataset(X_tensor, y_tensor)
context_dim = X_tensor.shape[1]
n_actions = len(torch.unique(y_tensor))


class BanditModel(nn.Module):
    def __init__(self, dim, n_actions, args, constant):
        super().__init__()
        self.dim = dim
        self.n_actions = n_actions
        self.algorithm = args.algorithm
        if args.algorithm == "EG": 
            self.eps = constant
        elif args.algorithm == "BE" or args.algorithm == "IGW":
            self.ld = constant
        elif args.algorithm == "PPO": 
            self.b = constant

        self.fc1 = nn.Linear(dim, 32)
        self.fc2 = nn.Linear(32, n_actions)

        # baseline network
        self.fc3 = nn.Linear(dim, 32)
        self.fc4 = nn.Linear(32, 1)
        
        self.optimizer = optim.Adam(self.parameters(), lr=1e-3)
        # The number of data collection steps within a single t in 1,2,...,T
        self.N = 256
        # The number of gradient steps within a single t in 1,2,...,T
        self.M = 30


    def forward(self, x):
        x = self.fc1(x)
        x = nn.ReLU()(x)
        x = self.fc2(x)
        if self.algorithm == "PPO": 
            x = nn.Softmax(dim=1)(x)
        return x

    def forward_baseline(self, x):    # the baseline network for PPO with adaptive baseline
        x = self.fc3(x)
        x = nn.ReLU()(x)
        x = self.fc4(x)
        return x
        

    def act(self, x, time):
        # x is the context
        predicted_reward_all = self(x)
        max_predicted_reward = torch.max(predicted_reward_all, dim=1, keepdim=True)[0]
        gap = predicted_reward_all - max_predicted_reward    # this is actually negative gap
        batchsize = gap.shape[0] 

        # print(predicted_reward_all[0])

        if self.algorithm == "Rand":
            return 1 / self.n_actions * torch.ones_like(gap)  

        elif self.algorithm == "Greedy":
            max_index = gap.argmax(dim=1)
            prob = torch.zeros_like(gap)
            prob[torch.arange(batchsize), max_index] = 1
            return prob

        elif self.algorithm == "EG":  

            max_index = gap.argmax(dim = 1)
            prob = torch.zeros_like(gap)

            prob[torch.arange(batchsize), max_index] = (self.eps/self.n_actions) + (1 - self.eps)
            
            return prob

        elif self.algorithm == "IGW":  
            # TODO: Inverse Gap Weighting

            for n in range(batchsize):
                max_index = gap.argmax(dim = 1)
                prob = torch.zeros_like(gap)

                for a in range(self.n_actions):
                    
                    if a == max_index:
                        prob[n, a] = 1 - torch.sum(predicted_reward_all[:max_index] + predicted_reward_all[max_index + 1:])
                    
                    else:
                        prob[n, a] = 1 / (self.n_actions + self.ld * torch.max(gap))

            return prob

        elif self.algorithm == "BE":  
            # TODO: Boltzmann Exploration

            prob = torch.zeros_like(gap)
            max_index = gap.argmax(dim = 1)

            denom = torch.sum(torch.exp(self.ld * gap))
            # print(denom)
               
            for a in range(self.n_actions):
                prob[torch.arange(batchsize), a] = torch.exp(self.ld * gap[:, a]) / denom

            return prob
        
        elif self.algorithm == "PPO":  
            # TODO: PPO
            # take context and return output of neural network
            output = self.forward(x)

            return output
    

    def update_batch(self, batch_x, batch_action, batch_reward, batch_action_prob):
        """
        Args:
            batch_x: a batch of contexts
            batch_action: the batch of actions chosen in those contexts
            batch_reward: the batch of rewards observed
            batch_action_prob: the batch of probabilities for only those chosen actions
        """
        if self.algorithm == "PPO":
            # TODO: PPO policy update 
            
            all_predicted_action = self.forward(batch_x)            
            print(f"shape: {all_predicted_action.shape}")


            loss = self.ppo_loss(batch_action, batch_action_prob, batch_reward, self.b)

            # print(f"loss: {loss}")

            self.optimizer.zero_grad()
            loss.backward()
            self.optimizer.step()

        else:
            # regression oracle for value based approaches (BE, EG, IGW)
            for _ in range(self.M):
                all_predicted_rewards = self(batch_x)  
                predicted_rewards = all_predicted_rewards.gather(1, batch_action)
                loss = F.mse_loss(predicted_rewards, batch_reward)
                self.optimizer.zero_grad()
                loss.backward()
                self.optimizer.step()
    
    def ppo_loss(self, batch_action_prob, all_predicted_actions, rewards, b):
        ratio = batch_action_prob / all_predicted_actions

        cost = (ratio * (rewards - b)) - (.1 * (ratio - 1 - torch.log2(ratio)))
        
        # print(torch.sum(cost))

        return torch.mean(cost)


def train(args, n_seeds=2):
    """
    Main training loop. Handles both value-based and policy-based approaches.
    """
    T = y.shape[0]
    accuracy_values_avg = np.zeros((T,))
    accuracy_values_recent_avg = np.zeros((T,))

    constants = [2, 1.5, 1, 0.5, 0, -.05]

    for idx in range(len(constants)):


        for sd in range(n_seeds): 
            torch.manual_seed(sd)
            random.seed(sd)
            np.random.seed(sd)

            print("running for seed = ", sd)

            train_loader = DataLoader(train_dataset, batch_size=1, shuffle=True)
            model = BanditModel(context_dim, n_actions, args, constant = constants[idx])

            accuracy_values = np.zeros((T,))
            accuracy_values_recent = np.zeros((T,))
            t = 0
            batch_context = []
            batch_action = []
            batch_reward = []
            batch_action_prob = []
            
            
            for context, label in train_loader:
                switch_point = y.shape[0] // 2
                if t < switch_point: 
                    reward_vector = 0.5 * F.one_hot(label, n_actions).float() 
                else:  
                    reward_vector = 0.5 * F.one_hot(label, n_actions).float() + F.one_hot( (label+1)%n_actions, n_actions).float() 
                    
                action_prob_all = model.act(context, t)
                # print(action_prob_all)
                
                action = torch.multinomial(action_prob_all, num_samples=1)
                reward = torch.gather(reward_vector, 1, action)
                action_prob = torch.gather(action_prob_all, 1, action)

                batch_context.append(context)
                batch_action.append(action)
                batch_reward.append(reward)
                batch_action_prob.append(action_prob)
                        
                if (t + 1) % model.N == 0:
                    batch_context = torch.cat(batch_context, dim=0)
                    batch_action = torch.cat(batch_action, dim=0)
                    batch_reward = torch.cat(batch_reward, dim=0)
                    batch_action_prob = torch.cat(batch_action_prob, dim=0)
                    model.update_batch(
                        batch_context, batch_action, batch_reward, batch_action_prob
                    )
                    batch_context = []
                    batch_action = []
                    batch_reward = []
                    batch_action_prob = []
                            

                # Common accuracy tracking
                accuracy_values[t] = reward
                recent = accuracy_values[max(0,t-500): t]
                accuracy_values_recent[t] = np.mean(recent)
                t += 1

            accuracy_values_avg += accuracy_values
            accuracy_values_recent_avg += accuracy_values_recent
    
        accuracy_values_avg /= n_seeds
        accuracy_values_recent_avg /= n_seeds

        plt.plot(np.arange(T), accuracy_values_recent_avg, label = f"Lambda = {constants[idx]}")


        # list of plots
        print("\naverage_reward_1st_phase =", np.mean(accuracy_values_avg[:switch_point]))
        print("average_reward_2nd_phase =", np.mean(accuracy_values_avg[switch_point:]))
        print("average_reward =", np.mean(accuracy_values_avg))
        print("\n")

    print(f"Algorithm: {args.algorithm}")
    if args.algorithm == "EG":
        print("eps =", args.eps)
    elif args.algorithm == "IGW":
        print("lambda =", args.ld)
    elif args.algorithm == "BE":
        print("lambda =", args.ld)
    elif args.algorithm == "PPO": 
        print("b =", args.b)

    # plt.figure()
    plt.legend()
    plt.title(f"Average Reward over Time ({args.algorithm})")
    plt.xlabel("Time Step")
    plt.ylabel("Average Reward")
    plt.show()

# def train(args, n_seeds=5):
#     """
#     Main training loop. Handles both value-based and policy-based approaches.
#     """
#     T = y.shape[0]
#     accuracy_values_avg = np.zeros((T,))
#     accuracy_values_recent_avg = np.zeros((T,))

#     epsilons = [.1, .03, .01, .003, .001, 0]

#     for sd in range(n_seeds): 
#         torch.manual_seed(sd)
#         random.seed(sd)
#         np.random.seed(sd)

#         print("running for seed = ", sd)

#         train_loader = DataLoader(train_dataset, batch_size=1, shuffle=True)
#         model = BanditModel(context_dim, n_actions, args)

#         accuracy_values = np.zeros((T,))
#         accuracy_values_recent = np.zeros((T,))
#         t = 0
#         batch_context = []
#         batch_action = []
#         batch_reward = []
#         batch_action_prob = []
        
        
#         for context, label in train_loader:
#             switch_point = y.shape[0] // 2
#             if t < switch_point: 
#                 reward_vector = 0.5 * F.one_hot(label, n_actions).float() 
#             else:  
#                 reward_vector = 0.5 * F.one_hot(label, n_actions).float() + F.one_hot( (label+1)%n_actions, n_actions).float() 
                
#             action_prob_all = model.act(context, t)
#             # print(action_prob_all)
            
#             action = torch.multinomial(action_prob_all, num_samples=1)
#             reward = torch.gather(reward_vector, 1, action)
#             action_prob = torch.gather(action_prob_all, 1, action)

#             batch_context.append(context)
#             batch_action.append(action)
#             batch_reward.append(reward)
#             batch_action_prob.append(action_prob)
                    
#             if (t + 1) % model.N == 0:
#                 batch_context = torch.cat(batch_context, dim=0)
#                 batch_action = torch.cat(batch_action, dim=0)
#                 batch_reward = torch.cat(batch_reward, dim=0)
#                 batch_action_prob = torch.cat(batch_action_prob, dim=0)
#                 model.update_batch(
#                     batch_context, batch_action, batch_reward, batch_action_prob
#                 )
#                 batch_context = []
#                 batch_action = []
#                 batch_reward = []
#                 batch_action_prob = []
                        

#             # Common accuracy tracking
#             accuracy_values[t] = reward
#             recent = accuracy_values[max(0,t-500): t]
#             accuracy_values_recent[t] = np.mean(recent)
#             t += 1

#         accuracy_values_avg += accuracy_values
#         accuracy_values_recent_avg += accuracy_values_recent
    
#     accuracy_values_avg /= n_seeds
#     accuracy_values_recent_avg /= n_seeds

#     print(f"Algorithm: {args.algorithm}")
#     if args.algorithm == "EG":
#         print("eps =", args.eps)
#     elif args.algorithm == "IGW":
#         print("lambda =", args.ld)
#     elif args.algorithm == "BE":
#         print("lambda =", args.ld)
#     elif args.algorithm == "PPO": 
#         print("b =", args.b)

#     print("average_reward_1st_phase =", np.mean(accuracy_values_avg[:switch_point]))
#     print("average_reward_2nd_phase =", np.mean(accuracy_values_avg[switch_point:]))
#     print("average_reward =", np.mean(accuracy_values_avg))

#     plt.figure()
#     plt.plot(np.arange(T), accuracy_values_recent_avg)
#     plt.title(f"Average Reward over Time ({args.algorithm})")
#     plt.xlabel("Time Step")
#     plt.ylabel("Average Reward")
#     plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run bandit algorithms")
    parser.add_argument(
        "--algorithm",
        type=str,
        default="Rand",
        choices=["Rand", "EG", "IGW", "BE", "PPO", "Greedy"],
        help="Algorithm to run",
    )
    parser.add_argument(
        "--eps",
        type=float,
        default=0.01,
        help="epsilon parameter for epsilon greedy",
    )
    parser.add_argument(
        "--ld",
        type=float,
        default=10,
        help="lambda parameter for boltzmann exploration or inverse gap weighting",
    )
    parser.add_argument(
        "--b",
        type=float,
        default=1,
        help="baseline for PPO",
    )
    args = parser.parse_args()
    train(args)