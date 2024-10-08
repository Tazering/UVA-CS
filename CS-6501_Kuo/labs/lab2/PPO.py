import gymnasium as gym
from stable_baselines3 import PPO
from stable_baselines3.common.env_util import make_vec_env
from mani_skill.utils import gym_utils
from mani_skill.utils.wrappers.record import RecordEpisode
from mani_skill.vector.wrappers.sb3 import ManiSkillSB3VectorEnv

# run 64 environments for parallelized learning!
ms3_vec_env = gym.make("OpenCabinetDrawer-v1", num_envs=128)
max_episode_steps = 300
vec_env = ManiSkillSB3VectorEnv(ms3_vec_env)

# evaluation function
def eval(model, max_episode_steps, eval_vec_env):
    success_count = 0

    obs, _ = eval_vec_env.reset()
    for i in range(max_episode_steps):
        action, _states = model.predict(obs.cpu().numpy(), deterministic=True) # pick random action and state from PPO prediction
        obs, rewards, dones, _, info = eval_vec_env.step(action) # current observation, rewards, task complete, time-limit reaches, and other random info
    
    for boolean_val in dones:
        if boolean_val:
            success_count += 1
    

    print(f"\n\ninfo: {dones}\n\n")

    return success_count

# define PPO agent and train the model
model = PPO("MlpPolicy", vec_env, gamma=0.8, gae_lambda=0.9, n_steps=50, batch_size=128,
n_epochs=8, verbose=1, learning_rate = .0003)
model.learn(total_timesteps=10_000_000) # start learning; default timesteps = 500k
model.save("ppo") # save the model as ppo
vec_env.close()
del model
model = PPO.load("ppo") # load the saved model

# visualize the trained agent
eval_vec_env = gym.make("OpenCabinetDrawer-v1", num_envs=16, render_mode="rgb_array", control_mode= 'pd_joint_delta_pos')
eval_vec_env = RecordEpisode(eval_vec_env, output_dir="Videos", save_video=True,
save_trajectory=False, max_steps_per_video=max_episode_steps)
# eval_vec_env = ManiSkillSB3VectorEnv(eval_vec_env)
# obs = eval_vec_env.reset()

print("=======\nModel Trained\n=======") # log when the model finishes training

total_successes = 0

for iteration in range(100):
    total_successes += eval(model = model, max_episode_steps = max_episode_steps, eval_vec_env = eval_vec_env)
eval_vec_env.close()

print(f"Accuracy Rate: {total_successes / (100 * 16)}")