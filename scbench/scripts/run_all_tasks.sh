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


TASKS=("scbench_kv" "scbench_prefix_suffix" "scbench_vt" "scbench_repoqa" "scbench_qa_eng" "scbench_qa_chn" "scbench_choice_eng"  "scbench_many_shot" "scbench_summary" "scbench_mf" "scbench_summary_with_needles" "scbench_repoqa_and_kv")
#TASKS=("scbench_kv")
ATTN_KV_TYPES=(
    #"dense;streamingllm" "dense;snapkv" "dense;pyramidkv" "dense;kivi" # 2) KV Cache Compression Stage
    #"dense;quest" "a_shape;dense" "tri_shape;dense"  
    "minference;dense" 
)

# shellcheck disable=SC2068
for attn_kv_type in ${ATTN_KV_TYPES[@]}; do
IFS=';' read -r attn_type kv_type <<< "$attn_kv_type"
echo "attn_type: $attn_type, kv_type: $kv_type"
for task in ${TASKS[@]}; do
echo $task
python run_scbench.py \
    --task $task \
    --model_name_or_path meta-llama/Llama-3.1-8B-Instruct \
    --data_dir ./data \
    --output_dir ./results_original_full \
    --rewrite \
    --attn_type $attn_type \
    --kv_type $kv_type \
    --use_chat_template \
    --trust_remote_code 
done
done
