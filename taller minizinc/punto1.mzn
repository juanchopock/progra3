% Use this editor as a MiniZinc scratch book
int: disciplinas = 4;
int: nparticipantes = 6;
int: nlugar = 2;
array [1..disciplinas] of var 1..nparticipantes:
participante;
array [1..disciplinas] of var 1..nlugar: lugar;
array [1..nlugar] of int: tiempolugar = [5,6];
array [1..disciplinas] of int: duracion = [2,3,1,2];
array [1..disciplinas] of var 1..24: horainicio;

array [1..disciplinas] of var int: horafinal;
constraint forall(i in 1..disciplinas)(
horafinal[i] = horainicio[i] + duracion [i]
);

constraint forall(i,j in 1..disciplinas where i != j)(
participante[i] == participante[j] -> horafinal[i] <=
horainicio[j] \/ horafinal[j] <= horainicio[i]);

constraint forall(i,j in 1..disciplinas where i != j)(
participante[i] == participante[j] -> horafinal[i] <=
horainicio[j] \/ horafinal[j] <= horainicio[i]);

constraint forall(i,j in 1..disciplinas where i != j)(
lugar[i] == lugar[j] -> horafinal[i] <= horainicio[j]
\/ horafinal[j] <= horainicio[i]);

array [1..nlugar] of int: capacidad = {5,6};

constraint forall(m in 1..nlugar)(
sum([duracion[i] | i in 1..disciplinas where lugar[i] =
m]) <= capacidad[m]);

var int: makespan = max([horafinal[i] | i in
1..disciplinas]);
solve minimize makespan;