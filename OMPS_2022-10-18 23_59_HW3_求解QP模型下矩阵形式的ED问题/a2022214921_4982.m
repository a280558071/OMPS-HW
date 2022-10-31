clear;
clc;
close all;

%QP minimize (1/2)x'*P*x+q'*x+r
%   subject to Gx<=h
%              Ax=b

x=sdpvar(2,1);
P=[4,0;0,6];
q=[40;50];
G=[1,2;4,3];
h=[40;120];
b=[1,1];

Cons=[G*x<=h,x(1)+x(2)==30,x>=0];
ops=sdpsettings('solver','gurobi');
z=1/2*x'*P*x+q'*x;
sol=optimize(Cons,z,ops);
   s_x=value(x)
   s_z=value(z)

u_dual1=dual(Cons(1))
u_dual2=dual(Cons(2))
u_dual3=dual(Cons(3))

p_f0=P*s_x+q  %目标函数一阶导
p_fi=G        %不等式一阶导
p_h0=b        %等式一阶导



   
