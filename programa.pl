% Se cumple para los jugadores.
% jugador(Jugador).
% Ejemplo:
jugador(rojo).
jugador(azul).
jugador(amarillo).
jugador(verde).
jugador(blanco).

% Relaciona un país con el continente en el que está ubicado,
% ubicadoEn(Pais, Continente).
% Ejemplo:
ubicadoEn(argentina, americaDelSur).
ubicadoEn(brasil, americaDelSur).
ubicadoEn(colombia, americaDelSur).
ubicadoEn(peru, americaDelSur).
ubicadoEn(uruguay, americaDelSur).
ubicadoEn(italia, europa).
ubicadoEn(portugal, europa).
ubicadoEn(grecia, europa).
ubicadoEn(alemania, europa).
ubicadoEn(holanda, europa).
ubicadoEn(belgica, europa).
ubicadoEn(china, asia).
ubicadoEn(japon, asia).
ubicadoEn(corea, asia).
ubicadoEn(australia, oceania).




% Relaciona dos jugadores si son aliados.
%aliados(UnJugador, OtroJugador).
% Ejemplo:
aliados(rojo, amarillo).
aliados(azul, amarillo).
aliados(verde, azul).

% Relaciona un jugador con un país en el que tiene ejércitos.
% ocupa(Jugador, Pais).
% Ejemplo:
ocupa(rojo, argentina).
ocupa(rojo, colombia).
ocupa(rojo, china).
ocupa(rojo, belgica).
ocupa(azul, italia).
ocupa(azul, japon).
ocupa(amarillo, portugal).
ocupa(amarillo, brasil).
ocupa(amarillo, australia).
ocupa(verde, grecia).
ocupa(verde, alemania).
ocupa(verde, holanda).
ocupa(blanco, uruguay).
ocupa(blanco, peru).


% Relaciona dos países si son limítrofes.
% limitrofes(UnPais, OtroPais).
% Ejemplo:
limitrofes(argentina, brasil).
limitrofes(colombia, brasil).
limitrofes(alemania, italia).
limitrofes(italia, grecia).
limitrofes(holanda, alemania).

tienePresencia(Jugador, Continente):-
    ocupa(Jugador, Pais),
    ubicadoEn(Pais, Continente).

puedenAtacarse(UnJugador, OtroJugador):-
    ocupa(UnJugador, Pais),
    ocupa(OtroJugador, OtroPais),
    limitrofes(Pais, OtroPais),
    UnJugador \= OtroJugador.

sinTensiones(UnJugador, OtroJugador):-
    aliados(UnJugador, OtroJugador).
sinTensiones(UnJugador, OtroJugador):-
    jugador(UnJugador), jugador(OtroJugador),
    not(puedenAtacarse(UnJugador, OtroJugador)).

perdio(Jugador):-
    jugador(Jugador),
    not(ocupa(Jugador, _)).

controla(Jugador, Continente):-
    jugador(Jugador), ubicadoEn(_, Continente),
    forall(ubicadoEn(Pais, Continente), ocupa(Jugador, Pais)).

renido(Continente):-
    ubicadoEn(_, Continente),
    forall((jugador(Jugador), not(perdio(Jugador))), (ocupa(Jugador, Pais), ubicadoEn(Pais, Continente))).  

atrincherado(Jugador):-
    jugador(Jugador), ubicadoEn(_, Continente),
    forall(ocupa(Jugador, Pais), ubicadoEn(Pais, Continente)). 

puedeConquistar(Jugador, Continente):-
    not(controla(Jugador, Continente)),
    forall((ubicadoEn(Pais, Continente), not(ocupa(Jugador, Pais))), puedeAtacar(Jugador, Pais)).

puedeAtacar(Jugador, PaisAtacado):-
    limitrofes(PaisAtacado, PaisPropio),
    ocupa(Jugador, PaisPropio),   
    not((aliados(Jugador, OtroJugador), ocupa(OtroJugador, PaisAtacado))).

