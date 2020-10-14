#!/bin/bash
#SBATCH --job-name=gpujob
#SBATCH --output=gpu_job.%A.out
#SBATCH --time=0-1:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --partition=gpu --gres=gpu:gtx1080:1

#module avail
#printenv
module load cuda/10.1
source ~/.bash_profile  # for pyenv



cd ~/SLURM-pyenv-handson/
srun python -u mat_inv_gpu.py