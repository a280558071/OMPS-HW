clc;
clear all;
P=[2 0;0 2];
q=[40;50];
L=[1 2;4 3];
h=[40;120];

I=[1;1;2;3;4]; 
J=[2;3;3;4;2];

G=digraph(I,J);
p1=plot(G)

IN =[1     1     0     0     0
    -1     0     1     0    -1
     0    -1    -1     1     0
     0     0     0    -1     1];

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
