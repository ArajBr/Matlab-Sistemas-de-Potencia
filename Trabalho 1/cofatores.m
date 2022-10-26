%Faz os calculos para encontrar a matriz de cofatores, e posteriormente
%com essa matriz descobrir o numero de arvores possiveis atraves da matriz
%L
function [Adj]=cofatores(L);
[r c] = size(L);                                  %Determina o tamanho da entrada           
mat_cof = ones(r,c);                              %pré-aloca uma matriz de cofatores r x c        
L_temp=L;                                         %Cria uma matriz temporaria igual a matriz de entrada
for i = 1:r
    for k = 1:c
        L_temp([i],:)=[];                         %Remove ith linha
        L_temp(:,[k])=[];                         %Remove kth coluna
        mat_cof(i,k) = ((-1)^(i+k))*det(L_temp);  %Computa o elemento cofator
        L_temp=L;                                 %Reseta a matriz temporaria para os valores da matriz de entrada
    end  
end
Adj=mat_cof;                                      %Retorna a matriz de cofatores
end