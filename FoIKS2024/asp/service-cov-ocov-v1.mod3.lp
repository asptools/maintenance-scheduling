% Optimal allocation of service times for multi-component systems
% Simplified encoding

% 2022/2023/2024 © Tomi Janhunen, Anssi Yli-Jyrä, Masood Feyzbakhsh Rankooh

% Parameters 

#const h=32. #const l=h. 

time(0..h).
comp(C) :- comp(C,_,_).

% Break points and allocation of components for service

{ break(T): T=1..l } <= b.
{ serv(C,T): comp(C) } :- break(T).

% End of maintenance interval

emi(C,T+R)  :- serv(C,T), time(T+R), comp(C,R,_).
emi(C,L+1)  :- comp(C,R,L), L>0, time(L+1).

% Coverage and overcoverage (assuming R>0 and 0<=L<R for all components)
% The following rules are reformulated

cov(C,0)    :- comp(C,R,L), L>0.
cov(C,T+1)  :- not cov(C,T), serv(C,T+1), time(T+1).
cov(C,T+1)  :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
cov(C,T+1)  :- serv(C,T+1), emi(C,T+1), time(T+1).
ocov(C,T+1) :- cov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).
ocov(C,T+1) :- ocov(C,T), not emi(C,T+1), time(T+1).
cov(C,T+1)  :- ocov(C,T), emi(C,T+1), time(T+1).

#minimize {
  1@1,C,T: not cov(C,T), not ocov(C,T), comp(C), time(T), T>0; % Under coverage
  1@1,C,T: ocov(C,T), comp(C), time(T)                         % Over coverage
}.

