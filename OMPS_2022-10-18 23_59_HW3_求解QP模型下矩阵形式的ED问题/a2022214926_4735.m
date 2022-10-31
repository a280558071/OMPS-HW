clear all;
clc;
%% 原问题
%创建决策变量
x = sdpvar(2,1);
%系数矩阵
P = [4 0 ; 0 6];
q = [40 ; 50 ];
G = [1 2 ; 4 3];
h = [40 ; 120];
A = [1 1 ];
b = 30
%设置目标函数
z= (1/2)*x'*P*x + q'*x
%添加约束条件
Cons = [G*x <= h, A*x == b,x >= 0];
%参数设置
ops = sdpsettings('solver','gurobi');
%求解
sol = optimize(Cons,z,ops);
if sol.problem == 0
    s_x = value(x);
    s_z = value(z);
else disp("求解出错")
end

%%  observe the dual variables
u_12 = dual(Cons(1));
u_3 = dual(Cons(2));
u_45 = dual(Cons(3));
u = [u_12;u_3;u_45]

%calculate ∇𝑓0(𝑥∗), ∇𝑓𝑖(𝑥∗), ∇ℎ(𝑥∗)
Df_0 = P * s_x + q;
Df_1 = G;
Dh_1 = A;