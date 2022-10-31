close all; clear all;clc;
% 初始化
x = sdpvar(2,1);
P = [4, 0;
    0, 6];
q = [40; 50];
r = 0;
G = [1,2;
    4,3];
h = [40;120];
A = [1,1];
b = 30;

z = (1/2)*x'*P*x+q'*x+r;

Cons = [G*x <= h;
    A*x == b;
    x >= 0];
% 求解
ops = sdpsettings('verbose',0, 'solver', 'gurobi');
sol = optimize(Cons, z, ops);
s_x = value(x);
s_z = value(z);
u12 = dual(Cons(1));
u3 = dual(Cons(2));
u45 = dual(Cons(3));
u = [u12;u3;u45];
deltaF0=P*s_x + q;
% 结果输出
disp(['最优解为x1=',num2str(s_x(1)),'   ,x2=',num2str(s_x(2))]);
disp(['目标函数最小值为：', num2str(s_z)]);
disp('对偶变量：');
for i = 1:5
    disp(['     u', num2str(i), '=', num2str(u(i))]);
end
disp('梯度：');
disp(['Delta_f0=','(', num2str(deltaF0(1)),',', num2str(deltaF0(2)),')']);
disp(['Delta_f1=','(1,2)']);
disp(['Deltaf_2=','(4,3)']);
disp(['Deltah_h=','(1,1)']);
