% 2023/2024 © Anssi Yli-Jyrä

p(1..p).
resource_model2 :- not resource_model3.
{ e(I,(C,Q),P) : p(P), expert(P,C) } = EN :-
   op(I,C,Q), expreq(C,EN), resource_model2.
:- e(I,(C1,Q),P), e(I,(C2,Q),P), C1 < C2.

% For each C with PN>EN>0 assign PN-EN other pros to op(I,C,Q)
{ o(I,(C,Q),P) : p(P), not e(I,(C,Q),P) } = PN-EN  :-   
    op(I,C,Q), expreq(C,EN), proreq(C,PN).
:- o(I,(C1,Q),P), o(I,(C2,Q),P), C1 <  C2.

% Check that nobody works in two roles at the same time
iso(I,Q,P) :- o(I,(C,Q),P).
:- iso(I,Q,P), e(I,(C,Q),P).


