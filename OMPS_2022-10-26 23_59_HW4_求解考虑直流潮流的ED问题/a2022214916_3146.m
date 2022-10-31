clear all;
close all;
%% Initialize the Graph, defined by starting nodes I and ending nodes J
I=[1;1;2;3;4]; %starting nodes 
J=[2;3;3;4;2]; %ending nodes
G=digraph(I,J); 
p1=plot(G); % handle of figure G plot
% node-branch incidence matrix
IN=myincidence(I,J); 
%% Define g_n and d_n, calculate p
g=sdpvar(4,1);g(3)=0;g(4)=0;
d=[0,0,10,20]';
X=[0.01,0.01,0.01,0.02,0.01]';
p=sdpvar(5,1);
theta=sdpvar(4,1);
q=[40;50];
P=[2,0;0,2];
A=[1,2;4,3];
b=[40;120];
z=(1/2)*g(1:2)'*P*g(1:2)+q'*g(1:2);
Cons=[A*g(1:2)<=b,g(1:2)>=0;IN*p==g-d,IN'*theta==p.*X,theta(1)==0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops)
s_p=value(p)
s_theta=value(theta)
s_g=value(g),s_z=value(z)

% g=[5,6,0,0]';
% d=[0,0,3,8]';
% X=[0.01,0.01,0.01,0.02,0.01]';
% p=sdpvar(5,1);
% theta=sdpvar(4,1);
% Cons=[IN*p==g-d,IN'*theta==p.*X,theta(1)==0];
% ops=sdpsettings('solver','gurobi');
% sol=optimize(Cons,0,ops)
% s_p=value(p)
% s_theta=value(theta)

% myincidence
function IN=myincidence(I,J)
n=size(I,1);
m=max(max(I),max(J));
IN=zeros(m,n);
for i=1:n
    IN(I(i),i)=1;
    IN(J(i),i)=-1;
end
end