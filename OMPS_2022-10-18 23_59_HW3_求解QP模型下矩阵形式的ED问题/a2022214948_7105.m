clear;
clc;
close all;
x=sdpvar(2,1);
P=[4,0;0,6];
q=[40;50];
G=[1,2;4,3;1,1;-1,-1];
h=[40;120;30;-30];
z=0.5*x'*P*x+q'*x;
Cons=[G*x<=h, x(1)>=0,x(2)>=0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops); 
s_x=value(x),s_z=value(z);
plot(Cons);
axis([0,40,0,40]);
u123=dual(Cons(1));
u4=dual(Cons(2));
u5=dual(Cons(3));
f0=2* x(1)* x(1)+40* x(1)+3* x(2)* x(2)+50* x(2);
f1=x(1)+2*x(2)-40;
f2=4*x(1)+3*x(2)-120;
h1=x(1)+x(2)-30;
jacobian(f0, [x(1), x(2)])
jacobian(f1, [x(1), x(2)])
jacobian(f2, [x(1), x(2)])
jacobian(h1, [x(1), x(2)])
