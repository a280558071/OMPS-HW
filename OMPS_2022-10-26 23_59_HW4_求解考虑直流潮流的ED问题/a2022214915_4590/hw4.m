clear all;
clc

%% set parameters %%
% decision variables
g_x=sdpvar(2,1);
p=sdpvar(5,1);
theta=sdpvar(4,1);
% network topology
I=[1;1;2;3;4];
J=[2;3;3;4;2];
G=digraph(I,J); %initialize the graph
% p1=plot(G)
IN=n_incidence_matrix(I,J);%生成节支关联矩阵
% 自带的incidence函数生成的结果 离开节点为-1 进入节点为1 和节点关联矩阵相反 
g=[g_x(1),g_x(2),0,0]';
d=[0,0,10,20]';
X=[0.01 0.01 0.01 0.02 0.01]';
% regular parameters
A=[1 2;4 3];
b=[40;120];
P=[2 0;0 2];
q=[40;50];
ops = sdpsettings('solver', 'gurobi', 'verbose', 1);

%% DCOPF-minimize of total fuel cost %%
obj=1/2*g_x'*P*g_x+q'*g_x;
Cons=[IN*p==g-d,IN'*theta==p.*X,theta(1)==0,p<=20,p>=-20]; %network constraints
Cons=[Cons,A*g_x<=b,g_x>=0];

sol = optimize(Cons, obj, ops);

res = struct();
res.obj=double(obj);
res.g_x=double(g_x); 
res.p=double(p);
res.theta=double(theta);

%% plot the graph %%
p1=plot(G)
for k=1:length(I)
    labeledge(p1,I(k),J(k),res.p(k));
end
% for l=1:length(d)
%     labelnode(p1,l,res.theta(l));
% end
p1