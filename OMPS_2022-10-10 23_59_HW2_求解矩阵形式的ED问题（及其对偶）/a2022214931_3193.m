% 原问题 max c'x                   对偶问题 min b'u
%      s.t. Ax<=b                         s.t. A'u>=c
%            x>=0                              u>=0
clc;
clear all;
close all;
%% 原问题
x = sdpvar(2,1);
c = [40;50];
A = [1,2;4,3;1,1;-1,-1];
b = [40;120;30;-30];
Obj = c'*x;
Cons = [A*x<=b,
    x>=0];
ops=sdpsettings('verbose',0,'solver','gurobi');
sol = optimize(Cons,-Obj,ops);
s_x = value(x)
s_Obj = value(Obj)
u1 = dual(Cons(1)) % 原问题的影子价格/对偶变量
%% 对偶问题
u = sdpvar(4,1);
c = [40;50];
A = [1,2;4,3;1,1;-1,-1];
b = [40;120;30;-30];
Obj_dual = b'*u;
Cons_dual = [A'*u>=c,
    u>=0];
sol = optimize(Cons_dual,Obj_dual,ops);
s_u = value(u) % s_u = u1,即 Shadow price/dual variables.
s_Obj_dual = value(Obj_dual)
% created by 王浩然（学号2022214931）