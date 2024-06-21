%%%% Reglas compuestas que relacionan hortalizas, terrenos y estaciones %%%%


% terreno_estacion_hortaliza(Terreno, Estacion, Hortaliza)
%   afirma si se puede plantar la hortaliza en el terreno, en esa estación
terreno_estacion_hortaliza(Terreno, Estacion, Hortaliza) :- 
    terreno_estacion_agua_temperatura_dias(Terreno, Estacion, AguaTerreno, MinTerreno, MaxTerreno, DiasTerreno),
    hortaliza_agua_temperatura_dias(Hortaliza, AguaHortaliza, MinHortaliza, MaxHortaliza, DiasHortaliza),
    AguaTerreno >= AguaHortaliza,
    MinTerreno >= MinHortaliza,
    MaxTerreno =< MaxHortaliza.


% terreno_estacion_hortaliza_riego(Terreno, Estacion, Hortaliza, Riego)
%   deduce cuanto riego se necesita para plantar la hortaliza en el terreno, en esa estación
terreno_estacion_hortaliza_riego(Terreno, Estacion, Hortaliza, Riego) :- 
    terreno_estacion_agua(Terreno, Estacion, AguaTerreno),
    hortaliza_agua(Hortaliza, AguaHortaliza),
    Riego is max(AguaHortaliza - AguaTerreno, 0).


%%%% Planificación de cultivos %%%%


% hortalizas_dias(Hortalizas, Dias)
%   deduce cuantos días ocupan las hortalizas dadas
hortalizas_dias([], 0).
hortalizas_dias([Hortaliza | Hortalizas], Dias) :- 
    hortaliza_dias(Hortaliza, DiasHortaliza),
    hortalizas_dias(Hortalizas, DiasResto),
    Dias is DiasHortaliza + DiasResto.


% dias_hortalizas_caben(Dias, Hortalizas)
%   deduce las diferentes combinaciones de hortalizas que caben en una cantidad de días
dias_hortalizas_caben_asistente(Dias, [], Acomulador).
dias_hortalizas_caben_asistente(Dias, [Hortaliza | Hortalizas], Acomulador) :-
    hortaliza_dias(Hortaliza, DiasHortaliza),
    AcomuladorSiguiente is Acomulador + DiasHortaliza,
    AcomuladorSiguiente =< Dias,
    dias_hortalizas_caben_asistente(Dias, Hortalizas, AcomuladorSiguiente).

dias_hortalizas_caben(Dias, Hortalizas) :- dias_hortalizas_caben_asistente(Dias, Hortalizas, 0).


% estaciones_dias(Estaciones, Dias)
%   deduce cuantos días ocupan las estaciones dadas
estaciones_dias([], 0).
estaciones_dias([Estacion | Estaciones], Dias) :- 
    estacion_dias(Estacion, DiasEstacion),
    estaciones_dias(Estaciones, DiasResto),
    Dias is DiasEstacion + DiasResto.


% terreno_estacion_hortalizas(Terreno, Estacion, Hortalizas)
%   afirma si se pueden plantar las hortalizas en el terreno, en la estación especificada
terreno_estacion_hortalizas(Terreno, Estacion, []).
terreno_estacion_hortalizas(Terreno, Estacion, [Hortaliza | Hortalizas]) :- 
    terreno_estacion_hortaliza(Terreno, Estacion, Hortaliza),
    terreno_estacion_hortalizas(Terreno, Estacion, Hortalizas).


% terreno_estaciones_hortalizas(Terreno, Estaciones, Hortalizas)
%   afirma si se pueden plantar las hortalizas en el terreno, en todas estaciones especificadas
terreno_estaciones_hortalizas(Terreno, [], Hortalizas).
terreno_estaciones_hortalizas(Terreno, [Estacion | Estaciones], Hortalizas) :- 
    terreno_estacion_hortalizas(Terreno, Estacion, Hortalizas),
    terreno_estaciones_hortalizas(Terreno, Estaciones, Hortalizas).


% terreno_estaciones_dias_hortalizas_caben(Terreno, Estaciones, Dias, Hortalizas)
%   deduce las diferentes combinaciones de hortalizas que se pueden plantar
%   en el terreno, en esas estaciones, en esa cantidad de días
terreno_estaciones_dias_hortalizas_caben(Terreno, Estaciones, Dias, Hortalizas) :-
    dias_hortalizas_caben(Dias, Hortalizas),
    terreno_estaciones_hortalizas(Terreno, Estaciones, Hortalizas).


% terreno_estaciones_hortalizas_caben(Terreno, Estaciones, Hortalizas)
%   deduce las diferentes combinaciones de hortalizas que se pueden plantar
%   en el terreno, en esas estaciones, en la duración de las estaciones
terreno_estaciones_hortalizas_caben(Terreno, Estaciones, Hortalizas) :-
    estaciones_dias(Estaciones, Dias),
    terreno_estaciones_dias_hortalizas_caben(Terreno, Estaciones, Dias, Hortalizas).


% no_caben_mas_hortalizas(Terreno, Estaciones, Dias, Hortalizas)
%   afirma si no caben más hortalizas en el terreno, en esas estaciones, en esa cantidad de días
no_caben_mas_hortalizas(Terreno, Estaciones, Hortalizas) :-
    estaciones_dias(Estaciones, Dias),
    hortalizas_dias(Hortalizas, DiasOcupados),
    DiasLibres is Dias - DiasOcupados,
    not(terreno_estaciones_dias_hortalizas_caben(Terreno, Estaciones, DiasLibres, [_])).


% terreno_estaciones_hortalizas_caben(Terreno, Estaciones, Hortalizas)
%   deduce las diferentes combinaciones de hortalizas que se pueden plantar
%   en el terreno, en esas estaciones, en la duración de las estaciones
%   sin dejar huecos donde se podrian plantar más hortalizas
terreno_estaciones_hortalizas_caben_sin_huecos(Terreno, Estaciones, Hortalizas) :-
    terreno_estaciones_hortalizas_caben(Terreno, Estaciones, Hortalizas),
    no_caben_mas_hortalizas(Terreno, Estaciones, Hortalizas).
