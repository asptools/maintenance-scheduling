
echo "Table 1. The effect of hard constraints on miscoverage"
echo
echo
echo
echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t3 q4 p5 yes      26  26     26"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t3 q4 p4 yes      27 UNSAT  UNSAT"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t3 q4 p4 no       27  54     54"
echo "----------------------------------------"
  clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
  clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
  clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=3 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t2 q4 p5 no       31  31     31"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=4 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=4 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=4 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t2 q4 p4 no       31  55     55"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=4 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t2 q3 p4 no       54  77     69"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t2 q3 p3 no       74  83     83"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=3 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=3 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=3 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t2 q2 p2 no       124 140    140"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=2 -cp=2 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=2 -cp=2 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=2 -cp=2 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t1 q1 p1 no       206 206    206"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=1 -cq=1 -cp=1 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=1 -cq=1 -cp=1 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=1 -cq=1 -cp=1 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Core  b  t  q  p  Pruned?  RM1 RM2    RM3"
echo "26    b7 t0 q0 p0 no       245 245    245"
echo "----------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=0 -cq=0 -cp=0 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=0 -cq=0 -cp=0 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=0 -cq=0 -cp=0 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp | egrep 'Optimization :|usage|UNSATISFIABLE'


echo
echo
echo "Table 2. Automatic parameter optimization in cost-based integration"
echo
echo

echo
echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "Core   7 7 7 5       7 0 0 0  870 (26∗20+(7+0+0+0)∗50+0)          26"
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=7 -cq=7 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "RM1    7 7 7 5       7 2 5 4 1420 (26∗20+(7+2+5+4)∗50+0)          26"
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=7 -cq=7 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "RM2    7 7 7 5       7 2 5 4 1535 (26∗20+(7+2+5+4)∗50+115)        26"
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=7 -cq=7 -cp=5 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "RM3    7 7 7 5       7 2 5 4 1535 (26∗20+(7+2+5+4)∗50+115)        26"
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "RM1    7 2 3 4       7 2 3 4 1880 (54∗20+(7+2+3+4)∗50+0)          54"
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "RM2    7 2 3 4       7 2 3 4 2403 (79∗20+(7+2+3+4)∗50+23)         79" 
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'

echo
echo "Model  b t q p  Used b t q p Cost (mc*20+resources*50+salaries)   Mc."
echo "RM3    7 2 3 4       7 2 3 4 2261 (69∗20+(7+2+3+4)∗50+81)         69"
echo "---------------------------------------------------------------------"
clingo -W no-atom-undefined --quiet=1,0 -t 8 -cb=7 -ct=2 -cq=3 -cp=4 lib-db.lp lib-golden.lp service-cov-ocov-v1.mod3.lp interface.lp lib-ops.lp lib-cmp.lp lib-dyn.lp lib-itg.lp | egrep 'Optimization :|usage|UNSATISFIABLE'
