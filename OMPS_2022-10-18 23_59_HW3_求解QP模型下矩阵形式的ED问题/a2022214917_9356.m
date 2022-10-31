clc
clear
close all;
x=sdpvar(2,1);
P=[4 0;0 6];
q=[40 50]';
G=[1 2;4 3];
h=[40 120]';
A=[1,1];
b=30;
Cons_p=[G*x<=h,A*x==b,x>=0];
ops = sdpsettings('solver', 'gurobi');
z_p=1/2*x'*P*x+q'*x;
sol = optimize(Cons_p, z_p, ops);
if sol.problem==0
    s_x=value(x)
    s_zp=value(z_p)
    plot(Cons_p);
    axis([0 30 0 30])
else
    disp('求解出错');
end
u12=dual(Cons_p(1))
u3=dual(Cons_p(2))
u45=dual(Cons_p(3))
grad_f0=P*s_x+q
grad_fi=G
grad_h=A