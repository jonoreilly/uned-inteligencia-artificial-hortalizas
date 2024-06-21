% Este es un archivo de ejemplos para probar el programa.

% Consulta para saber cuanta agua necesita un tomate
hortaliza_agua(tomate, Agua).

% Consulta para saber que hortalizas necesitan mas de 10_000 m3 de agua por ha por año
hortaliza_agua(Hortaliza, Agua), Agua >= 10.

% Consulta para saber que hortalizas aguantan una helada de -5°C
hortaliza_temperatura(Hortaliza, Min, Max), Min =< -5.

% Consulta para saber cuantos dias tarda en crecer una cebolla
hortaliza_dias(cebolla, Dias).

% Consulta para saber cuanto llueve en Vitoria en invierno
terreno_estacion_agua(vitoria, invierno, Agua).

% Consulta para saber que temperatura hace en Donosti en verano
terreno_estacion_temperatura(donosti, verano, Min, Max).

% Consulta para saber cuantos días tiene la primavera
estacion_dias(primavera, Dias).

% Consulta para saber cuantos días tarda en crecer tres plantaciones de zanahorias
hortalizas_dias([zanahoria, zanahoria, zanahoria], Dias).

% Consulta para saber que hortalizas se pueden plantar en Donosti en verano
terreno_estacion_hortaliza(donosti, verano, Hortaliza).

% Consulta para saber donde y cuando se puede plantar patata
terreno_estacion_hortaliza(Terreno, Estacion, patata).

% Consulta para saber cuanto riego se necesita para plantar tomate en Vitoria en verano
terreno_estacion_hortaliza_riego(vitoria, verano, cebolla, Riego).

% Consulta para saber cuantos días hay entre primavera y otoño
estaciones_dias([primavera, verano, otoño], Dias).

% Consulta para saber que planificaciones de cultivo se pueden hacer en Donosti en primavera y verano
terreno_estaciones_hortalizas_caben(donosti, [primavera, verano], Hortalizas).

% Consulta para saber que planificaciones de cultivo se pueden hacer en Donosti en primavera y verano (ignorando planificaciones no maximizadas)
terreno_estaciones_hortalizas_caben_sin_huecos(donosti, [primavera, verano], Hortalizas).