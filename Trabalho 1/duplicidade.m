%Analisa se existem elementos duplicados na matriz e os elimina
function [sep_novo]=duplicidade(sep)
sep_novo=sep;
k=1;
[n,m]=size(sep_novo);
while k<=n
    j=1;
    while j<=n
        if k~=j
            if sep_novo(k,:)==sep_novo(j,:)
                sep_novo(j,:)=[];
                [n,m]=size(sep_novo);
            end
        end
        j=j+1;
    end
    k=k+1;
end
end
