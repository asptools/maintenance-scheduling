#### Binaries and scripts for running experiments on a SLURM-based Linux cluster

Binaries for ASP solver technology.  These are compiled from external sources and included here.
No licenses are included here and these binaries are not covered by our license.  These compilations
are included just for tracking purposes.  They may also require dynamic libraries whose versions 
are to be documented.   
* clasp
* clingo-dl
* gringo
* wasp

Utilities
* nanosleep -- waits for a specified time, see [https://www.man7.org/linux/man-pages/man2/nanosleep.2.html]
* rename-slurm-outs.sh -- renames the outputs of SLURM batches according
  to the output name specified inside each output file

SLURM run scripts
* solve-test-with.sh -- Outputs run information to the sbatch output file and passes control
  to `timerun-solver-strat.sh` with solver name and grounded inputfile. 
* solve-tests-with.sh -- Sbatches a `solve-test-with.sh` run for a specified solver and all
  files in a specified benchmark directory with sbatch setting --mem-per-cpu=16000.
* timerun-solver-start.sh -- Based on the solver name, runs `time` with limited time 32800 secs.
  Loads module `load CMake/3.23.1-GCCcore-11.3.0` of dynamic C++ libraries in our local Linux
  cluster server to enable solvers to run.

Future/non-documented/under development
* serv-dl-heur.lp
* serv-dl.lp
* myqueue.sh
* igen
* heur.lp
* hprep.sh

Instructions for using the scripts are included to some of them.  More instructions are added on demand.
