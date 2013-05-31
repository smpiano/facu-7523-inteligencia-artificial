domains
    reina=integer
    tablero=reina*
    
predicates

    nondeterm nreinas(reina, tablero).
    nondeterm generarTablero(reina, tablero).
    nondeterm permutar(tablero, tablero).
    nondeterm buenTablero(tablero).
    nondeterm seleccionar(tablero, reina, tablero).
    nondeterm amenaza(reina, reina).

    
clauses

    nreinas(N,Sol):- generarTablero(N,Tablero), permutar(Tablero,Sol), buenTablero(Sol).
    
    generarTablero(0,[]).
    generarTablero(X,[X|R]):- XMenos1 is X - 1, XMenos1 >= 0, generarTablero(XMenos1,R).
    
    permutar([],[]).
    permutar(X,[C|Z]) :- seleccionar(X,C,R), permutar(R,Z).
    
    seleccionar([X|R],X,R).
    seleccionar([C|R],X,[C|Y]) :- seleccionar(R,X,Y).
    
    buenTablero([]).
    buenTablero([C|R]):- not(amenaza(C,R)),
    buenTablero(R).

    amenaza(X,Prof,[C|_]):- X is C+Prof; X is C-Prof; X = C.
    amenaza(X,Prof,[_|R]):- ProfMas1 is Prof + 1,
    amenaza(X,ProfMas1,R).

    amenaza(_,[]):- !.
    amenaza(X,Y):- amenaza(X,1,Y).


goal

    nreinas(8,Sol).