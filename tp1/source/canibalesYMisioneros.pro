domains

;estado=estado(integer,integer,symbol)
;lestados=estado*

predicates

;nondeterm mover(estado,estado).
;nondeterm verificar(integer,integer).
;nondeterm verificar1(integer,integer).
;nondeterm pp(estado,estado,integer,lestados,lestados).
;nondeterm perte(estado,lestados).


clauses

;mover(estado(MI1,CI1,izq),estado(MI2,CI1,der)) :- MI1 >= 2 , MI2 = MI1 -2, verificar(MI2,CI1).
;mover(estado(MI1,CI1,izq),estado(MI1,CI2,der)) :- MI1 >= 2 , CI2 = CI1 -2, verificar(MI1,CI2).
;mover(estado(MI1,CI1,izq),estado(MI2,CI1,der)) :- MI1 >= 2 , MI2 = MI1 -1, verificar(MI2,CI1).
;mover(estado(MI1,CI1,izq),estado(MI1,CI2,der)) :- MI1 >= 2 , CI2 = CI1 -1, verificar(MI1,CI2).
;mover(estado(MI1,CI1,izq),estado(MI2,CI2,der)) :- MI1 >= 2, CI2 = CI1 -1,MI2 = MI1 -1, verificar(MI1,CI2).

;mover(estado(MI1,CI1,der),estado(MI2,CI1,izq)) :- MI1 >= 2 , MI2 = MI1 -2, verificar(MI2,CI1).
;mover(estado(MI1,CI1,der),estado(MI1,CI2,izq)) :- MI1 >= 2 , CI2 = CI1 -2, verificar(MI1,CI2).
;mover(estado(MI1,CI1,der),estado(MI2,CI1,izq)) :- MI1 >= 2 , MI2 = MI1 -1, verificar(MI2,CI1).
;mover(estado(MI1,CI1,der),estado(MI1,CI2,izq)) :-  MI1 >= 2 , CI2 = CI1 -1, verificar(MI1,CI2).
;mover(estado(MI1,CI1,der),estado(MI2,CI2,izq)) :- MI1 >= 2, CI2 = CI1 -1,MI2 = MI1 -1, verificar(MI1,CI2).
;verificar(MI,CI) :- verificar1(MI,CI),MD=3 - MI, CD = 3-CI, verificar1(MD,CD).
;verificar1(M,C) :- M >= C.
;verificar1(0,_).

;pp(E,E,_,_,[E]):- !. /*determina que reglas aplica y en que orden*/
;pp(EI,EF,N,YV,[EI|Can]):- N > 0 , mover(EI,E2) , not (perte(E2,YV)) , N1 = N - 1, pp(E2,EF,N1,[E2|YV],Can).
;perte(Ya, [Ya|_]).
;perte(Elemento, [_|Co]):- perte (Elemento, Co).

goal

;pp(estado(3,3,izq),estado(0,0,der),20,[estado(3,3,izq)],Can).
