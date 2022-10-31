clc;
clear all;
close all;
g = sdpvar(4,1);
d = [0;0;10;20];
P = [2,0,0,0;0,2,0,0;0,0,0,0;0,0,0,0];
q = [40;50;0;0];
A = [1,2,0,0;4,3,0,0;-1,0,0,0;0,-1,0,0];
h = [40;120;0;0];
I = [1;1;2;3;4];
J = [2;3;3;4;2];
IN = myincidence(I,J);
X = [0.01;0.01;0.01;0.02;0.01];
p = sdpvar(5,1);
theta = sdpvar(4,1);
Obj = (1/2)*g'*P*g+q'*g;
Cons = [A*g<=h,
        g(3)==0,
        g(4)==0,
        IN*p==g-d,
        IN'*theta==p.*X,
        theta(1)==0,
        p-[20;20;20;20;20]<=0];
ops=sdpsettings('verbose',0,'solver','gurobi');
sol = optimize(Cons,Obj,ops);
s_g = value(g)
s_Obj = value(Obj)
s_p = value(p)
s_theta = value(theta)
G = digraph(I,J);
P1= plot(G);
labelnode(P1,[1;2;3;4],{'节点1：g1=20';'节点2：g2=10';'节点3：d3=10';'节点4：d4=20'});
weights = s_p;
labeledge(P1,1:numedges(G),weights);
% created by 王浩然（学号2022214931）

