% Fun��o respons�vel por encontrar todos os la�os poss�veis do SEP, caso
% existam. Se n�o houver nenhum la�o numero de la�os � igual a 0.
% _________________________________________________________________________
% Syntaxe:[lacos,n_lacos]=find_loop(sep)
%         lacos-> cell array contendo todos os la�oes em fun��o das barras.
%         n_lacos-> N�mero total de la�os
%         sep-> nome do arquivo xlsx contendo os dados do SEP.
%__________________________________________________________________________

function [lacos,n_lacos]= encontraLacos(sep)
grafo=sep(:,1:2);
smaller = min(grafo(:,1));
if smaller ==0
    grafo = grafo(:,1:2)+1;
end
adj= MatrizIncidencia(grafo);
adj=adj+adj';
clear global malha
 for n=1:length(adj)
   encontraLacos([],n,adj)
 end
global malha
       
n_lacos=length(malha);
lacos=malha;                   
clear global malha
end