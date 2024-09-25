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

# while (counter < num_iterations): # while loop for action roll-out
#     obs, rew, done, truncated, info = env.step(direction_dict[direction]) # current observation, reward, task complete, time-limit threshold, other information

#     counter += 1

#     # [delta_x, delta_y, delta_z, rotation_x, rotation_y, rotation_z, gripper_state]
cube_position = env.cube.pose.p

print(f"cube position: {cube_position}")
env.close()

