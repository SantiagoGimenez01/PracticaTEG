%%                                              PRACTICA 1
/*
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

*/

%%                                              PRACTICA 2
continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

%% Parte A

%% Punto 1
loLiquidaron(Jugador):-
    jugador(Jugador),
    not(ocupa(_, Jugador, _)).
%% Punto 2
ocupaContinente(Jugador, Continente):-
    jugador(Jugador), continente(Continente), 
    forall(estaEn(Continente, Pais), ocupa(Pais, Jugador, _)).
%% Punto 3
seAtrinchero(Jugador):-
    jugador(Jugador), continente(Continente),
    forall(ocupa(Pais, Jugador, _), estaEn(Continente, Pais)).  

%% Parte B

%% Punto 4
puedeConquistar(Jugador, Continente):-
    jugador(Jugador), continente(Continente), not(ocupaContinente(Jugador, Continente)),
    forall((estaEn(Continente, Pais), not(ocupa(Pais, Jugador, _))), puedeAtacar(Jugador, Pais)).
puedeAtacar(Jugador, Pais):-
    ocupa(SuPais, Jugador, _),
    sonLimitrofes(SuPais, Pais),
    ocupa(Pais, OtroJugador, _),
    not(aliados(Jugador, OtroJugador)).
%% Punto 5
elQueTieneMasEjercitos(Jugador, Pais):-
    jugador(Jugador), ocupa(Pais, Jugador, Ejercito),
    forall((ocupa(OtroPais, _, Ejercitos), Pais \= OtroPais), Ejercito > Ejercitos).
%% Punto 6
objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)).

cumpleObjetivos(Jugador):-
    jugador(Jugador),
    forall(objetivo(Jugador, ocuparContinente(Continente)), ocupaContinente(Jugador, Continente)),
    forall(objetivo(Jugador, destruirJugador(Oponente)), loLiquidaron(Oponente)),
    forall(objetivo(Jugador, ocuparPaises(Cantidad, Continente)),
        (continente(Continente), findall(Pais, (estaEn(Continente, Pais), ocupa(Pais, Jugador, _)), Paises),
         length(Paises, CantidadOcupados), CantidadOcupados >= Cantidad )).

leInteresa(Jugador, Continente):-
    objetivo(Jugador, Objetivo),
    continenteObjetivo(Objetivo, Continente).

continenteObjetivo(ocuparContinente(Continente), Continente).

continenteObjetivo(ocuparPaises(_, Continente), Continente).

continenteObjetivo(destruirJugador(Oponente), Continente):-
    ocupa(Pais, Oponente, _), estaEn(Continente, Pais).

