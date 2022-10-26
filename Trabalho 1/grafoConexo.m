% confere se o grafo do sistema é conexo ou não
function []=grafoConexo(grafo)
n_vertice= max(max(grafo));
n_elementos=length(grafo);
m_adj=zeros(n_vertice);
for n=1:n_elementos
    m_adj(grafo(n,1),grafo(n,2))=1;       % cria matriz de adjacencia trigular
end
m_adj=m_adj+m_adj';                   % cria matriz de adjacencia completa
global vert_flag                      % Declara varíavel global vert_flag
vert_flag(1:n_vertice)=0;             % Preence vert_flag(1:v)=0; para controle de visitas da find_path
encontra_cone(m_adj,n_vertice,1)      % Não retorna nada, recebe "n_vertice" e "m_adj" simétrico
if all(vert_flag)==1                  % Condicionamento do resultado, se todos os elementos de vert_flag forem 1 então a rede é
    result=1;                         % conexa e result=1 caso contrário result=0
    disp('O sistema é conexo')
else
    result=0;
    disp('O sistema não é conexo')
end
clear global vert_flag               % deleta a varíavel global_vert_flag para aplicações postesriores

end
%end