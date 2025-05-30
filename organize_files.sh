#!/bin/bash

# 스크립트 실행 중 오류가 발생하면 바로 중단합니다.
set -e

echo " reorganizing files in LLM_AstarwithGraph..."

# 1. 새 폴더 구조 생성 (이미 존재하면 생성하지 않음)
echo " creating new directory structure..."
mkdir -p src
mkdir -p data
mkdir -p test
mkdir -p gnn
mkdir -p experiments
mkdir -p result

# 함수: 파일/디렉토리 이동 (소스가 존재할 경우에만 실행)
move_item() {
  local source_item="$1"
  local destination_item="$2"
  if [ -e "$source_item" ]; then
    mv "$source_item" "$destination_item"
    echo "  Moved: $source_item -> $destination_item"
  else
    echo "  Skipped (not found): $source_item"
  fi
}

# 2. src 폴더로 파일 이동
echo " moving files to src/ ..."
move_item "Experiments/Experiments_LLM_Astar(FewShot).py" "src/Experiments_LLM_Astar_FewShot.py"
move_item "Experiments/Experiments_LLM_Astar(CoT).py" "src/Experiments_LLM_Astar_CoT.py"
move_item "Experiments/graph_to_prompt.py" "src/graph_to_prompt.py"
move_item "preprocess/data.ipynb" "src/preprocess_data.ipynb"
move_item "LLM A*/graph.ipynb" "src/llm_astar_graph.ipynb"
move_item "grid_based_LLM_astar/grid.ipynb" "src/grid_based_llm_astar.ipynb"

# 3. data 폴더로 파일 이동 (기존 data 폴더 내 파일은 유지)
echo " moving files to data/ ..."
move_item "graphs/large_scale_graph.json" "data/large_scale_graph.json"
move_item "graphs/small.json" "data/small.json"
move_item "graphs/graph_1.json" "data/graph_1_from_graphs_folder.json" # 이름 변경하여 충돌 방지
move_item "graphs/sejong_bus.json" "data/sejong_bus.json"
move_item "LLM A*/graph_1.json" "data/graph_1_from_LLM_A_star.json" # 이름 변경

# 4. test 폴더로 파일 이동
echo " moving files to test/ ..."
move_item "Experiments/test_eunho.ipynb" "test/test_eunho.ipynb"
move_item "Experiments/test.ipynb" "test/test.ipynb"
move_item "Experiments/asdf.ipynb" "test/asdf.ipynb"
move_item "prior_test/large_scale_graph.ipynb" "test/prior_large_scale_graph.ipynb"
move_item "prior_test/graph.ipynb" "test/prior_graph.ipynb"
move_item "prior_test/smal_scale_graph.ipynb" "test/prior_small_scale_graph.ipynb" # 이름 변경됨
move_item "prior_test/grid.ipynb" "test/prior_grid.ipynb"
move_item "LLM A*/grid.ipynb" "test/llm_astar_grid_test.ipynb"
move_item "figures/configure2.ipynb" "test/figures_configure2.ipynb"

# 5. gnn 폴더로 파일 이동
echo " moving files to gnn/ ..."
move_item "prior_test/GraphSAGE.ipynb" "gnn/GraphSAGE.ipynb"

# 6. experiments 폴더로 파일 이동
echo " moving files to experiments/ ..."
move_item "Experiments/experiments.ipynb" "experiments/experiments.ipynb"
move_item "Experiments/aggregation.ipynb" "experiments/aggregation.ipynb"
move_item "Experiments/graph_to_prompt.ipynb" "experiments/graph_to_prompt_notebook.ipynb"
move_item "Experiments/prompt.txt" "experiments/prompt.txt"

# 7. result 폴더로 파일 이동
echo " moving files to result/ ..."
# Experiments/Result/final 내부 파일 먼저 이동
move_item "Experiments/Result/final/A_star.json" "result/final_A_star.json"
move_item "Experiments/Result/final/LLM_A_star_fewshot.json" "result/final_LLM_A_star_fewshot.json"
# Experiments/Result 내부 파일 이동
move_item "Experiments/Result/LLM_A_star_CoT.json" "result/LLM_A_star_CoT.json"
move_item "Experiments/Result/A_star.json" "result/A_star.json"
move_item "Experiments/Result/LLM_A_star_fewshot.json" "result/LLM_A_star_fewshot.json"
# Experiments 루트의 결과 파일 이동
move_item "Experiments/checking_edges.json" "result/checking_edges.json"
move_item "Experiments/checking_edges1.json" "result/checking_edges1.json"
move_item "Experiments/checking_edges2.json" "result/checking_edges2.json"
move_item "Experiments/checking_edges_astar.json" "result/checking_edges_astar.json"
move_item "Experiments/temp.json" "result/temp.json"
move_item "Experiments/sejong_map.html" "result/sejong_map.html"

# 8. 기존 폴더들 삭제 (내용물이 모두 옮겨졌다고 가정)
# 주의: 이 명령어는 폴더와 그 내용을 강제로 삭제합니다.
echo " removing old directories..."
rm -rf "Experiments/Result/final" # Result/final 폴더 먼저 삭제
rm -rf "Experiments/Result"      # Result 폴더 삭제
rm -rf "Experiments"
rm -rf "LLM A*"
rm -rf "figures"
rm -rf "graphs"
rm -rf "grid_based_LLM_astar"
rm -rf "preprocess"
rm -rf "prior_test"

echo " file organization complete!"
echo " please check the new directory structure."
