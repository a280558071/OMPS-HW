%% Initialize the Graph, defined by starting nodes I and ending nodes J
I=[1;1;2;3;4]; %starting nodes 
J=[2;3;3;4;2]; %ending nodes
G=digraph(I,J); 
p1=plot(G); % handle of figure G plot
% node-branch incidence matrix
IN=[1,1,0,0,0;-1,0,1,0,-1;0,-1,-1,1,0;0,0,0,-1,1];
%% Define g_n and d_n, calculate p
d=[0,0,10,20]';
X=[0.01,0.01,0.01,0.02,0.01]';
g=sdpvar(4,1);
p=sdpvar(5,1);
theta=sdpvar(4,1);
Cons=[IN*p==g-d,IN'*theta==p.*X,theta(1)==0,g(3)==0,g(4)==0];
ops=sdpsettings('solver','gurobi');
Obj=g(1)*g(1)+40*g(1)+g(2)*g(2)+50*g(2);
sol=optimize(Cons,Obj,ops)
s_g=value(g)
s_p=value(p)
s_theta=value(theta)