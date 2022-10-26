%Função responsável pelo calculo e impressão dos grafos que representam: 1
%o grafo do sistema, 2 o grafo relativo a uma arvore possivel e 3 o grafo
%que representa as cordas dessa arvore possivel.
%Estes calculos são realizados atraves da matriz de adjacencia, onde
%atraves dela é feita uma matriz que é uma matriz quadrada onde suas
%dimensões são [nós,nós], em que a primeira coluna representa as conexões 
%do nó 1, a segunda coluna representa as conexões a partir do nó 2, a
%terceira a partir do nó 3 e assim por diante.
function [b]=desenhaGrafo(grafo)
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
aux3=0;
c=b;                                 %matriz que corresponde a arvore, feita a partir da matriz de identificação
for aux2=1:n_vert
    for aux=1:n_vert
            if b(aux,aux2)==1
                aux3=aux3+1;
            end
            if aux3 >2
                c(aux,aux2)=0;
            end
    end
        aux3=0;
end

bg1 = biograph(c)                     %matriz de identificação para a composição do grafo
get(bg1.nodes,'ID')                   %Numeração dos nos
h=view(bg1)                           %plot da imagem do grafo 
d=b;                                  %matriz que corresponde aos elementos das cordas retiradas
for aux2=1:n_vert
    for aux=1:n_vert
            if b(aux,aux2)==1
                aux3=aux3+1;
            end
            if aux3 ==2
                d(aux,aux2)=0;
            end
    end
        aux3=0;
end

bg1 = biograph(d)                             %matriz de identificação para a composição do grafo
get(bg1.nodes,'ID')                           %Numeração dos nos  
h=view(bg1)                                   %plot da imagem do grafo 

end