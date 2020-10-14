#!/bin/bash
#SBATCH --job-name=cpujob_test
#SBATCH --output=cpu_job.%A.out
#SBATCH --time=0-12:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --partition=cpu

source ~/.bash_profile  # activate pyenv

cd ~/SLRUM-pyenv-handson
srun python mat_inv_cpu.py