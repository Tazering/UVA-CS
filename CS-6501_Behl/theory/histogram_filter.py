import numpy as np
import matplotlib.pyplot as plt


class HistogramFilter(object):
    """
    Class HistogramFilter implements the Bayes Filter on a discretized grid space.
    """
    k_posteriors = {}
    
    def histogram_filter(self, cmap, belief, action, observation):
        '''
        Takes in a prior belief distribution, a colormap, action, and observation, and returns the posterior
        belief distribution according to the Bayes Filter.
        :param cmap: The binary NxM colormap known to the robot. (the grid)
        :param belief: An NxM numpy ndarray representing the prior belief. (I think this is the ground-truth for checking)
        :param action: The action as a numpy ndarray. [(1, 0), (-1, 0), (0, 1), (0, -1)]
        :param observation: The observation from the color sensor. [0 or 1].
        :return: The posterior distribution. 
        '''
        ### Your Algorithm goes Below.
        n, m = cmap.shape

        # set prior before anything 
        prior = np.full(shape = (n, m), fill_value = (1/(n*m)))

        posterior = self.calculate_beliefs(grid = cmap, actions = action, observations=observation, prior = prior)

        # display_heatmap(self.k_posteriors[0], title = f"Action: {self.string_action(action[0])} Observation: {observation[0]}")
        # display_heatmap(self.k_posteriors[4], title = f"Action: {self.string_action(action[4])} Observation: {observation[4]}")
        # display_heatmap(self.k_posteriors[9], title = f"Action: {self.string_action(action[9])} Observation: {observation[9]}")
        # display_heatmap(self.k_posteriors[14], title = f"Action: {self.string_action(action[14])} Observation: {observation[14]}")
        # display_heatmap(self.k_posteriors[19], title = f"Action: {self.string_action(action[19])} Observation: {observation[19]}")

        return posterior



    def calculate_beliefs(self, grid, actions, observations, prior):

        if (len(actions.shape) == 1):
            current_action = actions
            current_observation = observations

            posterior = self.calculate_posterior_cells(grid, current_action, current_observation, prior)
            return posterior

        for i in range(actions.shape[0]):
            current_action = actions[i]
            current_observation = observations[i]

            posterior = self.calculate_posterior_cells(grid, current_action, current_observation, prior)
            self.k_posteriors[i] = posterior

            prior = np.copy(self.k_posteriors[i])
        
        return posterior
        
            
    # this is for a single action/observation pair
    def calculate_posterior_cells(self, grid, action, observation, prior):
        n, m = grid.shape
        action_name = self.string_action(action)
        posterior = np.zeros(shape = grid.shape)

        max_val = -1
        max_idx = [-1, -1]

        for y in range(n): # loop through each cell
            for x in range(m):

                obs_probability = self.obs_prob(grid[y][x], observation = observation)

                # actions
                if action_name == "left": # left
                    posterior[y][x] = self.left_posterior_update(grid, obs_probability, prior, [x, y])
                    
                if action_name == "right": # right
                    posterior[y][x] = self.right_posterior_update(grid, obs_probability, prior, [x, y])

                if action_name == "up": # up
                    posterior[y][x] = self.up_posterior_update(grid, obs_probability, prior, [x, y])
                    
                if action_name == "down": # down
                    posterior[y][x] = self.down_posterior_update(grid, obs_probability, prior, [x, y])

                if posterior[y][x] >= max_val:
                    max_val = posterior[y][x]
                    max_idx = [x, n - 1 - y]

        # print(max_idx)
        return (posterior / np.sum(posterior))
    
    # posterior updates based on direction for one coordinate plane 
    def left_posterior_update(self, grid, observation_probability, prior, coords):
        n, m = grid.shape
        x = coords[0]
        y = coords[1]

        # check boundry
        if x >= (m-1):
            return prior[y][x] * .1 * observation_probability
        
        if x <= 0:
            return observation_probability * ((prior[y][x] * 1) + (prior[y][x + 1] * .9))
        
        # any other state
        posterior_value = observation_probability * ((prior[y][x] * .1) + (.9 * prior[y][x + 1]))
        return posterior_value

    def right_posterior_update(self, grid, observation_probability, prior, coords):
        n, m = grid.shape
        x = coords[0]
        y = coords[1]

        # check boundry
        if x <= 0:
            return prior[y][x] * .1 * observation_probability
        
        if x >= (m - 1):
            return observation_probability * ((prior[y][x - 1] * .9) + (prior[y][x]))
        
        # any other state
        posterior_value = observation_probability * ((prior[y][x] * .1) + (.9 * prior[y][x - 1]))
        return posterior_value

    def up_posterior_update(self, grid, observation_probability, prior, coords):
        n, m = grid.shape
        x = coords[0]
        y = coords[1]

        # check boundry
        if y >= (n-1):
            return prior[y][x] * .1 * observation_probability
        
        if y <= 0:
            return observation_probability * ((prior[y + 1][x] * .9) + (prior[y][x]))
        
        # any other state
        posterior_value = observation_probability * ((prior[y][x] * .1) + (.9 * prior[y + 1][x]))
        return posterior_value
    
    def down_posterior_update(self, grid, observation_probability, prior, coords):
        n, m = grid.shape
        x = coords[0]
        y = coords[1]

        # check boundry
        if y <= 0:
            return prior[y][x] * .1 * observation_probability
        
        if y >= (n - 1):
            return observation_probability * ((prior[y - 1][x] * .9) + (prior[y][x]))
        
        # any other state
        posterior_value = observation_probability * ((prior[y][x] * .1) + (.9 * prior[y - 1][x]))
        return posterior_value
    
    
    def obs_prob(self, grid_val, observation):
        if grid_val == observation:
            return .9

        return .1

    # converts action to words
    def string_action(self, action):
        x = action[0]
        y = action[1]

        if x == 1:
            return "right"

        if x == -1:
            return "left"

        if y == 1:
            return "up"
        
        return "down"

# create a heatmap given pi
def display_heatmap(pi, title):
    plt.title(label = title)
    plt.imshow(pi, cmap = 'hot', interpolation = 'nearest')
    plt.show()