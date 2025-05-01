import gym
import numpy as np
import torch as th
import torch.nn as nn

def rollout(e, q, eps=0, T=200):
    traj = []

    x = e.reset()
    for t in range(T):
        u = q.control(th.from_numpy(x[0]).float().unsqueeze(0), # added indexing - tkj9ep
                      eps=eps)
        u = u.int().numpy().squeeze()

        xp,r,d,info = e.step(u)[0] # added indexing - tkj9ep
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
        if eps == 0: # exploit
            u = th.argmax(s.forward(x))

        elif eps == 1: # explore
            u = th.randint(0, 2, (1,))

        return u

def loss(q, ds):
    ### TODO: XXXXXXXXXXXX
    # 1. sample mini-batch from dataset ds

    # 2. code up dqn with double-q trick

    # 3. return the objective f
    
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
    e = gym.make('CartPole-v1')

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