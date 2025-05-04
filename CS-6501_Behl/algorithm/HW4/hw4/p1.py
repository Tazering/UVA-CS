import numpy as np
import torch as th
import torch.nn as nn
from torch.distributions import Normal
import matplotlib.pyplot as plt
import seaborn as sns

class u_t(nn.Module):
    def __init__(s, xdim=2, udim=1):
        super().__init__()
        """
        Build two layer neural network
        We will assume that the variance of the stochastic
        controller is a constant, so the network simply
        outputs the mean. We will do a hack to code up the constraint
        on the magnitude of the control input. We use a tanh nonlinearity
        to ensure that the output of the network is always between [-1,1]
        and then add a noise to it. While the final sampled control may be larger
        than the constraint we desire [-1,1], this is a quick cheap way to enforce the constraint.
        """
        s.m = nn.Sequential(
                nn.Linear(xdim, 8),
                nn.ReLU(True),
                nn.Linear(8, udim),
                nn.Tanh(),
                )
        s.std = 1

    def forward(s, x, u=None):
        """
        This is a PyTorch function that runs the network
        on a state x to output a control u. We will also output
        the log probability log u_theta(u | x) because we want to take
        the gradient of this quantity with respect to the parameters
        """
        # mean control
        mu = s.m(x)
        # Build u_theta(cdot | x)
        n = Normal(mu, s.std)
        # sample a u if we are simulating the system, use the argument
        # we are calculating the policy gradient
        if u is None:
            u = n.rsample()
        logp = n.log_prob(u)
        return u, logp

def rollout(policy, m = 1):
    """
    We will use the control u_theta(x_t) to take the control action at each
    timestep. You can use simple Euler integration to simulate the ODE forward
    for T = 200 timesteps with discretization dt=0.05.
    At each time-step, you should record the state x,
    control u, and the reward r
    """
    m = m; l=1; b=0.1; g=9.8;
    gamma=0.99;
    get_rev = lambda z, zdot, u: -0.5*((np.pi-z)**2 + zdot**2 + 0.01*u**2)

    xs = [np.zeros(2)]; us = []; rs= [];
    dt = 0.05
    for t in np.arange(0, 10, dt):
        # The interface between PyTorch and numpy becomes a bit funny
        # but all that this line is doing is that it is running u(x) to get
        # a control for one state x
        u = policy(th.from_numpy(xs[-1]).view(1,-1).float())[0].detach().numpy().squeeze().item()

        z, zdot = xs[-1][0], xs[-1][1]
        zp = z + zdot*dt
        zdotp = zdot + dt*(u - m*g*l*np.sin(z) - b*zdot)/m/l**2

        rs.append(get_rev(z, zdot, u))
        us.append(u)
        xs.append(np.array([zp, zdotp]))

    R = sum([rr*gamma**k for k,rr in enumerate(rs)])
    return {'x': th.tensor(xs[:-1]).float(),
            'u': th.tensor(us).float(),
            'r': th.tensor(rs).float(), 'R': R}

def example_train():
    """
    The following code shows how to compute the policy gradient and update
    the weights of the neural network using one trajectory.
    """
    policy = u_t(xdim=2, udim=1)
    optim = th.optim.Adam(policy.parameters(), lr=1e-3)

    # 1. get a trajectory
    t = rollout(policy)
    """"
    2. We now want to calculate grad log u_theta(u | x), so
    we will feed all the states from the trajectory again into the network
    and this time we are interested in the log-probabilities. The following
    code shows how to update the weights of the model using one trajectory
    """
    logp = policy(t['x'].view(-1,2), t['u'].view(-1,1))[1]
    f = -(t['R']*logp).mean()

    print(f"f: {f}")

    # zero_grad is a PyTorch peculiarity that clears the backpropagation
    # gradient buffer before calling the next .backward()
    policy.zero_grad()
    # .backward computes the gradient of the policy gradient objective with respect
    # to the parameters of the policy and stores it in the gradient buffer
    f.backward()
    # .step() updates the weights of the policy using the computed gradient
    optim.step()


def train(iterations = 10, num_trajectories = 2, lr = 1e-3):
    """
    TODO: XXXXXXXXXXXX
    This is very similar to example_train() above. You should sample
    multiple trajectory at each iteration and run the training for about 1000
    iterations. You should track the average value of the return across multiple
    trajectories and plot it as a function of the number of iterations.
    """
    # initialize the network and the optimizer
    policy = u_t(xdim = 2, udim = 1)
    optim = th.optim.Adam(policy.parameters(), lr = lr)
    cumulative_R = []

    for iter in range(iterations):

        # 1. minibatch sample of trajectories
        R_list = []
        trajectories = []
        print("Sampling trajectories...")
        for traj in range(num_trajectories):
            t = rollout(policy)
            R = t["R"]
            
            trajectories.append(t)
            R_list.append(R)
        
        R_numpy = np.array(R_list) # convert to numpy array
        traj_numpy = np.array(trajectories)
        b = R_numpy.mean() # baseline which is just the average

        # 2. policy gradient averaging
        policy_grad_list = []
        print("Getting the Policy Gradient...")
        for R_idx in range(R_numpy.shape[0]):
            t = traj_numpy[R_idx]
            logp = policy(t["x"].view(-1, 2), t["u"].view(-1, 1))[1]

            # f = -((R_numpy[R_idx] - b) * logp)
            f = ((R_numpy[R_idx] - b) * logp)

            policy_grad_list.append(f)
        
        batch_policy_outputs = th.stack(policy_grad_list) # combine into a single batch
        average_batch_policy = batch_policy_outputs.mean()

        # 3. calculate gradient of the policy
        print("Calculating the gradient and update the weights...")
        optim.zero_grad()
        average_batch_policy.backward()
        optim.step()

        R_mean = -R_numpy.mean()
        print(f"Iteration {iter}; Cumulative R: {R_mean}\n\n")
        cumulative_R.append(R_mean)
    
    return cumulative_R, policy

def evaluate(policy):
    t = rollout(policy, m = 2)
    return -t["R"]
   
# plot the rewards
def plot_cumulative_rewards(rewards, title = "", figure_name = ""):

    plt.plot(rewards)
    plt.title(title)
    plt.xlabel("Iterations/Timesteps")
    plt.ylabel("Cumulative Reward")
    plt.savefig(f"./{figure_name}")
    plt.show()

learning_rate = [1e-5, 1e-3, 1e-1]
num_trajectories = [1, 5, 10]
iterations = [1000, 750]

cum_rewards0, policy0 = train(iterations = 1000, num_trajectories=10, lr = 1e-3) # best so far

print("Evaluating on m=2...")
cumulative_reward = evaluate(policy0)
print(f"Reward: {cumulative_reward}")
# cum_rewards1, policy0 = train(iterations = 750, num_trajectories=10, lr = 1e-5)
# cum_rewards2, policy0 = train(iterations = 1000, num_trajectories=10, lr = 1e-5)
# cum_rewards3, policy0 = train(iterations = 750, num_trajectories=10, lr = 1e-3)

# plot_cumulative_rewards(cum_rewards0, title = f"Cumulative Rewards vs. Iterations: lr = 1e-3, iterations = 1000", figure_name = "1e-3_1000")
# plot_cumulative_rewards(cum_rewards1, title = f"Cumulative Rewards vs. Iterations: lr = 1e-5, iterations = 750", figure_name = "1e-5_750")
# plot_cumulative_rewards(cum_rewards2, title = f"Cumulative Rewards vs. Iterations: lr = 1e-5, iterations = 1000", figure_name = "1e-5_1000")
# plot_cumulative_rewards(cum_rewards3, title = f"Cumulative Rewards vs. Iterations: lr = 1e-3, iterations = 750", figure_name = "1e-3_750")
