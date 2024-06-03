#!/bin/bash

# 2022/2023/2024 © Janhunen, Tomi and Yli-Jyrä, Anssi

BIN=$HOME/bench/bin

# Wrapper for more exact timing a test run and selecting the pipeline

LIMIT=32800 # 2^15 seconds + 32 seconds grace time
ulimit -t $LIMIT

# Branch according to

case $1 in
clingodl)
	module load CMake/3.23.1-GCCcore-11.3.0
	cat $2  | sed 's/.mod/_mod/' \
       | /usr/bin/time --format="Runtime: %U" $BIN/clingo-dl - $BIN/serv-dl.lp --stats=3 --quiet=1,0;;
clingodl-h)
	module load CMake/3.23.1-GCCcore-11.3.0
	cat $2  | sed 's/.mod/_mod/' \
       | /usr/bin/time --format="Runtime: %U" $BIN/clingo-dl - $BIN/serv-dl-heur.lp --stats=3 --quiet=1,0;;
clingo-dl-two)
	module load CMake/3.23.1-GCCcore-11.3.0
	cat $2  | sed 's/.mod/_mod/' \
         | /usr/bin/time --format="Runtime: %U" $BIN/clingo-dl - $BIN/serv-dl-heur.lp --stats=3 --quiet=1,0 \
         | $BIN/hprep.sh \
         | /usr/bin/time --format="Runtime: %U" $BIN/clingo-dl - $BIN/serv-dl.lp $BIN/heur.lp --stats=3 --quiet=1,0;;
clasp) zcat $2 \
       | /usr/bin/time --format="Runtime: %U" $BIN/clasp --stats=3 --quiet=1,0;;
clasp-opt-usc) zcat $2 \
       | /usr/bin/time --format="Runtime: %U" $BIN/clasp --stats=3 --quiet=1,0 --opt-strat=usc;;
wasp-basic) zcat $2 \
       | /usr/bin/time --format="Runtime: %U" $BIN/wasp --stats=0 --weakconstraints-algorithm=basic;;
esac
