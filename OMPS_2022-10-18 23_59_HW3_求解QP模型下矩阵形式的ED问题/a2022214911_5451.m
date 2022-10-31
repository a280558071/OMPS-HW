clear all;close all;
%% Standard Form
% QP
% min z = 1/2 x.'Px + q.'x
% s.t. Gx <= h
%      Ax  = b
%       x >= 0
%% Quadratic Problem
x = sdpvar(2,1);
P = [4 0;0 6];
q = [40 50].';
z = 1/2 * x.'*P*x + q.'*x;
G = [1 2;4 3];
h = [40;120];
A = [1 1];
b = 30;
Cons = [G*x<=h,A*x==b,x>=0];
ops = sdpsettings('verbose',0,'solver','gurobi');
QP_sol = optimize(Cons,z,ops);
if(~QP_sol.problem)
    x_QP = value(x)
    z_QP = value(z)
    % Observe Dual Variables
    u_dual(1:2) = dual(Cons(1));
    u_dual(3) = dual(Cons(2));
    u_dual
    
    grad_z = P*x_QP + q
    grad_G = G
    grad_A = A
else
    fprintf('Optimal Result of QP Not Found!')
end
%% Tried to solve the Dual Problem by standard form(Failed)
% 此处我尝试用KKT条件写出二次规划对偶问题的标准形式，结果不太理想

% 理论
% max z = inf(x>=0) L(x,u),where L(x,u) is the lagerange function of QP
% s.t.  u >= 0

% according to KKT conditions
% L = 1/2 x.'Px + q.'x + u.'(Ax - b)
% here Ax - b Also includes the inequality constraints
% L' = Px + q + A.'u = 0
% x = -inv(P)*(q + A.'u)
% x.' = -(q + A.'u).'*inv(P.'); notice that P.' = P in this case
% L = -1/2 (q+ A.'u).'*inv(P)*(q + A.'u) - u.'*(A/P*(q + A.'u) + b)

%  such that QD in this case can also be written as

% max z = -1/2 Q.'*inv(P)* Q - u.'* b
% where Q = q + A.'u
% subject to
%
% u >= 0
%-------------------------------------------

% 代码
% u = sdpvar(3,1);
% Q = q + G.'*[u(1);u(2)] + A.'*u(3);
% z_dual = -1/2 * Q.'/P* Q  - [u(1),u(2)] * h - u(3)* b;
% Cons_dual = u>=0;
%
% QDP_sol = optimize(Cons_dual,-z_dual,ops);
%
% if(~QDP_sol.problem)
%     u_QDP = value(u)
%     z_QDP = value(z_dual)
% else
%     fprintf('Optimal Result of QDP Not Found!')
% end