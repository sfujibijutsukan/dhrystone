#!/bin/bash

# 結果を保存する配列
results=()

# Dhrystone を 3 回実行
for i in {1..5}; do
    # 実行結果を取得
    output=$(v2.1/dhrystone_arm)
    
    # 値を抽出して配列に追加
    value=$(echo "$output" | grep "benchmarks at" | awk '{print $5}')
    results+=("$value")
    echo "Run $i: $value"
done

# 合計を計算
sum=0
for val in "${results[@]}"; do
    sum=$((sum + val))
done

# 平均を計算
average=$((sum / ${#results[@]}))

# 結果を表示
echo "Average: $average"