clc
close all
clear all
% function NI=creatNI[I J]
%% 初始化数据
I=[1;1;2;3;4];
J=[2;3;3;4;2];
G=digraph(I,J);
%plot(G)
NI=incidence(G);
NI=-NI;
X=[0.01 0.01 0.01 0.02 0.01]';
d=[0;0;10;20];
M=[1 0 0 0 ;
   0 1 0 0 ;
   0 0 0 0 ;
   0 0 0 0 ];
N=[40 ;50;0 ;0 ];
A=[1 2 0 0;
   4 3 0 0 ];
b=[40;120];
%% 生成决策变量
p=sdpvar(5,1);
theta=sdpvar(4,1);
g=sdpvar(4,1);
z=g'*M*g+g'*N;
st=[];
st=st+[g(3)==0,g(4)==0];
st=st+[A*g<=b,g>=0];
st=st+[NI*p==g-d,NI'*theta==p.*X,theta(1)==0,p<=20];
options=sdpsettings('solver', 'cplex');
result=optimize(st,z,options);
if   result.problem == 0
    s_theta=value(theta)
    s_p=value(p)
    s_g=value(g)
    s_z=value(z)
    G=digraph(I,J,s_p');
    G.Nodes.Name = {'1 0 ' '2  -0.081' '3  -0.118' '4  -0.227'}';
    plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2);
else
    display('错了亲！');
    result.info
    yalmiperror(result.problem)
end