clear;
clc;
close all;
g=sdpvar(2,1);
d=[10;20]
P=[1,0;0,1];
q=[40;50];
G_g=[1,2;4,3;1,1;-1,-1];
h=[40;120;30;-30];
z=g'*P*g+q'*g;
I=[1;1;2;3;4];
J=[2;3;3;4;2];
G=digraph(I,J);
IN=incidence(G);
p=sdpvar(5,1);
theta= sdpvar(4,1);
X=[0.01;0.01;0.01;0.02;0.01];
Cons=[IN*p==[g(1);g(2);-d],G_g*g<=h, g>=0,IN*p==[g(1);g(2);-d],IN'*theta==p.*X,theta(1)==0,p<=20];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops); 
s_g=value(g)
s_z=value(z)
p1=plot(G);