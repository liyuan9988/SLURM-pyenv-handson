import cupy as cp
import time

def cal_inverse(A):
    return cp.linalg.inv(A)


if __name__ == "__main__":
    N = 5000 # size
    A = cp.random.rand(N, N)
    cp.cuda.Stream.null.synchronize()
    time_start = time.time()
    A_inv = cal_inverse(A)
    cp.cuda.Stream.null.synchronize()
    time_end = time.time()

    elapsed_time = time_end - time_start  
    print('{:.5f} sec'.format(elapsed_time))