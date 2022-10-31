clear;
clc;
close all;
x=sdpvar(2,1);
Rev=[40,50];
Dec=[1,2;4,3];
Emi=[40;120];
Cons=[Dec*x<=Emi,x(1)+x(2)==30,x(1)>=0,x(2)>=0];
ops=sdpsettings('solver','gurobi');
z=Rev*x;
sol=optimize(Cons,-z,ops);
   s_x=value(x)
   s_z=value(z)

% dual problem
u=sdpvar(4,1);
Rev=[40;50];
a=[40,120,30,-30];
b=[1,4,1,-1;2,3,1,-1];
Cons=[b*u>=Rev,u>=0];
w=a*u;
sol=optimize(Cons,w,ops);
    s_u=value(u)
    s_w=value(w)
  
%原问题和对偶问题有相同的运行结果



