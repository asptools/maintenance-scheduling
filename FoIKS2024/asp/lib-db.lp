% 2023/2024 © Anssi Yli-Jyrä

comp(1, 5,2).  durreq(1,2).  proreq(1,2).  expreq(1,1).
comp(2,10,0).  durreq(2,1).  proreq(2,2).  expreq(2,1).
comp(3, 7,0).  durreq(3,1).  proreq(3,1).  expreq(3,1).
comp(4, 4,3).  durreq(4,1).  proreq(4,1).  expreq(4,1).
comp(5, 9,0).  durreq(5,3).  proreq(5,2).  expreq(5,2).
comp(6,11,2).  durreq(6,2).  proreq(6,3).  expreq(6,3).
comp(7, 5,4).  durreq(7,1).  proreq(7,1).  expreq(7,1).
comp(8, 8,0).  durreq(8,1).  proreq(8,2).  expreq(8,2).
cost(1,5). expert(1, 1..8).  cost(2,2). expert(2, 2..6).
cost(3,0). expert(3, 7..8).  cost(4,2). expert(4, (1;4;7)).
cost(5,2). expert(5, (2;6)). cost(6,0). expert(6, (1;5)).
cost(7,2). expert(7, 6..8).  cost(8,0). expert(8, 4..5).
