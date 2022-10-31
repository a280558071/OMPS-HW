clear all;
clc;
%参数矩阵
I = [1;1;2;3;4];
J = [2;3;3;4;2];
G = digraph(I,J);
d = [0;0;10;20];
X = [0.01;0.01;0.01;0.02;0.01];
A = [1,2,0,0;4,3,0,0;-1,0,0,0;0,-1,0,0];
h = [40;120;0;0];
p_upper = [20;20;20;20;20]
P = [2,0,0,0;0,2,0,0;0,0,0,0;0,0,0,0];
q = [40;50;0;0];
IN = [1	1	0	0	0;
        -1	0	1	0	-1;
         0	-1	-1	1	0;
         0	0	0	-1	1]
%变量及目标函数
g = sdpvar(4,1);
p = sdpvar(5,1);
theta = sdpvar(4,1);
z = (1/2)*g'*P*g+q'*g;
Cons = [IN*p == g - d,IN'*theta == p.*X,theta(1) == 0,g(3) == 0,g(4) == 0,A*g <= h,p <= p_upper];
ops = sdpsettings('solver','gurobi');
sol = optimize(Cons,z,ops);
s_g = value(g)
s_z = value(z)
s_p = value(p)
s_theta = value(theta)
g1 = strcat('g1=',num2str(s_g(1)));
g2 = strcat('g2=',num2str(s_g(2)))
%绘图
p1= plot(G);
labelnode(p1,[1;2;3;4],{g1;g2;'d3=10';'d4=20'});
labeledge(p1,1:numedges(G),s_p);
