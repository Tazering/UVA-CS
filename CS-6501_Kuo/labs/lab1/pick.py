# Import required packages
import gymnasium as gym
import mani_skill.envs
import time
from mani_skill.utils.wrappers import RecordEpisode
import torch
import matplotlib.pyplot as plt
import math

import numpy as np

# Task ID, Visualiation Mode              
env = gym.make("PickCube-v1", render_mode = "rgb_array", control_mode = 'pd_ee_delta_pos', sim_backend = "cpu")
env = RecordEpisode(env, output_dir="Videos", save_trajectory=False,
save_video=True, video_fps=30, max_steps_per_video=100)

obs, _ = env.reset(seed=17) # start the task
env.unwrapped.print_sim_details() # print verbose details about the
# configuration; variables explaining the status of the environment

start_time = time.time()

# counter for iterations
counter = 0
gripper_state = 1 # 1 = open and -1 = closed

# empty lists that store iterations and joint/gripper states
iterations = []
robot_position = []

cube_position = env.cube.pose.p
ee_position = env.agent.tcp.pose.p

# move the robot
x_position_diff = cube_position[0][0] - ee_position[0][0]
y_position_diff = cube_position[0][1] - ee_position[0][1]
z_position_diff = cube_position[0][2] - ee_position[0][2]

total_position_difference = abs(x_position_diff) + abs(y_position_diff) + abs(z_position_diff)

# constant regarding robot movement
movement_constant = 1.2

# move robot to position
while total_position_difference > .015:

    # run the step
    obs, rew, done, truncated, info = env.step(torch.tensor([x_position_diff * movement_constant, 
    y_position_diff * movement_constant, z_position_diff * movement_constant, gripper_state]))

    # update
    cube_position = env.cube.pose.p
    ee_position = env.agent.tcp.pose.p
    x_position_diff = cube_position[0][0] - ee_position[0][0]
    y_position_diff = cube_position[0][1] - ee_position[0][1]
    z_position_diff = cube_position[0][2] - ee_position[0][2]
    total_position_difference = abs(x_position_diff) + abs(y_position_diff) + abs(z_position_diff)
    
    # append to lists
    robot_position.append(ee_position)
    counter += 1
    iterations.append(counter)

# close the gripper
while not info["is_grasped"][0]:
    obs, rew, done, truncated, info = env.step(torch.tensor([0, 0, 0, -.001]))
    iterations.append(counter)
    ee_position = env.agent.tcp.pose.p
    robot_position.append(ee_position)
    counter+=1

# lift up the cube
for i in range(20):
    obs, rew, done, truncated, info = env.step(torch.tensor([0, 0, 0.5, 0]))
    iterations.append(counter)
    ee_position = env.agent.tcp.pose.p
    robot_position.append(ee_position)
    counter+=1
env.close()

# 3D plots 
x_values = []
y_values = []
z_values = []

# separate coordinates
for position in robot_position:
    x_values.append(position[0][0])
    y_values.append(position[0][1])
    z_values.append(position[0][2])

# plot values
ax = plt.axes(projection='3d')
ax.plot3D(x_values, y_values, z_values, 'gray')

plt.savefig("pick")

N = info["elapsed_steps"].item()
dt = time.time() - start_time
FPS = N / (dt)
print(f"Frames Per Second = {N} / {dt} = {FPS}")