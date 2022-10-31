clear all;
clc;
%% 原问题
%创建决策变量
x = sdpvar(2,1);
%系数矩阵
A = [1 2 ; 4 3 ; 1 1 ; -1 -1];
b = [40 ; 120 ; 30 ; -30];
c = [40 ; 50];
l1 = [0 ; 0];
l2 = [0 ; 0 ; 0 ; 0];
%设置目标函数
z= c'*x;
%添加约束条件
Cons = [A*x <= b];
Cons = [Cons;x >= l1];
%参数设置
ops = sdpsettings('solver','gurobi');
%求解
sol = optimize(Cons,-z,ops);
s_x = value(x);
s_z = value(z);

%% 对偶问题
%创建决策变量
u = sdpvar(4,1);
%设置目标函数
w = b'*u;
%添加约束条件
Cons_dual = [A'*u >= c];
Cons_dual = [Cons_dual;u >= l2];
%参数设置
ops = sdpsettings('solver','gurobi');
%求解
sol = optimize(Cons_dual,w,ops);
s_u = value(u);
s_w = value(w);