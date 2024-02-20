md5("d546be36efbd47ddc74d9a681742cb8e"). #show md5/1. % tail +2 thisfile | md5
% Optimal allocation of service times for multi-component systems
%
% (c) 2022 Tomi Janhunen

% Parameters

#const b=10.
#const c=1.
#const h=32.
#const l=32.

time(0..h).
comp(C) :- comp(C,_,_).

% Break points and allocation of components for service

{ break(T): time(T), T>0, T<=l } <= b.
c <= { serv(C,T): comp(C) } :- break(T).

% End of maintenance interval

emi(C,T+R) :- serv(C,T), time(T+R), comp(C,R,_).
emi(C,L+1) :- comp(C,R,L), L>0, time(L+1).

% Coverage reformulated (assuming R>0 and 0<=L<R for all components)

cov(C,0) :- comp(C,R,L), L>0.

cov(C,T+1) :- not cov(C,T), not ocov(C,T),
	      serv(C,T+1), not emi(C,T+1), time(T+1).
cov(C,T+1) :- cov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
cov(C,T+1) :- cov(C,T), serv(C,T+1), emi(C,T+1), time(T+1).
ocov(C,T+1) :- cov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).

ocov(C,T+1) :- ocov(C,T), not serv(C,T+1), not emi(C,T+1), time(T+1).
ocov(C,T+1) :- ocov(C,T), serv(C,T+1), emi(C,T+1), time(T+1).
cov(C,T+1) :- ocov(C,T), not serv(C,T+1), emi(C,T+1), time(T+1).

% Deny triple overlaps

:- ocov(C,T), serv(C,T+1), not emi(C,T+1), time(T+1).

% Optimization

#const oc=0.
#const se=0.

#minimize {
            1@1,C,T: not cov(C,T), not ocov(C,T),
	             comp(C), time(T), T>0; % Under coverage
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

