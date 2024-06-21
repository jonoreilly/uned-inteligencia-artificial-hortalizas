%%%% Conocimientos %%%%

% Donosti
% https://www.timeanddate.com/weather/spain/san-sebastian/climate


% precipitación en 1_000 m3 por ha normalizado para 1 año
% 1 mm = 10 m3/ha
% precipitación normalizada para 1 año en 1_000 m3 por ha = 4 * 10 * Xmm / 1_000
terreno_estacion_agua(donosti, invierno, 22.4). % 561,7 mm
terreno_estacion_agua(donosti, primavera, 15). % 375,1 mm
terreno_estacion_agua(donosti, verano, 11.6). % 292,2 mm
terreno_estacion_agua(donosti, otoño, 19.5). % 487,7 mm


% temperatura mínima y máxima en °C
terreno_estacion_temperatura(donosti, invierno, 6, 13).
terreno_estacion_temperatura(donosti, primavera, 7, 18).
terreno_estacion_temperatura(donosti, verano, 14, 23).
terreno_estacion_temperatura(donosti, otoño, 9, 22).


% Vitoria
% https://www.timeanddate.com/weather/spain/vitoria-gasteiz/climate


% precipitación en 1_000 m3 por ha normalizado para 1 año
% 1 mm = 10 m3/ha
% precipitación normalizada para 1 año en 1_000 m3 por ha = 4 * 10 * Xmm / 1_000
terreno_estacion_agua(vitoria, invierno, 9.86). % 246,5 mm
terreno_estacion_agua(vitoria, primavera, 7.6). % 191,8 mm
terreno_estacion_agua(vitoria, verano, 4.4). % 110,2 mm
terreno_estacion_agua(vitoria, otoño, 8). % 202,1 mm


% temperatura mínima y máxima en °C
terreno_estacion_temperatura(vitoria, invierno, 1, 11).
terreno_estacion_temperatura(vitoria, primavera, 3, 20).
terreno_estacion_temperatura(vitoria, verano, 11, 27).
terreno_estacion_temperatura(vitoria, otoño, 4, 23).


%%%% Consulta agrupada de conocimientos %%%%

terreno_estacion_agua_temperatura_dias(Terreno, Estacion, Agua, Min, Max, Dias) :-
    terreno_estacion_agua(Terreno, Estacion, Agua),
    terreno_estacion_temperatura(Terreno, Estacion, Min, Max),
    estacion_dias(Estacion, Dias).

%%%% Añadir y borrar terrenos %%%%

:- dynamic terreno_estacion_agua/3.
:- dynamic terreno_estacion_temperatura/4.


% borrar_terreno_estacion(Terreno, Estacion)
%   borra la temperatura y precipitación de un terreno en la estación especificada
borrar_terreno_estacion(Terreno, Estacion) :-
    retractall(terreno_estacion_agua(Terreno, Estacion, _)),
    retractall(terreno_estacion_temperatura(Terreno, Estacion, _, _)).


% borrar_terreno(Terreno)
%   borra la temperatura y precipitación de un terreno para todas las estaciones
borrar_terreno(Terreno) :-
  borrar_terreno_estacion(Terreno, _).


% añadir_terreno_estacion(Terreno, Estacion, Agua, Min, Max)
%   añade o sobreescribe la temperatura y precipitación de un terreno en la estación especificada
añadir_terreno_estacion(Terreno, Estacion, Agua, Min, Max) :-
    borrar_terreno_estacion(Terreno, Estacion),
    assertz(terreno_estacion_agua(Terreno, Estacion, Agua)),
    assertz(terreno_estacion_temperatura(Terreno, Estacion, Min, Max)).


% añadir_terreno_estacion(Terreno, Agua[4], Min[4], Max[4])
%   añade o sobreescribe la temperatura y precipitación de un terreno para todas las estaciones
añadir_terreno(Terreno, [AguaInvierno, AguaPrimavera, AguaVerano, AguaOtoño], [MinInvierno, MinPrimavera, MinVerano, MinOtoño], [MaxInvierno, MaxPrimavera, MaxVerano, MaxOtoño]) :-
    añadir_terreno_estacion(Terreno, invierno, AguaInvierno, MinInvierno, MaxInvierno),
    añadir_terreno_estacion(Terreno, primavera, AguaPrimavera, MinPrimavera, MaxPrimavera),
    añadir_terreno_estacion(Terreno, verano, AguaVerano, MinVerano, MaxVerano),
    añadir_terreno_estacion(Terreno, otoño, AguaOtoño, MinOtoño, MaxOtoño).