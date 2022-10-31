clear;
clc;
close all;

%QP minimize (1/2)x'*P*x+q'*x+r
%   subject to Gx<=h
%              Ax=b

P=[2,0;0,2];
q=[40;50];
L=[1,2;4,3];
h=[40;120];

I=[1;1;2;3;4]; %starting nodes
J=[2;3;3;4;2]; %ending nodes

% node-branch incidence matrix
IN=myincidence(I,J);
% Define g_n and d_n, calculate p
g_x=sdpvar(2,1);
g=[g_x(1),g_x(2),0,0]';
d=[0,0,10,20]';
X=[0.01,0.01,0.01,0.02,0.01]';
p=sdpvar(5,1);
theta=sdpvar(4,1);
z=1/2*g_x'*P*g_x+q'*g_x;
Cons=[L*g_x<=h,g_x>0,IN*p==g-d,IN'*theta==p.*X,theta(1)==0,p<=20];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops)
s_g=value(g)
s_z=value(z)
s_p=value(p)
s_theta=value(theta)

G=digraph(I,J,s_p);
% p1=plot(G,'Layout','force','EdgeLabel',G.Edges.Weight);% handle of figure G plot

function IN=myincidence(I,J)
n=max(max(I),max(J));
m=numel(I);
IN=zeros(n,m);

for i=1:m
      a=I(i);
      b=J(i);
      IN(a,i)=1;
      IN(b,i)=-1;
end

end