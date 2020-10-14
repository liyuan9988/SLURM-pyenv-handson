import numpy as np
import time

def cal_inverse(A):
    return np.linalg.inv(A)


if __name__ == "__main__":
    N = 5000 # size
    A = np.random.rand(N, N)
    time_start = time.time()
    A_inv = cal_inverse(A)
    time_end = time.time()

    elapsed_time = time_end - time_start  
    print('{:.5f} sec'.format(elapsed_time))