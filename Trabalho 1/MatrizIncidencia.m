function [A]=MatrizIncidencia(grafo)
[a,~]=size(grafo);        %% determina o numero de arestas do grafo
b=max(max(grafo));        %% determina o numero de vertices do grafo
A=zeros(a,b);             %% cria uma matriz de zeros de acordo com o numero de arestas e vertices
for aux1=1:a
    var1=grafo(aux1,1);   %% variavel auxiliar que recebe o vertice de partida
    var2=grafo(aux1,2);   %% variavel auxiliar que recebe o vertice de chegada
    A(aux1,var1)=1;       %% aloca o valor 1 para os vertices de saida na matriz de incidencia  
    A(aux1,var2)=-1;      %% aloca o valor -1 para os vertices de saida na matriz de incidencia
end
A=A';                    %% matriz de incidencia
end