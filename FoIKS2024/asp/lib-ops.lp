% Assumes q, s/2, durreq/2, i/1, proreq/2. Provides: op/3.
% Choose one time slice to start each operation
resource_model1 :- not resource_model2, not resource_model3.
slice(1..q).
{ opstarts(I,C,Q) : slice(Q), slice(Q+D-1) } = 1 :- s(I,C), durreq(C,D).

% Reserve the track from the starting slice to the slice of completion  
op(I,C,J) :- opstarts(I,C,Q), durreq(C,D), J=Q..Q+D-1.

% Limit the tracks during any given slice
:- i(I), slice(Q), t < #count{ C : op(I,C,Q) }.

% Limit the professionals during any given slice
p(I,Q,M) :- i(I), slice(Q), M = #sum{ P,C: op(I,C,Q), proreq(C,P) }.
:- i(I), slice(Q), p(I,Q,P), p < P.
