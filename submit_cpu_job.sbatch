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

cd ~/SLURM-pyenv-handson/
srun python -u mat_inv_cpu.py