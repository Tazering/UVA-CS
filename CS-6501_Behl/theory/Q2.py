import numpy as np

# declare variables
k_alpha = {}
best_location = {}
smoothing = {}

def main():

    pi = np.array([.5, .5])
    T = np.array([[.5, .5],[.5, .5]])
    M = np.array([[.4, .1, .5],[.1, .5, .4]])
    Y = np.array([2, 0, 0, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 0, 0, 1]) # 0 - LA, 1 - NY, 2 - null

    # compute the alphas
    forward_algorithm(pi, T, M, Y)

    # compute the betas
    k_beta = backward_algorithm(T, M, Y, 19)

    evidence = (k_beta[0][0] * pi[0] * M[0][Y[0]]) + (k_beta[0][1] * pi[1] * M[1][Y[0]])

    for i in range(20):
        # compute for each state
        # find most likely location
        possible_states = []

        for state in range(2):
            result = (k_beta[i][state] * k_alpha[i][state]) / evidence
            possible_states.append(result)

        smoothing[i] = possible_states

        if possible_states[0] > possible_states[1]:
            best_location[i] = "LA"
        else:
            best_location[i] = "NY"
        
    update_transition_matrix(k_beta, T, M, Y)
    
    # print(smoothing)
    # convert_dict_to_latex(dictionary = smoothing)


# forward algorithm
def forward_algorithm(pi, T, M, Y):

    k = len(Y)
    num_states = 2

    # 1. initialize ================
    alpha = []
    first_obs = Y[0]

        # loop through each states for initialization
    for i in range(num_states):
        init_alpha = pi[i] * M[i][first_obs]
        alpha.append(init_alpha)
    
    k_alpha[0] = np.array(alpha)


    # 2. compute ===================
    for i in range(k - 1): # loop through iterations; i
        summation = 0
        alpha = []
        
        for state in range(num_states): # loop through states; x
            M_x_y_next = M[state][Y[i + 1]]
            sum = (k_alpha[i][0] * T[0][state]) + (k_alpha[i][1] * T[1][state])

            alpha.append(M_x_y_next * sum)

        k_alpha[i + 1] = np.array(alpha)


# backward algorithm
def backward_algorithm(T, M, Y, t):

    k_beta = {}

    num_states = 2

    # 1. initialize ==========
    k_beta[t] = np.array([1, 1])

    # 2. compute =============
    for k in range(t - 1, -1, -1): # loop through k = t - 1
        beta = []

        for state in range(num_states): # loop through states, x
            sum = (k_beta[k + 1][0] * T[state][0] * M[0][Y[k + 1]]) +  (k_beta[k + 1][1] * T[state][1] * M[1][Y[k + 1]])
            beta.append(sum)

        k_beta[k] = beta

    return k_beta


def convert_dict_to_latex(dictionary):
    latex_command = "\\begin{center}\nTable \\ref{beta_table} has all the beta values.\\\\\n\\label{beta_table}\n\\begin{tabular}{| c | c | c |}\n\\hline"
    latex_command = latex_command + "\nt & LA & NY\\\\\n\\hline\\hline\n"

    for key in dictionary.keys():
        val = dictionary[key]

        latex_command = latex_command + f"{key + 1} & {round(val[0], 4)} & {round(val[1], 4)}\\\\\n\\hline\n"

    latex_command = latex_command + "\\end{tabular}\n\\end{center}"

    print(latex_command)

def update_transition_matrix(k_beta, T, M, Y):
    
    numLN = 0
    numLL = 0 
    numNN = 0 
    numNL = 0
    denL = 0
    denN = 0

    totalLN = 0
    totalLL = 0
    totalNN = 0
    totalNL = 0

    sum_num_dict = {}

    for i in range(1, 20):
        numLN = (k_alpha[i-1][0] * T[0][1] * M[1][Y[i]] * k_beta[i][1])
        numLL = (k_alpha[i-1][0] * T[0][0] * M[0][Y[i]] * k_beta[i][0])
        numNN = (k_alpha[i-1][1] * T[1][1] * M[1][Y[i]] * k_beta[i][1])
        numNL = (k_alpha[i-1][1] * T[1][0] * M[0][Y[i]] * k_beta[i][0])

        sum_num_dict[i] = numLN + numLL + numNN + numNL

        totalLN += numLN / sum_num_dict[i]
        totalNN += numNN / sum_num_dict[i]
        totalLL += numLL / sum_num_dict[i]
        totalNL += numNL / sum_num_dict[i]

    for i in range(19):
        denL += smoothing[i][0]
        denN += smoothing[i][1]

    
    new_T = np.zeros(shape = (2, 2))

    new_T[0][0] = totalLL / denL
    new_T[0][1] = totalLN / denL
    new_T[1][0] = totalNL / denN
    new_T[1][1] = totalNN / denN

    print(new_T)
    
    

# def convert_dict_to_latex(dictionary):
#     latex_command = "\\begin{center}\nTable \\ref{beta_table} has all the beta values.\\\\\n\\label{beta_table}\n\\begin{tabular}{| c | c | c |}\n\\hline"
#     latex_command = latex_command + "\nt & LA & NY\\\\\n\\hline\\hline\n"

#     key_list = np.array([])
#     for key in dictionary.keys():
#         key_list = np.append(key_list, key)
    
#     key_list = np.flip(key_list)

#     for key in key_list:
#         val = dictionary[key]

#         latex_command = latex_command + f"{key + 1} & {val[0]} & {val[1]}\\\\\n\\hline\n"

#     latex_command = latex_command + "\\end{tabular}\n\\end{center}"

#     print(latex_command)

main()