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
python run_scbench.py \
    --task scbench_kv \
    --model_name_or_path meta-llama/Llama-3.1-8B-Instruct \
    --data_dir ./data \
    --output_dir ./results \
    --rewrite \
    --attn_type dense \
    --kv_type dense \
    --use_chat_template \
    --trust_remote_code
