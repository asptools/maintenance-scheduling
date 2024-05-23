md5("59c6fe22a558d468499b83d225c169a0"). #show md5/1. % tail +2 thisfile | md5 
% Optimal allocation of service times for multi-component systems
%
% (c) 2022 Tomi Janhunen

% Parameters

#const b=10.
#const c=1.
#const h=32.
#const l=32.

time(1..h).
comp(C) :- comp(C,_,_).

% Break points and allocation of components for service

{ break(T): time(T), T>0, T<=l } <= b.
c <= { serv(C,T): comp(C) } :- break(T).

% Coverage reformulated (assuming R>0 and 0<=L<R for all components)

cov(C,T)    :- time(T),              comp(C,R,L), T=1..L.              # Direct 1
cov(C,T)    :- time(T), serv(C,T1),  comp(C,R,_), T=T1..T1+R-1.        # Direct 2
ocov(C,T+1) :- time(T+1),     serv(C,T+1), not emi(C,T+1),  cov(C,T).  # Increment
ocov(C,T+1) :- time(T+1), not serv(C,T+1), not emi(C,T+1), ocov(C,T).  # Inertia 1
ocov(C,T+1) :- time(T+1),     serv(C,T+1),     emi(C,T+1), ocov(C,T).  # Inertia 2

% Deny triple overlaps

% :- ocov(C,T), ocov(C,T+1), serv(C,T+1).

:- ocov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).

% End of service period neded for triple overlaps
emi(C,T+R) :- serv(C,T), time(T+R), comp(C,R,L).
emi(C,L+1) :- comp(C,R,L), time(L+1), L>0.        % For lifetime L


% :- cov(C,T,S1), cov(C,T,S2), cov(C,T,S3), S1<S2, S2<S3.
% :- 3 <= #count{ S: cov(C,T,S) }, comp(C), time(T).

% Optimization

#const oc=0.
#const se=0.

#minimize {
            1@1,C,T: not cov(C,T), comp(C), time(T);    % Under coverage
            1@1,C,T: ocov(C,T), comp(C), time(T), oc=1; % Over coverage
            1@0,C,T: serv(C,T), se=1                    % Service events
          }.

#show break/1.
#show serv/2.
#show cov/2.
#show ocov/2.

% Check components

error(C) :- comp(C,R,L), R<=0.
error(C) :- comp(C,R,L), L>=R.

#show error/1.

