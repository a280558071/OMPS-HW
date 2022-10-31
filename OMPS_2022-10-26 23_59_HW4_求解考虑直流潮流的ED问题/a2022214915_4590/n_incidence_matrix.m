function A=n_incidence_matrix(I,J)
% 输入I，J为同维度的列向量，代表支路的背离节点和指向节点
% 矩阵A为n行m列矩阵，n为节点数，m为支路数 
A=zeros(max([max(I),max(J)]),length(I));
for i=1:length(I) % i代表第i条支路
    A(I(i),i)=1; %  流出是1 流入是-1
    A(J(i),i)=-1;
end