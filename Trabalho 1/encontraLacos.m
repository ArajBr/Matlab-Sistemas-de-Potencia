% Função responsável por encontrar todos os laços possíveis do SEP, caso
% existam. Se não houver nenhum laço numero de laços é igual a 0.
% _________________________________________________________________________
% Syntaxe:[lacos,n_lacos]=find_loop(sep)
%         lacos-> cell array contendo todos os laçoes em função das barras.
%         n_lacos-> Número total de laços
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