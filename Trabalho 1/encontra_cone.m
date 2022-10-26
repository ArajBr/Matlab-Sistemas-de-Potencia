function encontra_cone(m_adj,n_v,v)
 global vert_flag
        vert_flag(v)=1;       
   for n=1:n_v
        if(m_adj(v,n)==1 && vert_flag(n)==0)
                 encontra_cone(m_adj,n_v,n)
        end 
   end 
end