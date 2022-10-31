% QP  min (1/2)*x'*P*x+q'*x+r
%     s.t. G*x<=h      即fi(x)<=0
%          A*x=b      即hi(x)=0
clc;
clear all;
close all;
x = sdpvar(2,1);
P = [4,0;0,6];
q = [40;50];
r = 0;
G = [1,2;4,3;-1,0;0,-1];
h = [40;120;0;0];
A = [1,1];
b = [30];
Obj = (1/2)*x'*P*x+q'*x+r;
Cons = [G*x<=h,
        A*x==b];
ops=sdpsettings('verbose',0,'solver','gurobi');
sol = optimize(Cons,Obj,ops);
s_x = value(x)
s_Obj = value(Obj)
u = dual(Cons(1))  % 包括u1,u2,u4,u5(不等式约束与非负约束)
u3 = dual(Cons(2))  % 等式约束的dual variable
% 计算梯度
syms X1 X2 
df0 = gradient(2*X1^2+3*X2^2+40*X1+50*X2,[X1,X2]);
df0opt = subs(df0,[X1,X2],[20,10])
df1 = gradient(X1+2*X2,[X1,X2]);
df1opt = subs(df1,[X1,X2],[20,10])
df2 = gradient(4*X1+3*X2,[X1,X2]);
df2opt = subs(df2,[X1,X2],[20,10])
df3 = gradient(-X1,[X1,X2]);
df3opt = subs(df3,[X1,X2],[20,10])
df4 = gradient(-X2,[X1,X2]);
df4opt = subs(df4,[X1,X2],[20,10])
dh = gradient(X1+X2,[X1,X2]);
dhopt = subs(dh,[X1,X2],[20,10])
% created by 王浩然（学号2022214931）
