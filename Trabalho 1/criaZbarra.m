%%Trabalho 1 sep2

%transformar todos os elementos em impedancia caso ja nao seja
%0 impedancia 1 admitancia
function [Z_barra]=criaZbarra(matriz)
[linha,coluna]=size(matriz);
zbarra_aux=[];
Z_barra=[];
x=[];
% Loop para a realização dos casos para a obtenção de zbarra
for aux = 1:linha
    barra_ori=matriz(aux,1);
    barra_des=matriz(aux,2);
    imped=matriz(aux,4);
    flag1=ismember(matriz(aux,1),zbarra_aux); %% checa se a barra de origem já foi adicionada
    flag2=ismember(matriz(aux,2),zbarra_aux); %% checa se a barra de destino já foi adicionada
    flag3=isempty(Z_barra);                    %% checa se z_barra está vazia
    if (flag2 == 0 && barra_ori == 0)
        x=aux;
        Z_barra = caso1(Z_barra,imped);
        zbarra_aux(aux,1)=matriz(aux,1);      %% utiliza uma matriz auxiliar que contem as barras de origem e destino já construidas
        zbarra_aux(aux,2)=matriz(aux,2);
        aux=aux+1;   
    end
    if (matriz(aux,1) == 0) && (flag2 == 1)
        Z_barra=caso3(Z_barra,imped,barra_des);
        zbarra_aux(aux,1)=matriz(aux,1); %%% utiliza uma matriz auxiliar que contem as barras de origem e destino já construidas
        zbarra_aux(aux,2)=matriz(aux,2);
        aux=aux+1;
    end
    if (flag1 == 1 ) && (flag2 == 0)
        Z_barra=caso2(Z_barra,imped,barra_ori);
        zbarra_aux(aux,1)=matriz(aux,1); %%% utiliza uma matriz auxiliar que contem as barras de origem e destino já construidas
        zbarra_aux(aux,2)=matriz(aux,2);
        aux=aux+1;
    end
    if (flag2 == 1) && (flag1 == 1) && ((barra_des && barra_ori) ~= 0)
        Z_barra=caso4(Z_barra,imped,barra_des,barra_ori);
        zbarra_aux(aux,1)=matriz(aux,1); %%% utiliza uma matriz auxiliar que contem as barras de origem e destino já construidas
        zbarra_aux(aux,2)=matriz(aux,2);
        aux=aux+1;
    end
end

end