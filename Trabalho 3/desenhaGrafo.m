function [h]=desenhaGrafo(Dados_linha)
grafo = Dados_linha(:,2:3);
n_vert= max(max(grafo));
n_elem=length(grafo);
m_adj=zeros(n_vert);
for n=1:n_elem
    m_adj(grafo(n,1),grafo(n,2))=1;        %matriz adjacencia triangular
end

b = zeros(n_vert,n_vert);                       %matriz de identificação feita a partir da matriz de adjacencia
for aux=1:n_vert
    for aux2=1:n_vert
        if m_adj(aux,aux2)==1;
            b(aux,aux)=1;
            b(aux,aux2)=1;
        end
    end
end
b=b'                                  %matriz de identificação para a composição do grafo
bg1 = biograph(b,1:n_vert)                 %função que realiza a construção da imagem do grafo
get(bg1.nodes,'ID')                   %Numeração dos nos
h=view(bg1)                           %plot da imagem do grafo
end