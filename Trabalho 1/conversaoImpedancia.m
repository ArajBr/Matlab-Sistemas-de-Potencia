%Analisa se o valor do elemento série é impedancia/admitancia e converte para impedancia 
function [sep_novo]=conversaoImpedancia(sep);
[n,m]=size(sep);
for i=1:n
    if sep(i,3)==1
        k=inv(sep(i,4));
        sep(i,4)=k;
        sep(i,3)=0;
    end
end
sep_novo=sep;
end