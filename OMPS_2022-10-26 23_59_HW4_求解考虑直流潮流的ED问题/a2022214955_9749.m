clc; clear all; close all;
I = [1;1;2;3;4];
J = [2;3;3;4;2];


IN = myincidence(I,J);
g = sdpvar(4,1);
d = [0;0;10;20];
p = sdpvar(5,1);
theta = sdpvar(4,1);
P = [2,0;
    0,2];
q = [40;50];
r = 0;
G = [1,2;
    4,3;
    -1,0;
    0,-1];
h = [40;120;0;0];
X = [0.01,0.01,0.01,0.02,0.01]';

z = (1/2)*g(1:2)'*P*g(1:2)+q'*g(1:2)+r;

Cons = [G*g(1:2) <= h;
    g(3:4) == 0;
    IN*p == g-d;
    IN'*theta == p.*X;
    p <= 20;
    theta(1) == 0];

% 求解
ops = sdpsettings('verbose',0, 'solver', 'gurobi');
sol = optimize(Cons, z, ops);
% 获得结果
s_g = value(g);
s_d = value(d);
s_z = value(z);
s_p = value(p);
s_theta = value(theta);
% 绘制图像
G = digraph(I,J,s_p);
G.Nodes.theta = s_theta;
G.Nodes.g = s_g;
G.Nodes.d = s_d;
res = plot(G,'Layout','auto','EdgeLabel',G.Edges.Weight);
res.MarkerSize = 10;
res.NodeFontSize = 12;
res.NodeColor = 'b';
res.EdgeColor = 'k';
res.EdgeFontSize = 10;
res.LineWidth = 2;
res.ArrowSize = 15;
for i = 1:4
    res.labelnode(i, ...
        [num2str(i),[newline,'\theta=',num2str(s_theta(i))], ...
        [newline,'g=',num2str(s_g(i))], ...
        [newline,'d=', num2str(s_d(i))]]);
end


function IN = myincidence(I,J)
    n = length(I);
    IN = zeros;
    k = 1;
    for i = 1:n
        IN(I(i),k) = 1;
        k=k+1;
    end
    k = 1;
    for j = 1:n
        IN(J(j),k) = -1;
        k=k+1;
    end
end