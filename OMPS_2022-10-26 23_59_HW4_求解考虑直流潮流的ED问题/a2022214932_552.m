clc;clear;
close all;
g1 = sdpvar(2,1);
P = [2,0;0,2];
Q = [40,50]';
A = [1,2;4,3;-1,0;0,-1];
B = [40;120;0;0];
I = [1;1;2;3;4];
J = [2;3;3;4;2];
G = digraph(I,J);
%p1 = plot(G);
IN = incidence(G);
d = [0,0,10,20]';
X = [0.01,0.01,0.01,0.02,0.01]';
g = [g1(1),g1(2),0,0]';
p =sdpvar(5,1);
theta = sdpvar(4,1);
Cons = [A*g1 <= B,IN*p==g-d,IN'*theta==p.*X,theta(1)==0,p<=20,p>=-20];
ops = sdpsettings('verbose',0,'solver','gurobi');
z1 = (1/2)*(g1')*P*g1+(Q')*g1;
result1 = optimize(Cons,z1,ops);
if result1.problem == 0
    value(g1)
    value(z1)
    s_p=value(p)
    s_theta=value(theta)
    eLabels = {'p12 = -8.1818 ','p13 =  -11.8182','p23 = -3.6364','p34 = -5.4545','p42 = 14.5455'};
    nLabels = {'流进g1 = 20 ','流进g2 =  10','流出d3 = 10','流出d4 = 20'};
    plot(G,'Layout','force','EdgeLabel',eLabels,'NodeLabel',nLabels);
else
    disp('error');
end