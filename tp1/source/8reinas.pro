% Defino el dominio
domains

    % Represento a la reina por medio de su posición en la columna
    reina=integer
    
    % El tablero es una lista de n elementos con los naturales de 1 a n 
    % donde cada elemento especifica la columna que ocupa la reina en el 
    % tablero, y la fila se especifica por el orden del elemento en la lista.
    tablero=reina*
    
    
% Defino los predicados
predicates
    
    % Devuelve un tablero solución del problema de la amenaza entre las reinas de 
    % un tablero de ajedrez de tamaño dimension [reina].
    nondeterm nreinas(reina, tablero).
    
    % Verifica si el tablero solución es una lista de elementos que contiene los naturales 
    % comprendidos entre 1 y dimension del mismo [reina], ambos inclusive.
    nondeterm generarTablero(reina, tablero).
    
    % Verifica si la primer tabla es una permutación de los elementos de la segunda.
    nondeterm permutar(tablero, tablero).
    
    % Indica si existe alguna reina que amenace a otra.
    nondeterm buenTablero(tablero).
    
    % Verifica si la reina está en la primer tabla y
    % si la segunda tabla es la primer lista sin la reina.
    nondeterm seleccionar(tablero, reina, tablero).
    
    % Indica si una reina ubicada en la columna [reina] y fila n del tablero amenaza
    % a las demás reinas del tablero.
    nondeterm amenaza(reina, tablero).
    nondeterm amenaza(reina, reina, tablero).
    
clauses

    % Genera un tablero de tamaño dimensión, permuta y obtiene una solucion al problema de las 8 reinas.
    nreinas(Dimension,Solucion):- generarTablero(Dimension,Tablero), permutar(Tablero,Solucion), buenTablero(Solucion).
    
    % Caso en que el tablero tenga dimension 0, el tablero es vacío.
    generarTablero(0,[]).
    % Caso en que el tablero tenga una dimension > 0, genera filas y columnas.
    generarTablero(Dimension,[Dimension|Columnas]):- DimensionAnterior = Dimension - 1, DimensionAnterior >= 0, generarTablero(DimensionAnterior,Columnas).
    
    % Permutación de un tablero vacío, es un tablero vacío.
    permutar([],[]).
    % Se selecciona el primer valor de la lista y se permuta con la cola.
    permutar(Tablero,[SolCabecera|SolCola]):- seleccionar(Tablero,SolCabecera,R), permutar(R,SolCola).
    
    % Verifica si X es el primer elemento de la primer lista y R siendo 
    % la cola de la primer lista es igual a la segunda lista.
    seleccionar([X|R],X,R).
    % Verifica si los primeros elementos de las listas son iguales y verifica si 
    % las colas de las listas seleccionan a X.
    seleccionar([C|R],X,[C|Y]):- seleccionar(R,X,Y).
    
    % Tablero vacío es considerado buen tablero porque no se amenazan reinas.
    buenTablero([]).
    % Un buen tablero se considera si no hay reina que amenace a otras.
    buenTablero([C|R]):- not(amenaza(C,R)), buenTablero(R).

    % Verifica si X es la cabecera + Profundidad o X es la cabecera - Profundidad o X es la cabecera.
    amenaza(X,Profundidad,[C|_]):- X = C+Profundidad; X = C-Profundidad; X = C.
    % Incrementa la Profundidad y verifica la amenaza sobre la reina.
    amenaza(X,Profundidad,[_|R]):- ProfundidadSiguiente = Profundidad + 1, amenaza(X,ProfundidadSiguiente,R).
    
    % En caso que la lista sea vacía, no hay amenaza.
    amenaza(_,[]):- fail.
    % Verifico la amenaza entre las listas a partír de la posición 1.
    amenaza(X,Y):- amenaza(X,1,Y).
    

goal

    % Ejecución del problema de las 8 reinas.
    nreinas(8, Solucion).