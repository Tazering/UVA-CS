import gym
import numpy as np
import torch as th
import torch.nn as nn
import copy
import matplotlib.pyplot as plt
import random

def rollout(e, q, eps=0, T=200):
    traj = []

    x, _ = e.reset()
    for t in range(T):
        u = q.control(th.from_numpy(x).float().unsqueeze(0),
                      eps=eps)

        u = u.int().numpy().squeeze()

        xp,r,d, truncated, info = e.step(u)
        t = dict(x=x,xp=xp,r=r,u=u,d=d,info=info)
        x = xp
        traj.append(t)
        if d:
            break
    return traj

class q_t(nn.Module):
    def __init__(s, xdim, udim, hdim=16):
        super().__init__()
        s.xdim, s.udim = xdim, udim
        s.m = nn.Sequential(
                            nn.Linear(xdim, hdim),
                            nn.ReLU(True),
                            nn.Linear(hdim, udim),
                            )

    def forward(s, x):
        return s.m(x)

    def control(s, x, eps=0):
         # 1. get q values for all controls
        q = s.m(x)

        ### TODO: XXXXXXXXXXXX
        # eps-greedy strategy to choose control input
        # note that for eps=0
        # you should return the correct control u
        rand_val = th.rand(1).item()
        if rand_val < eps: # explore
            u = th.randint(0, 2, (1,))

        else: # exploit
            u = th.argmax(q, dim = 1)

        return u

def loss(q, qc, ds):
    ### TODO: XXXXXXXXXXXX
    # 1. sample mini-batch from dataset ds
    batch_size = 128
    gamma = .99
        
    flattened_ds = [entry for trajectory in ds for entry in trajectory] # flatten the list because we want to sample from different trajectories
    mini_batch = random.sample(flattened_ds, k = batch_size)
    
        # separate dictionary into stack
    current_states = th.stack([th.tensor(input["x"], dtype=th.float32) for input in mini_batch])
    next_states = th.stack([th.tensor(input["xp"], dtype = th.float32) for input in mini_batch])
    actions = th.tensor([input["u"].item() for input in mini_batch]).unsqueeze(1)
    rewards = th.tensor([input["r"] for input in mini_batch]).unsqueeze(1)
    dones = th.tensor([int(input["d"]) for input in mini_batch]).unsqueeze(1)

    # 2. code up dqn with double-q trick
    online_u = q(current_states)
    actual_u = th.gather(online_u, dim = 1, index = actions)

    with th.no_grad():
        next_best_u_arg = th.argmax(q(next_states), dim = 1)
        target_u = qc(next_states)
        target_u_best_from_online = target_u.gather(1, next_best_u_arg.unsqueeze(1))
        y_t = rewards + gamma * (1 - dones) * target_u_best_from_online

    # 3. return the objective f
    f = th.sum(th.pow(actual_u - y_t, 2)) / batch_size

    return f

# u* = argmax q(x', u)
# (q(x, u) - r - g*(1-indicator of terminal)*qc(x' , u*))**2

def evaluate(q):
    ### TODO: XXXXXXXXXXXX
    # 1. create a new environment e
    e = gym.make("CartPole-v0")

    # 2. run the learnt q network for 100 trajectories on
    # this new environment to take control actions. Remember that
    # you should not perform epsilon-greedy exploration in the evaluation
    # phase
    # and report the average discounted
    # return of these 100 trajectories
    x, _ = e.reset()
    total_reward = 0

    for traj in range(100):
        x, _ = e.reset()
        done = False
        gamma = .99
        t = 0

        while not done:
            u = q.control(th.from_numpy(x).float().unsqueeze(0),
                      eps=0)
            u = u.int().numpy().squeeze()

            xp,r,d, truncated, info = e.step(u)
            done = d or truncated

            total_reward += (gamma**t) * r
            x = xp
            t += 1

    r = total_reward / 100

    return r

# get the average total return for in-training environment
def in_training_evaluation(q = None, trained_env = None, num_episodes = 10):
    total_reward = 0

    for _ in range(num_episodes): # loop through 10 episodes
        x, _ = trained_env.reset()
        done = False

        while not done:
            u = q.control(th.from_numpy(x).float().unsqueeze(0), eps = 0)
            u = u.int().numpy().squeeze()

            xp, r, d, truncated, info = trained_env.step(u)
            done = d or truncated
            total_reward += r
            x = xp
    
    return total_reward / 10

def post_training_evaluation(q = None, num_episodes = 10):
    e = gym.make('CartPole-v0')
    rewards = []
    for _ in range(num_episodes):
        x, _ = e.reset()
        done = False
        gamma = .99
        eps_reward = 0

        while not done:
            u = q.control(th.from_numpy(x).float().unsqueeze(0), eps = 0)
            u = u.int().numpy().squeeze()

            xp, r, d, truncated, info = e.step(u)
            done = d or truncated
            eps_reward += r
            x = xp
    
        rewards.append(eps_reward)

    return rewards

if __name__=='__main__':
    e = gym.make('CartPole-v0')
    num_iterations = 30000
    tau = 0.05

    xdim, udim =    e.observation_space.shape[0], \
                    e.action_space.n

    q = q_t(xdim, udim, 8)
    qc = copy.deepcopy(q)

    # Adam is a variant of SGD and essentially works in the
    # same way
    optim = th.optim.Adam(q.parameters(), lr=1e-3,
                          weight_decay=1e-4)

    ds = []

    # collect few random trajectories with
    # eps=1
    for i in range(1000):
        ds.append(rollout(e, q, eps=1, T=200))

    in_training_reward = []

    for i in range(num_iterations):
        q.train()
        eps = max(0.05, 1.0 - i / num_iterations)
        t = rollout(e, q, eps = eps)
        ds.append(t)

        # perform weights updates on the q network
        # need to call zero grad on q function
        # to clear the gradient buffer
        optim.zero_grad()
        f = loss(q, qc, ds)
        f.backward()
        optim.step()

        # update the target network
        with th.no_grad():
            for online_param, target_param in zip(q.parameters(), qc.parameters()):
                target_param.data.mul_(1 - tau).add_(tau * online_param.data)

        # exponential averaging for the target
        # print('Logging data to plot')
        if i % 1000 == 0: # in-training evaulation
            print(f"Evaluating at i = {i}...")
            r = in_training_evaluation(q = q, trained_env = e, num_episodes = 10)
            print(f"r @ i = {i}: {r}")
            in_training_reward.append(r)

    # in-training plot
    plt.plot(in_training_reward)
    plt.title("Average Total Return During Training")
    plt.xlabel("Every 1000 iterations")
    plt.ylabel("Average Return")
    plt.savefig("./images/training_eval.png")
    plt.show()

    post_training_rewards = post_training_evaluation(q)
    plt.plot(post_training_rewards)
    plt.title("Average Total Return After Training")
    plt.xlabel("Episode")
    plt.ylabel("Average Return")
    plt.savefig("./images/test_eval.png")
    plt.show()
