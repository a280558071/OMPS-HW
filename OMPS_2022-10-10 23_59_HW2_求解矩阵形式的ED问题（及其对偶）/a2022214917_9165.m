clear
clc
close all;
%原问题
x=sdpvar(2,1);
c=[40,50]';
A=[1,2;
   4,3;
   1,1;
   -1,-1];
b=[40,120,30,-30]';
Cons_p=[A*x<=b,x(1)>=0,x(2)>=0];
ops = sdpsettings('solver', 'gurobi');
z_p=-c'*x;
sol = optimize(Cons_p, z_p, ops);
if sol.problem==0
    s_x=value(x)
    s_zp=value(-z_p)
    plot(Cons_p);
    axis([0 30 0 30])
else
    disp('求解出错');
end
%对偶问题
u=sdpvar(4,1);
z_d=b'*u;
Cons_d=[A'*u>=c,u(1)>=0,u(2)>=0,u(3)>=0,u(4)>=0];
sol_d=optimize(Cons_d,z_d,ops);
if sol_d.problem==0
    s_u=value(u)
    s_zd=value(z_d)
else
    disp('求解出错');
end