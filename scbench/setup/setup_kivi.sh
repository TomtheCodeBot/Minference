#!/bin/bash
#SBATCH -c 4 # request two cores 
#SBATCH -p laolab
#SBATCH -o logs/sweet_phi.out
#SBATCH -e logs/error_sweet_phi.out
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=sweet_phi
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:l40s:1
git clone https://github.com/jy-yuan/KIVI.git /tmp/KIVI
cd /tmp/KIVI
pip install -e . --no-build-isolation --no-deps
cd quant && pip install -e .
