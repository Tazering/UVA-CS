# Import required packages
import gymnasium as gym
import mani_skill.envs
import time
from mani_skill.utils.wrappers import RecordEpisode
import torch
import matplotlib.pyplot as plt

import numpy as np

# Task ID, Visualiation Mode              
env = gym.make("PickCube-v1", render_mode = "rgb_array", control_mode = 'pd_ee_delta_pos', sim_backend = "cpu")
env = RecordEpisode(env, output_dir="Videos", save_trajectory=False,
save_video=True, video_fps=30, max_steps_per_video=100)

obs, _ = env.reset(seed=17) # start the task
env.unwrapped.print_sim_details() # print verbose details about the
# configuration; variables explaining the status of the environment
done = False
truncated = False
start_time = time.time()

num_iterations = 100
gripper_state = 1 # 1 = open and -1 = closed

# dictionary of directions (assumes that control mode is "pd_ee_delta_pos")
direction_dict = {"x": torch.tensor([.05, 0, 0, gripper_state]),
                   "y": torch.tensor([0, .05, 0, gripper_state]),
                   "z": torch.tensor([0, 0, .05, gripper_state])}

# counter for iterations
counter = 0

# direction we want to do
direction = "y"
gripper_states = []


# empty lists that store iterations and joint/gripper states
iterations = []
joint_0 = []
joint_1 = []
joint_2 = [] 
joint_3 = []
joint_4 = [] 
joint_5 = [] 
joint_6 = []
joint_7 = []

while (counter < num_iterations): # while loop for action roll-out

    qpos_state = env.agent.robot.get_qpos()
    
    # store into array for graphing
    iterations.append(counter)
    joint_0.append(qpos_state[0][0])
    joint_1.append(qpos_state[0][1])
    joint_2.append(qpos_state[0][2])
    joint_3.append(qpos_state[0][3])
    joint_4.append(qpos_state[0][4])
    joint_5.append(qpos_state[0][5])
    joint_6.append(qpos_state[0][6])
    joint_7.append(qpos_state[0][7])
    gripper_states.append(gripper_state)

    obs, rew, done, truncated, info = env.step(direction_dict[direction]) # current observation, reward, task complete, time-limit threshold, other information
    # print(obs)

    counter += 1

env.close()

# plot the lines
plt.plot(iterations, joint_0, label = "panda_joint1")
plt.plot(iterations, joint_1, label = "panda_joint2")
plt.plot(iterations, joint_2, label = "panda_joint3")
plt.plot(iterations, joint_3, label = "panda_joint4")
plt.plot(iterations, joint_4, label = "panda_joint5")
plt.plot(iterations, joint_5, label = "panda_joint6")
plt.plot(iterations, joint_6, label = "panda_joint7")
plt.plot(iterations, joint_7, label = "panda_joint8")
plt.plot(iterations, gripper_states, label = "gripper_states")
plt.legend()
plt.show()

plt.savefig("right_graph")

N = info["elapsed_steps"].item()
dt = time.time() - start_time
FPS = N / (dt)
print(f"Frames Per Second = {N} / {dt} = {FPS}")