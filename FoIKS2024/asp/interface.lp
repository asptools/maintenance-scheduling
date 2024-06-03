% 2023/2024 © Anssi Yli-Jyrä

% Assumes b, comp/3, break/1, serv/2; Provides i/1, c/1, s/2, oc/2, uc/2.

_______usage(("b","t","q","p"),(b,t,q,p)).
#show _______usage/2.
#show resource_model1/0.
#show resource_model2/0.
#show resource_model3/0.

% Identities of breaks

i(1..b).

% Components

c(C) :- comp(C,_,_).

% Compute indices for breaks from break(T) instances

tb(0,0).
tb(T,B+1) :- tb(T-1,B), break(T), time(T), T>0, i(B+1).
tb(T,B) :- tb(T-1,B), not break(T), time(T).

% Extract the index for each break

breakid(T,I) :- tb(T,I), break(T), i(I).

% From serv(C,T) to s(I,C) via breakid(T,I)

s(I,C) :- serv(C,T), breakid(T,I).

% uc and oc

uc(C,T) :- not cov(C,T), not ocov(C,T), comp(C), time(T), T>0.
oc(C,T) :- ocov(C,T), comp(C), time(T).

% Filter

%#show i/1.
%#show c/1.
%#show s/2.

