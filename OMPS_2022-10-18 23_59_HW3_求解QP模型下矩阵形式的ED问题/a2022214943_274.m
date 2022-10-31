%% 
clc;
clear all;
%% QP problem
x=sdpvar(2,1);
P=[4,0;0,6];
q=[40;50];
r=0;
G=[1,2;4,3];
h=[40;120];
A=[1,1];
b=30;
z=(1/2)*x'*P*x+q'*x+r;
%% Constraints
Cons=[];
Cons=[Cons,G*x<=h,A*x==b,x>=0];
ops=sdpsettings('solver','gurobi');
%% 
sol=optimize(Cons,z,ops);
s_x=value(x);s_z=value(z);
%% dual variables
u12=dual(Cons(1));
u3=dual(Cons(2));
u45=dual(Cons(3));
%% 1st-order condition
f0_1st=P*s_x+q;
f1_1st=[1;2];
f2_1st=[4;3];
h1_1st=[1;1];

