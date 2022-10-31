%% 
clc;
clear all;
%%
%变量申明、参数设置
x=sdpvar(2,1);
A=[1,2;4,3;1,1;-1,-1];
b=[40;120;30;-30];
c=[40;50];
max=c'*x;
%% 
%约束条件
Cons=[];
Cons=[A*x<=b;x>=0];
ops=sdpsettings('solver','gurobi');
%% 
%求解
sol=optimize(Cons,-max,ops);
s_x=value(x);
s_max=value(max);
u1=dual(Cons(1));
u2=dual(Cons(2));
%% 
%对偶
u=sdpvar(4,1);
min=b'*u;
Cons1=[A'*u>=c;u>=0];
sol2=optimize(Cons1,min,ops);
s_u=value(u);
s_min=value(min);