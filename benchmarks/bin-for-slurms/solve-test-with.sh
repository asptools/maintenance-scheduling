#!/bin/bash

# 2022/2023/2024 © Janhunen, Tomi

BIN=$HOME/bench/bin

#SBATCH -p normal
#SBATCH --time=00-09:15:00
#SBATCH --mem-per-cpu=16000

DIR=$HOME/bench

lscpu | fgrep 'Model name:'
echo "Solver: $1"
echo "Input: $2"
echo "Output: $3"
echo "Started at: "`date`
echo "---"

$BIN/timerun-solver-strat.sh $1 $2
