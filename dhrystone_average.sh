#!/bin/bash

if [ -z "$1" ]; then
    echo "第一引数として実行する命令数を指定してくださいよー (5000, 50000, 500000, 10000000, 100000000, 1000000000)"
    exit 1
fi

# 結果を保存する配列
results=()

# logファイルの作成
mkdir -p logs
timestamp=$(date '+%Y%m%d_%H%M%S')
logfile="logs/x86-$1-$timestamp.log"

# Dhrystone を 3 回実行
for i in {1..5}; do
    # 実行結果を取得
    output=$(v2.1/dhrystone_loops_$1)
    echo "$output" >> "$logfile"
    
    # 値を抽出して配列に追加
    value=$(echo "$output" | grep "benchmarks at" | awk '{print $5}')
    results+=("$value")
    echo "Run $i: $value" | tee -a "$logfile"
done

# 合計を計算
sum=0
for val in "${results[@]}"; do
    sum=$((sum + val))
done

# 平均を計算
average=$((sum / ${#results[@]}))

# 結果を表示
echo "Average: $average" | tee -a "$logfile"