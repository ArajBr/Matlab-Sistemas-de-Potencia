function [sep,linha,Adj,grafo]=trataSep(sep)
sep=conversaoImpedancia(sep);
sep=duplicidade(sep);
[linha,coluna]=size(sep);
grafo=sep(1:linha,1:2)+1;     %somasse um devido ao nó de referencia ter sido nomeado como nó zero
grafoConexo(grafo);
A = MatrizIncidencia(grafo);
L = A*A';
Adj= cofatores(L);
end