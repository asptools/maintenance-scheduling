## Pruning Redundancy in Answer Set Optimization Applied to Preventive Maintenance Scheduling

#### How to Cite

Anssi Yli-Jyrä, Masood Feyzbakhsh Rankooh, Tomi Janhunen: [Pruning Redundancy in Answer Set Optimization Applied to Preventive Maintenance Scheduling](https://link.springer.com/chapter/10.1007/978-3-031-24841-2_18). Practical Aspects of Declarative Languages - 25th International Symposium, [PADL 2023](https://popl23.sigplan.org/home/PADL-2023), Boston, MA, USA, January 16-17, 2023, Proceedings.  Lecture Notes in Computer Science 13880, Springer 2023, pages 279-294.

#### Abstract

Multi-component machines deployed, e.g., in paper and steel industries, have complex physical and functional dependencies between their components. This profoundly affects how they are maintained and motivates the use of logic-based optimization methods for scheduling preventive maintenance actions. Recently, an abstraction of maintenance costs, called miscoverage, has been proposed as an objective function for the preventive maintenance scheduling (PMS) of such machines. 

Since the minimization of miscoverage has turned out to be a computationally demanding task, the current paper studies ways to improve its efficiency. 
- Given different answer set optimization encodings of the PMS problem, we motivate constraints that prune away some sub-optimal and otherwise redundant or invalid schedules from the search space.
- Our experimental results show that these constraints may enable up to ten-fold speed-ups in scheduling times, thus pushing the frontier of practically solvable PMS problem instances to longer timelines and larger machines.
  
#### The Encodings 

The paper recalls four prior encodings from the RuleML2023 paper as the baseline.  The paper introduces also a new baseline encoding 'Mixed Encoding'.

- service-scnt-v1.lp - 'Elevator Encoding' 
- service-cov-v1.lp  - '2-Level (compact) Encoding' 
- service-cov-ocov-v1.lp  -  '2-Level Encoding'
- service-cov-mixed-v1.lp - 'Mixed Encoding'
- service-direct-cov-v1.lp - '1-Level Encoding' 

The paper presents five modified encodings that have pruning constraints.

- service-cov-v1.mod3.lp
- service-scnt-v1.mod3.lp
- service-cov-ocov-v1.mod3.lp
- service-cov-mixed-v1.mod3.lp
- service-direct-cov-v1.mod3.lp

#### The Differences between the Encodings

The differences between the baseline and the new encodings of three kinds:
1. bug fixes,
2. optimizations of the rules of the baseline encodings, and
3. pruning constraints.

##### Bug fixes
   
##### Optimizations of the rules of the baseline encodings

cov(C,0) :- comp(C,R,L), L>0.
cov(C,T+1)  :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
ocov(C,T+1) :- cov(C,T),     serv(C,T+1), not emi(C,T+1), time(T+1).

cov(C,T+1)  :- not cov(C,T), serv(C,T+1), [ not ocov(C,T),  not emi(C,T+1)], time(T+1).
                             
cov(C,T+1) :- serv(C,T+1), emi(C,T+1), time(T+1), [ cov(C,T) ].

cov(C,T+1) :- ocov(C,T), [ not serv(C,T+1),]      emi(C,T+1), time(T+1).

ocov(C,T+1)   :- ocov(C,T), [ not serv(C,T+1),]  not emi(C,T+1), time(T+1).

[ ocov(C,T+1) :- ocov(C,T),       serv(C,T+1),       emi(C,T+1), time(T+1). ]

##### Pruning constraints

