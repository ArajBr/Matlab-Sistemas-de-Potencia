%A função calcula a decomposiçao da uma matriz quadrada em termos de L,D e U
function [L,U]=DecomLDU(matriz)
[R,C] = size(matriz);                                       %Calcula o tamanho da matriz
for i = 1:R
    L(i,1) = matriz(i,1);                                    %Cria uma matriz L coluna 1xn referente a matriz A
    U(i,i) = 1;                                         %Cria uma matriz diagonal unitaria
end
for j = 2:R
    U(1,j)= matriz(1,j)/L(1,1);                              %Calcula a linha 1 da matriz U nx1
end
for i = 2:R
    for j = 2:i
        L(i,j)=matriz(i,j)-L(i,1:j-1)*U(1:j-1,j);            %Calcula o restante da matriz L
    end    
    for j = i+1:R
        U(i,j)=(matriz(i,j)-L(i,1:i-1)*U(1:i-1,j))/L(i,i);   %Calcula o restante da matriz U
    end
end
D=diag(diag(L));                                        %Calcula a matriz diagonal D
L=L;                                                  %Calcula a matriz L com a diagonal normalizada
U;                                                      %Matriz U
end
