int: productos = 5;
int: estanterias = 3;

array [1..productos] of int: volumen = {4,3,5,2,1};
array [1..estanterias] of int: capacidad = {8,6,5};
array [1..productos] of int: tiempo = {2,5,3,1,4};
array [1..productos] of var 1..estanterias: asignacion;

constraint forall(m in 1..estanterias)(
sum([volumen[i] | i in 1..productos where asignacion[i] =
m]) <= capacidad[m]);

constraint forall(i, j in 1..productos where i != j) (
tiempo[i] <= tiempo[j] -> asignacion[i] <=
asignacion[j] \/ asignacion[i] >= asignacion[j]
);
var int: espacio_no_usado = sum(m in 1..estanterias)(
capacidad[m] - sum([volumen[i] | i in 1..productos
where asignacion[i] = m])
);
solve minimize espacio_no_usado;