import numpy as np
from matplotlib.patches import Ellipse
from matplotlib import transforms
from quaternion import Quaternion

class UKF:
    def __init__(self, process_covariance, measurement_covariance):
        self.process_covariance = process_covariance
        self.measurement_covariance = measurement_covariance

    def compute_sigma_points(self, previous_mu, previous_covariance):
        previous_q = Quaternion(previous_mu[0], previous_mu[1:4])
        previous_angular = previous_mu[4:]
        cov = previous_covariance + self.process_covariance

        S = np.linalg.cholesky(cov)        
        scale = np.sqrt(2 * previous_covariance.shape[0])
        W = np.hstack([ scale *  S, -scale * S ]).T #  (2n, n) scaled versions -- transpose so each row is different undisturbed sigma point

        # 6d -> 7d
        X  = []
        for undisturbed_sigma_point in W:
            sigma_point = np.empty(previous_covariance.shape[0]+1)
            rotation_vector = undisturbed_sigma_point[:3]
            q = Quaternion()
            q.from_axis_angle(rotation_vector)
            sigma_point[:4] = np.array((previous_q * q).q)
            sigma_point[4:] = np.array(previous_angular) + undisturbed_sigma_point[3:]

            X.append(sigma_point)
        X = np.vstack(X)
        return X

    def calculate_mu_covariance(self, sigma_points):
        N = sigma_points.shape[0]
        
        angular_velocities = sigma_points[:, 4:]
        angular_mean = np.mean(angular_velocities, axis=0)
        
        q_est = Quaternion()
        q_est.q = np.copy(sigma_points[0, :4])
        q_est.normalize()
        
        epsilon = 1e-4 
        max_iterations = 100
        last_error_vectors = []
        
        for iteration in range(max_iterations):
            error_sum = np.zeros(3)
            current_error_vectors = []

            for i in range(N):
                q_i = Quaternion()
                q_i.q = np.copy(sigma_points[i, :4])
                q_i.normalize()
                q_inv = q_est.inv()
                e_i = q_i * q_inv
                e_i.normalize()
                error_vec = e_i.axis_angle()
                error_sum += error_vec
                current_error_vectors.append(error_vec)
            avg_error = error_sum / N
            
            last_error_vectors = current_error_vectors
            
            if np.linalg.norm(avg_error) < epsilon:
                break
            
            adj = Quaternion()
            adj.from_axis_angle(avg_error)
            q_est = adj * q_est
            q_est.normalize()
        
        mu = np.concatenate([q_est.q, angular_mean])

        W_prime = np.array([
            np.concatenate([last_error_vectors[i], sigma_points[i, 4:] - angular_mean])
            for i in range(N)
        ])
        
        cov = (W_prime.T @ W_prime) / W_prime.shape[0]

        return mu, cov, W_prime

    def predict(self, sigma_points, dt):

        Y = []
        for sigma_point in sigma_points:
            q_prev = sigma_point[:4]
            angular = sigma_point[4:]
            rotation_vector = angular * dt

            delta_q = Quaternion()
            delta_q.from_axis_angle(rotation_vector)

            q_next = Quaternion(q_prev[0], q_prev[1:4]) * delta_q
            Y.append(np.concatenate([q_next.q, angular]))

        return np.vstack(Y)

    def update(self, predicted_sigma_points, accel, gyro):
        n_sigma = predicted_sigma_points.shape[0]
        Z_accel = np.empty((n_sigma, 3))        

        angular_velocities = predicted_sigma_points[:, 4:]
        g = Quaternion(0, [0, 0, -9.81])
        quaternions = predicted_sigma_points[:, :4]

        Z_gyro = angular_velocities
        
        for i, q_arr in enumerate(quaternions):
            q = Quaternion(q_arr[0], q_arr[1:4])
            transformed_g = q * g * q.inv()
            Z_accel[i] = transformed_g.vec()

        z_accel_pred = np.mean(Z_accel, axis=0)
        z_gyro_pred = np.mean(Z_gyro, axis=0)

        z_measured = np.concatenate([accel, gyro])
        z_predicted = np.concatenate([z_accel_pred, z_gyro_pred])
        Z = np.hstack([Z_accel, Z_gyro])

        return z_measured, z_predicted, Z

    def predict_and_update(self, previous_mu, previous_covariance, dt, accel, gyro):

        # Create sigma points
        sigma_points = self.compute_sigma_points(previous_mu, previous_covariance)

        num_sigma_points = sigma_points.shape[0]

        # Propagate with state dynamics
        Y = self.predict(sigma_points, dt)

        predicted_mu, P_k_minus, W_prime = self.calculate_mu_covariance(Y)

        # Update with measurements
        z_measured, z_predicted, Z = self.update(Y, accel, gyro)


        # Combine measurements and predicted state
        innovation = z_measured - z_predicted

        Z_centered = Z - z_predicted

        P_zz = (Z_centered.T @ Z_centered) / Z.shape[0]
        P_vv = P_zz + self.measurement_covariance
        P_xz = (W_prime.T @ Z_centered) / Z.shape[0]

        kalman_gain = P_xz @ np.linalg.inv(P_vv)
        scaled_innovation = kalman_gain @ innovation

        rotation_vector = scaled_innovation[:3]
        angular_delta   = scaled_innovation[3:]

        delta_q = Quaternion()
        delta_q.from_axis_angle(rotation_vector)

        q_predicted_mu = Quaternion(predicted_mu[0], predicted_mu[1:4])
        q_updated = delta_q * q_predicted_mu
        q_updated.normalize()

        updated_mu = np.empty_like(predicted_mu)
        updated_mu[:4] = q_updated.q
        updated_mu[4:] = predicted_mu[4:] + angular_delta

        updated_covariance = P_k_minus - kalman_gain @ P_vv @ kalman_gain.T

        return updated_mu, updated_covariance