%%%% Conocimientos %%%%

% https://data.4tu.nl/datasets/7b45bcc6-686b-404d-a910-13c87156716a

% requerimientos de agua en 1_000 m3 por ha por año
hortaliza_agua(tomate, 13).
hortaliza_agua(cebolla, 6).
hortaliza_agua(zanahoria, 4).
hortaliza_agua(patata, 5).


% https://www.homefortheharvest.com/soil-temperature-for-planting-vegetables-chart/
% https://www.researchgate.net/figure/Temperature-thresholds-for-selected-vegetable-crops-35_tbl1_323419311

% temperatura mínima y máxima tolerables en °C
hortaliza_temperatura(tomate, 12, 30).
hortaliza_temperatura(cebolla, 7, 30).
hortaliza_temperatura(zanahoria, 7, 29).
hortaliza_temperatura(patata, 5, 26).


% tiempo de crecimiento en dias
hortaliza_dias(tomate, 85).
hortaliza_dias(cebolla, 120).
hortaliza_dias(zanahoria, 40).
hortaliza_dias(patata, 120).


%%%% Consulta agrupada de conocimientos %%%%

hortaliza_agua_temperatura_dias(Hortaliza, Agua, Min, Max, Dias) :-
    hortaliza_agua(Hortaliza, Agua),
    hortaliza_temperatura(Hortaliza, Min, Max),
    hortaliza_dias(Hortaliza, Dias).


%%%% Añadir y borrar hortalizas %%%%

:- dynamic hortaliza_agua/2.
:- dynamic hortaliza_temperatura/3.
:- dynamic hortaliza_dias/2.


borrar_hortaliza(Hortaliza) :-
    retractall(hortaliza_agua(Hortaliza, _)),
    retractall(hortaliza_temperatura(Hortaliza, _, _)),
    retractall(hortaliza_dias(Hortaliza, _)).


% añadir_hortaliza(Hortaliza, Agua, Min, Max, Dias)
%   añade o sobreescribe una hortaliza con sus requerimientos de agua, temperatura y tiempo de crecimiento
añadir_hortaliza(Hortaliza, Agua, Min, Max, Dias) :-
    borrar_hortaliza(Hortaliza),
    assertz(hortaliza_agua(Hortaliza, Agua)),
    assertz(hortaliza_temperatura(Hortaliza, Min, Max)),
    assertz(hortaliza_dias(Hortaliza, Dias)).
