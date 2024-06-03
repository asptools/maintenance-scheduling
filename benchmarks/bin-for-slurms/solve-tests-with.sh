#!/bin/bash

# 2022/2023/2024 © Janhunen, Tomi

DIR=$HOME/bench
BIN=$DIR/bin
IN=$DIR/in/$2
OUT=$DIR/out/$1/$2

# Check the "existence" of the solver pipeline and the benchmark

if test "$1" = ""
then
  echo "No solver specified!"
  echo "USAGE: $0 <solver> <instance directory>"
  exit -1
fi

if test "$2" = ""
then
  echo "No benchmark specified!"
  echo "USAGE: $0 <solver> <instance directory>"
  exit -1
fi

if test ! -d $IN
then
  echo "The input directory $IN does not exist!"
  echo "USAGE: $0 <solver> <instance directory>"
  exit -1
fi

if test ! -d $OUT
then
  echo "The output directory $OUT does not exist!"
  echo "USAGE: $0 <solver> <instance directory>"
  exit -1
fi

# Queue the benchmark instances for processing

for f in $IN/*.gz $IN/*.lp
do
  if test "$f" = $IN/'*.gz'
  then
    echo "Found no .gz file instances in $IN!"
    if test "$f" = $IN/'*.lp'
    then
	echo "Found no .lp instances in $IN!"
	exit -1    
    fi
  fi

  bn=`basename $f`
  fn=${bn%%.gz}
  target=$OUT/$fn.out

  # Run only if the output file does not exist
 
  if ! test -f $target
  then
    echo "Queuing $1 on $fn:"
    wd=`pwd`
    cd $OUT
    sbatch -p normal --time=00-09:15:00 --mem-per-cpu=16000 $DIR/bin/solve-test-with.sh $1 $f $target
    cd $wd
    $BIN/nanosleep 333333333
  else
    echo "Skipping $1 on $fn!"
  fi  
done
