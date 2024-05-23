### Pruning-Modified Encodings for Preventive Maintenance Encoding

#### How to Cite

...

#### Errata to the Prior Art Encodings 

- service-cov-ocov.lp  -  '2-Level Encoding' 
- service-cov.lp  - '2-Level (compact) Encoding' 
- service-direct-cov.lp - '1-Level Encoding' 
- service-scnt.lp - 'Elevator Encoding' 

#### Simplications to the Prior Art Encodings

cov(C,0) :- comp(C,R,L), L>0.
cov(C,T+1)  :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
ocov(C,T+1) :- cov(C,T),     serv(C,T+1), not emi(C,T+1), time(T+1).

cov(C,T+1)  :- not cov(C,T), serv(C,T+1), [ not ocov(C,T),  not emi(C,T+1)], time(T+1).
                             
cov(C,T+1) :- serv(C,T+1), emi(C,T+1), time(T+1), [ cov(C,T) ].

cov(C,T+1) :- ocov(C,T), [ not serv(C,T+1),]      emi(C,T+1), time(T+1).

ocov(C,T+1)   :- ocov(C,T), [ not serv(C,T+1),]  not emi(C,T+1), time(T+1).

[ ocov(C,T+1) :- ocov(C,T),       serv(C,T+1),       emi(C,T+1), time(T+1). ]


#### New baseline encodings

- 'Mixed Encoding' service-cov-mixed.lp

#### The Modified Encodings

These corresponding encodings have pruning constrains

- service-cov-ocov-v1.mod3.lp
- service-cov-v1.mod3.lp
- service-direct-cov-v1.mod3.lp
- service-scnt-v1.mod3.lp
- service-cov-mixed-v1.mod3.lp

#### References

...
