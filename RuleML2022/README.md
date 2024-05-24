## Applying Answer Set Optimization to Preventive Maintenance Scheduling for Rotating Machinery

##### How to Cite

Anssi Yli-Jyrä, Tomi Janhunen: [Applying Answer Set Optimization to Preventive Maintenance Scheduling for Rotating Machinery](https://link.springer.com/chapter/10.1007/978-3-031-21541-4_1). Rules and Reasoning - 6th International Joint Conference on Rules and Reasoning, [RuleML+RR 2022](https://2022.declarativeai.net/events/ruleml-rr), Berlin, Germany, September 26-28, 2022, Proceedings. Lecture Notes in Computer Science 13752, Springer 2022, pages 3-19.

##### Abstract

Preventive maintenance (PM) of manufacturing units aims at maintaining the operable condition of the production line while optimizing the maintenance timing and the loss of productivity during maintenance operations. The lesser-studied type of preventive maintenance understands a production line as a single machine with multiple components of different maintenance needs. 

- This is relevant when rotating machinery is deployed, e.g., in the paper and steel industries, in the mass production of raw materials consumed by other businesses.
- A failure in any stage of the production line has the potential of making the entire machine inoperable and enforcing a shutdown and corrective maintenance costs.

Contributions: 

1. This work gives an abstract formalization of PM scheduling for multi-component machines as an optimization problem.  To provide a lower bound for the complexity of the optimization problem, we prove that the underlying decision problem is NP-complete for varying-size multi-component machines and scheduling timelines.
2. Besides the formalization, the second main contribution of the paper is due to the practical need to solve the problem in industrial applications: the work gives the first encoding of the PM scheduling problem using Answer Set Optimization (ASO). Some preliminary experiments are conducted and reported to set the scene for further algorithm development.


## The First Encoding(s)

Although the abstract mentions the first encoding for the PM scheduling problem, the paper contains four related encodings.  These baseline encodings are:

- `service-scnt-v1.lp` - 'Elevator Encoding' -- This encoding is a planning-type encoding where every time step has a state that tells how many maintenance operations are covering the time step. 
- `service-cov-v1.lp`  - '2-Level (compact) Encoding' -- This encoding is a similar encoding that does not store a state when no maintenance operation covers the time step.
- `service-cov-ocov-v1.lp`  -  '2-Level Encoding' -- This encoding does not use a state counter but rather just two predicates, cov and ocov telling whether the timestep is covered once or twice. 
- `service-direct-cov-v1.lp` - '1-Level Encoding' -- This encoding has two predicates cov and ocov, but it is not based on information propagation but rather on direct consequences from the servicing and interval lengths.  The cov predicate holds for timesteps that are covered once or twice, thus the state space is partitioned differently than in other encodings.

The following table is the comparison of the PADL2023 encodings.   In addition, the Mixed Encoding published later in PADL2023 as `service-coc-mixed-v1.lp` is also included as `service-coc-mixed-v2.lp` (with slight changes) in the table.

<table>
  <tr>
    <th></th>
    <th>Elevator Encoding</th>
    <th>Compact Encoding</th>
    <th>2-Level Encoding</th>
    <th>Mixed Encoding</th>
    <th>1-Level Encoding</th>
  </tr>
  <tr>
    <th>Under-coverage</th>
    <td>scnt(C,T,0)</td>
    <td>not cov(C,T,1), not cov(C,T,2)</td>
    <td>not cov(C,T), not ocov(C,T)</td>
    <td>not cov(C,T)</td>
    <td>not cov(C,T)</td>
  </tr>
  <tr>
    <th>Coverage</th>
    <td>scnt(C,T,1)</td>
    <td>cov(C,T,1)</td>
    <td>cov(C,T)</td>
    <td>cov(C,T), not ocov(C,T)</td>
    <td>cov(C,T), not ocov(C,T)</td>
  </tr>
    <tr>
    <th>Over-coverage</th>
    <td>scnt(C,T,2)</td>
    <td>cov(C,T,2)</td>
    <td>ocov(C,T)</td>
    <td>cov(C,T), ocov(C,T)</td>
    <td>cov(C,T), ocov(C,T)</td>
  </tr>
    <tr>
    <th>Time steps</th>
    <td>time(0..h)</td>
    <td>time(0..h)</td>
    <td>time(0..h)</td>
    <td>time(1..h)</td>
    <td>time(1..h)</td>
  </tr>
    <tr>
    <th>cov(C,0)</th>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td>comp(C,R,L), L>0</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>Direct cov(C,T)</th>
    <td></td>
    <td></td>
    <td></td>
    <td>comp(C,R,L), T=1..L
      <hr/>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
    <td>comp(C,R,L), T=1..L
      <hr/>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
  </tr>
    <tr>
    <th>Increment 0 to 1</th>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,0)</td>
    <td>serv(C,T+1), not emi(C,T+1), not cov(C,T,1), not cov(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), not cov(C,T), not ocov(C,T)</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>Increment 1 to 2</th>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,1)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T,1)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T)</td>
    <td>cov(C,T,S1), cov(C,T,S2), S1>S2</td>
  </tr>
    <tr>
    <th>Decrement 1 to 0</th>
    <td>emi(C,T), not serv(C,T), scnt(C,T-1,N), N=1</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>Decrement 2 to 1</th>
    <td>emi(C,T+1), not serv(C,T+1), scnt(C,T,N), N=2</td>
    <td>emi(C,T+1), not serv(C,T+1), cov(C,T,2)</td>
    <td>emi(C,T+1), not serv(C,T+1), ocov(C,T)</td>
    <td></td>
    <td></td>
  </tr>
    <tr>
    <th>Inertia of under-coverage</th>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,V), V=0</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
    <td>n/a</td>
  </tr>
    <tr>
    <th>Inertia of single coverage</th>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,N), N=1
    <hr>serv(C,T+1), emi(C,T+1), scnt(C,T,N), N=1</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T,N), N=1
    <hr>serv(C,T+1), emi(C,T+1), cov(C,T,N), N=1</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T)
    <hr>serv(C,T+1), emi(C,T+1), cov(C,T)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
    <td>serv(C,T1), T=T1..T1+R-1, comp(C,R,_)</td>
  </tr>
    <tr>
    <th>Inertia of over-coverage</th>
    <td>not serv(C,T+1), not emi(C,T+1), scnt(C,T,N), N=2
      <hr/>serv(C,T+1), emi(C,T+1), scnt(C,T,N), N=2</td>
    <td>not serv(C,T+1), not emi(C,T+1), cov(C,T,N), N=2
      <hr/>serv(C,T+1), emi(C,T+1), cov(C,T,N), N=2</td>
    <td>not serv(C,T+1), not emi(C,T+1), ocov(C,T)
      <hr>serv(C,T+1), emi(C,T+1), ocov(C,T)</td>
    <td>not serv(C,T+1), not emi(C,T+1), ocov(C,T)
      <hr/>serv(C,T+1), emi(C,T+1), ocov(C,T)</td>
    <td>cov(C,T,S1), cov(C,T,S2), S1>S2</td>
  </tr>
    <tr>
    <th>Constraint for 3-fold coverage</th>
    <td>serv(C,T+1), not emi(C,T+1), scnt(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), cov(C,T,2)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
    <td>serv(C,T+1), not emi(C,T+1), ocov(C,T)</td>
  </tr>
</table>

* For easier comparison, the following changes have been made.  In Elevator Encoding, the predicate symbols dec/2 and inc/2 have been replaced with predicate symbols emi/2 and serv/2.  Predicate `emi` has been defined by

  ```
  emi(C,T+R) :- time(T+R), serv(C,T), comp(C,R,L), time(T+R).
  emi(C,L+1) :- time(L+1), comp(C,R,L), L>0. 
  ```

In the 1- to 2-fold coverage increments of Mixed encoding, the condition `not ocov(C,T)` has been dropped as redundant.  There is the constraint that blocks increments from 2- to 3-fold coverage. 
  
Furthermore, the new encoding (Mixed Encoding) in this table differs from `service-cov-mixed-v1.lp` slightly.  The changed new encoding is stored as the file `service-cov-mixed-v2.lp`.  None of the encodings has been included in the tests of the paper and the changed encoding `service-cov-mixed-v2.lp` has not been included in the tests of the follow-up paper in PADL2023.   The changed encoding is likely to be an improvement.
 
