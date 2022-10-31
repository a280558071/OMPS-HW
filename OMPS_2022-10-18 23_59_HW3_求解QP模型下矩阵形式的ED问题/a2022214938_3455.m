clear;
clc;
close all;
x=sdpvar(2,1);
A=[1,2;4,3];
B=[40;120];
p=[4,0;0,6];
q=[40;50];
z=1/2*x'*p*x+q'*x;
con=[A*x<=B;x(1)+x(2)==30;x>=0];
ops = sdpsettings('verbose',0,'solver','gurobi');
reuslt = optimize( con,z,ops );
value(x)
value(z)
dual_x=[dual(con(1));dual(con(2))]
%梯度计算
syms x y;
grad_f0=jacobian(2*x^2+40*x+3*y^2+50*y,[x,y]);
grad_f1=jacobian(x+2*y-40,[x,y]);
grad_f2=jacobian(4*x+3*y-120,[x,y]);
grad_h=jacobian(x+y-30,[x,y]);

x=20;
y=10;
tiduf0=eval(grad_f0)
tiduf1=eval(grad_f1)
tiduf2=eval(grad_f2)
tiduh=eval(grad_h)