import gym
import numpy as np
import torch as th
import torch.nn as nn
import copy
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
        
        # declare a new target network
        s.target_net = copy.deepcopy(s.m)

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
            u = th.argmax(q)

        return u

def loss(q, ds):
    ### TODO: XXXXXXXXXXXX
    # 1. sample mini-batch from datset ds
    batch_size = 64
    gamma = .99
    alpha = .05

        
    flattened_ds = [entry for trajectory in ds for entry in trajectory] # flatten the list because we want to sample from different trajectories
    mini_batch = random.sample(flattened_ds, k = batch_size)
    
        # separate dictionary into stack
    current_states = th.stack([th.tensor(input["x"], dtype=th.float32) for input in mini_batch])
    next_states = th.stack([th.tensor(input["xp"], dtype = th.float32) for input in mini_batch])
    actions = th.tensor([input["u"] for input in mini_batch]).unsqueeze(1)
    rewards = th.tensor([input["r"] for input in mini_batch]).unsqueeze(1)
    dones = th.tensor([int(input["d"]) for input in mini_batch]).unsqueeze(1)

    # 2. code up dqn with double-q trick
    online_u = q(current_states)

    target_u = q.target_net(next_states)
    y_t = rewards + gamma * (1 - dones) * target_u

    # 3. return the objective f
    f = (online_u - y_t)
    return f

# u* = argmax q(x', u)
# (q(x, u) - r - g*(1-indicator of terminal)*qc(x' , u*))**2

def evaluate(q):
    ### TODO: XXXXXXXXXXXX
    # 1. create a new environment e
    # 2. run the learnt q network for 100 trajectories on
    # this new environment to take control actions. Remember that
    # you should not perform epsilon-greedy exploration in the evaluation
    # phase
    # and report the average discounted
    # return of these 100 trajectories
    return r

if __name__=='__main__':
    e = gym.make('CartPole-v0')

    xdim, udim =    e.observation_space.shape[0], \
                    e.action_space.n

    q = q_t(xdim, udim, 8)
    # Adam is a variant of SGD and essentially works in the
    # same way
    optim = th.optim.Adam(q.parameters(), lr=1e-3,
                          weight_decay=1e-4)

    ds = []

    # collect few random trajectories with
    # eps=1
    for i in range(1000):
        ds.append(rollout(e, q, eps=1, T=200))

    for i in range(1000):
        q.train()
        t = rollout(e, q)
        ds.append(t)

        # perform weights updates on the q network
        # need to call zero grad on q function
        # to clear the gradient buffer
        q.zero_grad()
        f = loss(q,ds)
        f.backward()
        optim.step()

        # exponential averaging for the target
        print('Logging data to plot')