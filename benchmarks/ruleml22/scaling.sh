#!/bin/bash

# Remember to comment the sample machine out from service-cov-ocov.lp

for n in `seq 1 16`
  do for i in `seq 1 10`
    do r=$RANDOM
    echo "=== $n $i ($r) ==="
    gringo -cn=$n ../machgen.lp | clasp --seed=$r --rand-freq=0.2 \
    | fgrep comp | asf \
    | gringo -coc=0 -cb=8 - ../service-cov-ocov.lp \
    | clasp --time-limit=1200 --opt-strat=usc --quiet=1,0
  done
done | tee scaling.out
