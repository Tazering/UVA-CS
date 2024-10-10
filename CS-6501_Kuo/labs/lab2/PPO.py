import gymnasium as gym
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env
from mani_skill.utils import gym_utils
from mani_skill.utils.wrappers.record import RecordEpisode
from mani_skill.vector.wrappers.sb3 import ManiSkillSB3VectorEnv
from PIL import Image
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch
import warnings

"""
==================================================================================
The function is for part a of the assignment.
The purpose of the function is to run a certain number of iterations and evaluate the success rate.
==================================================================================
"""
warnings.filterwarnings("ignore")

# evaluation function
def eval(ppo_model, vlm_model, tokenizer, max_episode_steps, eval_vec_env):
    success_count = 0
    last_task_successful = False # purpose of this to extract the last task in the group of 16 that was successful

    image = []

    obs, _ = eval_vec_env.reset()
    for i in range(max_episode_steps):
        action, _states = ppo_model.predict(obs.cpu().numpy(), deterministic=True) # pick random action and state from PPO prediction
        obs, rewards, dones, _, info = eval_vec_env.step(action) # current observation, rewards, task complete, time-limit reaches, and other random info
    
    for boolean_val in dones:
        if boolean_val:
            success_count += 1


    # run vlm if the last trial was successful
    if dones[-1]:
        # get the image from the finished environment and run through vlm
        image_tensor = eval_vec_env.render()[0] # torch tensor image as 256 x 256 x 3
        image = Image.fromarray(image_tensor.cpu().numpy().astype('uint8')) # grab the image
        image.save("open_cabinet_drawer_final.jpg") # get the image
        last_task_successful = True
            

    print(f"\n\ndones: {dones}\n\n")

    return success_count, image, last_task_successful

"""
==================================================================================
The code below runs the script for the overall process.
==================================================================================
"""

# run 64 environments for parallelized learning!
ms3_vec_env = gym.make("OpenCabinetDrawer-v1", num_envs=1024)
max_episode_steps = 200
vec_env = ManiSkillSB3VectorEnv(ms3_vec_env)

# visualize the trained agent
eval_vec_env = gym.make("OpenCabinetDrawer-v1", num_envs=16, render_mode="rgb_array", control_mode= 'pd_joint_delta_pos')
eval_vec_env = RecordEpisode(eval_vec_env, output_dir="Videos", save_video=True,
save_trajectory=False, max_steps_per_video=max_episode_steps)

obs, _ = eval_vec_env.reset() # reset environment

"""
==================================================================================
Instantiate and train the llama and PPO models.
==================================================================================
"""

# Load Llama model and tokenizer
vlm_model = AutoModelForCausalLM.from_pretrained(# use a pre-trained LLM model
    "qresearch/llama-3.1-8B-vision-378", # use a pre-trained LLM model
    trust_remote_code=True,
    torch_dtype=torch.float16 # default data type for the weights of the model
).to("cuda")
tokenizer = AutoTokenizer.from_pretrained("qresearch/llama-3.1-8B-vision-378", use_fast=True)

# define PPO agent and train the model
ppo_model = PPO("MlpPolicy", vec_env, gamma=0.8, gae_lambda=0.9, n_steps=50, batch_size=128,
n_epochs=8, verbose=1, learning_rate = .0003)


ppo_model.learn(total_timesteps=10_000_000) # start learning; default timesteps = 10M
ppo_model.save("ppo") # save the model as ppo
vec_env.close()
del ppo_model
ppo_model = PPO.load("ppo") # load the saved model


print("=======\nModel Trained\n=======") # log when the model finishes training

"""
==================================================================================
Test the generalization ability of the models.
==================================================================================
"""

# grab the image and the prompt question and run the mvlm model
image_task_tensor = eval_vec_env.render()[0] # torch tensor image as 256 x 256 x 3
image_task = Image.fromarray(image_task_tensor.cpu().numpy().astype('uint8')) # grab the image
image_task.save("open_cabinet_drawer.jpg") # get the image
prompt_question = "Describe what the task is in detail."

# failsafe for the second part of using the vlm
image_tensor = eval_vec_env.render()[0] 
image = Image.fromarray(image_tensor.cpu().numpy().astype('uint8'))
image.save("open_cabinet_drawer_results.jpg")


total_successes = 0
final_scene_success = False

# test the generalization of the ppo model
for iteration in range(100):
    successes, env_image, last_task_successful = eval(ppo_model = ppo_model, vlm_model = vlm_model, tokenizer = tokenizer, max_episode_steps = max_episode_steps, eval_vec_env = eval_vec_env)
    total_successes += successes

    if last_task_successful: # get the image of the most recent successful task
        image = env_image
        final_scene_success = True


"""
==================================================================================
Run the VLMs
==================================================================================
"""

# Generate description for first part
description = vlm_model.answer_question(image, prompt_question, tokenizer, max_new_tokens=128,
do_sample=True, temperature=0.3)

print(f"Prompt: {prompt_question}\nAnswer: {description}")


# generate description for second part
prompt_question_final = "The task of this model is for the robot to open the second cabinet door fully. A success happens the robot opens the second cabinet door is open more 75 percent. Based on the image, was the task successful?"

final_description = vlm_model.answer_question(image, prompt_question_final, tokenizer, max_new_tokens=128, 
do_sample=True, temperature=0.3)

# print it out
print(f"\n\nWas final actions successful: {final_scene_success}\n")
print(f"Prompt After PPO: {prompt_question_final}\nDescription: {final_description}")

eval_vec_env.close()

print(f"\n\nAccuracy Rate: {total_successes / (100 * 16)}")