md5("3e8889fc3b8601090fc654c1db1c7735"). #show md5/1. % tail +2 thisfile | md5
% Optimal allocation of service times for multi-component systems
%
% (c) 2022 Tomi Janhunen

% Parameters

#const b=3.
#const c=1.
#const h=32.
#const l=32.

time(0..h).
comp(C) :- comp(C,_,_).

% Break points and allocation of components for service

{ break(T): time(T), T>0, T<=l } <= b.
c <= { serv(C,T): comp(C) } :- break(T).

% Allowance

% has_allowed :- allowed(_).
% :- break(T), not allowed(T), has_allowed.

% Increasing/decreasing the count of (simultaneous) servicing

inc(C,T) :- serv(C,T).
dec(C,T+R) :- serv(C,T), comp(C,R,_), time(T+R).
dec(C,L+1) :- comp(C,R,L), 0<L, time(L+1).        % For lifetime L

scnt(C,0,0) :- comp(C,R,0).
scnt(C,0,1) :- comp(C,R,L), 0<L.                  % For lifetime L
val(0..2).

scnt(C,T,V+1) :- inc(C,T), not dec(C,T), scnt(C,T-1,V),    % Increase
	         comp(C), time(T), val(V), val(V+1).

scnt(C,T,V-1) :- not inc(C,T), dec(C,T), scnt(C,T-1,V),    % Decrease
	         comp(C), time(T), val(V), val(V-1).

scnt(C,T,V) :- scnt(C,T-1,V), not inc(C,T), not dec(C,T),  % Inertia 1
               comp(C), time(T), val(V), time(T-1).

scnt(C,T,V) :- scnt(C,T-1,V), inc(C,T), dec(C,T),          % Inertia 2
               comp(C), time(T), val(V), time(T-1).

% The all-zero condition

% allz(T) :- scnt(C,T,0): comp(C); time(T), T>0.
% :- allz(T), not allz(T+1), time(T), T>0, time(T+1).

% :- scnt(C,T,0), T>0, scnt(C,T+1,V), V>0, time(T+1).
% :- scnt(C,T,0), T>0, break(T).

% Deny triple overlaps

:- scnt(C,T,2), serv(C,T+1), not dec(C,T+1), time(T+1).

% Constrain overlapping services (the component is being over serviced)
%
%:- scnt(C,T,2), inc(C,T+1). % No triple overlaps
%% % :- scnt(C,T,2), inc(C,T). % No over service at all

% Lower and upper bounds (on under-service penalty)

#const lb=0.
#const ub=0.

:- #sum { 1,C,T: scnt(C,T,0) } < lb, lb > 0.
:- #sum { 1,C,T: scnt(C,T,0) } > ub, ub > 0.

% Optimization

#const se=0.
#const oc=0.

#minimize {
            1@1,C,T: scnt(C,T,0), T>0;
                                % time(T), not allz(T); % Under-coverage
            1@1,C,T: scnt(C,T,2), oc=1;                 % Over-coverage
            1@0,C,T: serv(C,T), se=1                    % Service events
           }.  

% #minimize { -(R-A),C,0: comp(C,R,A), 0<A, A<R;            % Recently serviced
%             1,C,T: scnt(C,T,2);                           % Overlap penalty
%             t,C: comp(C);                                 % Overall penalty
%             -R,C,T: inc(C,T), comp(C,R,_);                % Serviced
%             T+R-1-t,C: serv(C,T), comp(C,R,_), T+R-1>t}.  % Correction to -R

lb(lb) :- lb>0.
ub(ub) :- ub>0.

#show break/1.
#show serv/2.
#show lb/1.
#show ub/1.
% #show inc/2.
% #show dec/2.
#show scnt/3.
