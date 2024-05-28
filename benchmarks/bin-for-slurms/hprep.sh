#! /bin/bash
cat > /tmp/$$.tmp
egrep 'comp\(' /tmp/$$.tmp | sed 's/$/ /;s/ /.\n/g'|egrep 'comp\(|info|horizon|max_breaks|dl\(b\(|servi'|
   sed 's/servi/hservi/;'
egrep -A1 ' Optimum|Time         :' /tmp/$$.tmp | egrep 'Optimization|CPU'|\
   sed 's/Optimization\s*:\s*/optimum\(/;s/CPU Time     : /time(/;s/\.0*/,/;s/s*$/)./;'
rm /tmp/$$.tmp

