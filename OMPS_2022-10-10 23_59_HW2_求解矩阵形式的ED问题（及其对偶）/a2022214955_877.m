% 原问题
close all; clear all;
x = sdpvar(2,1);
c = [40;50];
z = c' * x;
A = [1, 2,;
    4, 3];
b = [40;120];
Cons = [A*x <= b,...
    x(1) + x(2) == 30,...
    x >= 0];
ops = sdpsettings('solver', 'gurobi');
sol = optimize(Cons, -z, ops);
s_x = value(x);
s_z = value(z);

% 对偶问题
u = sdpvar(4,1);
b_T = [40,120,30,-30];
w = b_T * u;
A_T = [1,4,1,-1;
    2,3,1,-1];
Cons = [A_T * u >= c,... 
    u >= 0];
ops = sdpsettings('solver', 'gurobi');
sol = optimize(Cons, w, ops);
s_u = value(u);
s_w = value(w);