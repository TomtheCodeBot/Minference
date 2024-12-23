#!/bin/bash
#SBATCH -c 4 # request two cores 
#SBATCH -p preempt
#SBATCH -o log/jupyter.out
#SBATCH -e log/jupyter_error.out
#SBATCH --mem=100G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=-stream
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:a100:1


jupyter-notebook --no-browser --ip=0.0.0.0 --port 8888