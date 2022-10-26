% confere se o grafo do sistema � conexo ou n�o
function []=grafoConexo(grafo)
n_vertice= max(max(grafo));
n_elementos=length(grafo);
m_adj=zeros(n_vertice);
for n=1:n_elementos
    m_adj(grafo(n,1),grafo(n,2))=1;       % cria matriz de adjacencia trigular
end
m_adj=m_adj+m_adj';                   % cria matriz de adjacencia completa
global vert_flag                      % Declara var�avel global vert_flag
vert_flag(1:n_vertice)=0;             % Preence vert_flag(1:v)=0; para controle de visitas da find_path
encontra_cone(m_adj,n_vertice,1)      % N�o retorna nada, recebe "n_vertice" e "m_adj" sim�trico
if all(vert_flag)==1                  % Condicionamento do resultado, se todos os elementos de vert_flag forem 1 ent�o a rede �
    result=1;                         % conexa e result=1 caso contr�rio result=0
    disp('O sistema � conexo')
else
    result=0;
    disp('O sistema n�o � conexo')
end
clear global vert_flag               % deleta a var�avel global_vert_flag para aplica��es postesriores

end
%end