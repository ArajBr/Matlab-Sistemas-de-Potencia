% Redução de Kron
% barra_ret -> barra a ser retirada

function Ykron = Reducao_kron (Y_barra, barra_ret)
a = length(Y_barra);
u = 1:a;
u(barra_ret) = [];
for t1 = u
    for t2 = u
        Ykron(t1,t2) = Y_barra(t1,t2)-((Y_barra(t1,barra_ret)*Y_barra(barra_ret,t2))/Y_barra(barra_ret,barra_ret));
    end
end
if barra_ret ~= a
    Ykron(:,barra_ret) = [];
    Ykron(barra_ret,:) = [];
end
end