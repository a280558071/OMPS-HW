clear;
clc;
close all;
g=sdpvar(2,1);
P=[2,0;0,2];
q=[40;50];
G1=[1,2;4,3;1,1;-1,-1];
h=[40;120;30;-30];
z=0.5*g'*P*g+q'*g;
I=[1;1;2;3;4];
J=[2;3;3;4;2];
G=digraph(I,J);
p1=plot(G);
IN=-incidence(G);%发现用自带的函数与实际的差个负号
p=sdpvar(5,1);
theta= sdpvar(4,1);
X=[0.01;0.01;0.01;0.02;0.01];
Cons=[G1*g<=h, g>=0,IN*p==[g(1);g(2);-10;-20],IN'*theta==p.*X,theta(1)==0,p<=20];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops); 
s_g=value(g)
s_z=value(z)
