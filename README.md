# SLURM-pyenv-handson

We use the job scheduler called SLURM in Gatsby cluster computer. This is a hands-on tutorial of how to submit jobs written in python to SLURM.

## Set up a virtual environment with pyenv 

Although Python is pre-installed in the system, the version is old and it is not recommended to install 3rd-party libraries to the system Python. Instead, I recommend using [pyenv](https://github.com/pyenv/pyenv) and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) to create Python environment.

Run following
```[bash]
source install_pyenv.sh
```
and pyenv and pyenv-virtualenv will be installed. If they are installed successfully, you can install any version of Python by executing

```[bash]
pyenv install 3.8.3
```

The version `3.8.3` above can be changed to any other versions, or you can install [anaconda](https://www.anaconda.com/) if you want. (Run `pyenv install --list` for the list of installable versions.) After installing a Python, I recommend to set it as a default python version. This can be done by
```[bash]
pyenv global 3.8.3
```

## Create a virtual environment using pyenv-virtualenv

I recommend using virtualenv, which enables us to separate all dependencies from project to project. In order to create an empty environment, execute

```[bash]
pyenv virtualenv 3.8.3 hands-on
pyenv local hands-on
```
which creates empty virtualenv called `hands-on` and activate it whenever you enter the directory. Then, you can install dependencies by
```[bash]
pip install -r requirements.txt
```

## Submit multi-cpu jobs

Here, we test running code with SLURM. I prepare the code to calculate the inverse of a large random matrix:

```[python]
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
```
This is implemented in `mat_inv_cpu.py`. We can submit a job to SLURM by writing the following batch file `submit_cpu_job.sbatch`

```
#!/bin/bash
#SBATCH --job-name=cpujob_test
#SBATCH --output=cpu_job.%A.out
#SBATCH --time=0-1:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --partition=cpu

#module avail
#printenv
source ~/.bash_profile  # activate pyenv

cd ~/SLURM-pyenv-handson/
srun python -u mat_inv_cpu.py
```
Refer to [detailed introduction page](https://github.com/jamenendez11/Gatsby-Cluster-Tutorial) for the meaning of each options. We can submit the job by running
```
sbatch submit_cpu_job.sbatch
```
The text output will be found `cpu_job.%A.out` with `%A` replaced with the job number assigned to this job. The result should be around 14 seconds. Now, we can increase the number of cpus by
```
sbatch --cpus-per-task=5 submit_cpu_job.sbatch
```
You can change `--cpus-per-task` option in sbatch file to increase cpu number as well. Now the result should be around 10 seconds. 

## Submit gpu jobs
Now we test to accelerate code using gpu. I re-implement the previous code using [cupy](https://github.com/cupy/cupy).
```
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
```
The batch file should be changed to `submit_gpu_job.sbatch` so that it uses gpus

```
#!/bin/bash
#SBATCH --job-name=gpujob
#SBATCH --output=gpu_job.%A.out
#SBATCH --time=0-1:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --partition=gpu --gres=gpu:1

#module avail
#printenv
module load cuda/10.1
source ~/.bash_profile  # for pyenv



cd ~/SLURM-pyenv-handson/
srun python -u mat_inv_gpu.py
```
The information of specifying gpu versions can be found in [SWC computation wiki](https://wiki.ucl.ac.uk/display/SSC/High-Performance+Computing).

You can submit a job by running
```
sbatch submit_gpu_job.sbatch
```


## Reference
- [More Detailed Introduction to SLURM](https://github.com/jamenendez11/Gatsby-Cluster-Tutorial)  
- [SWC computation wiki](https://wiki.ucl.ac.uk/display/SSC/High-Performance+Computing)
- [pyenv github page](https://github.com/pyenv/pyenv)
- [pyenv-virtualenv github page](https://github.com/pyenv/pyenv-virtualenv)