clc
clear
%%original problem
g=sdpvar(4,1);%决策变量
I=[1,1,2,3,4];%starting node
J=[2,3,3,4,2];%ending node
G=digraph(I,J);
hold on;
h=plot(G);
IN=-full(incidence(G));%关联矩阵
d=[0 0 10 20]';
X=[0.01 0.01 0.01 0.02 0.01]';
p=sdpvar(5,1);
theta=sdpvar(4,1);

P=[2,0;0,2];
Q=[40,50];
A=[1 2;4,3];
b=[40 120]';
Constrs=[IN*p==g-d
         IN'*theta==p.*X
         p<=20
         A*g(1:2)<=b
         g(1:2)>=0
         g(3:4)==0
          ];
Obj=0.5*g(1:2)'*P*g(1:2)+Q*g(1:2);
options = sdpsettings('verbose',2,'solver','gurobi');%参数设置
result = solvesdp(Constrs,Obj,options);%求解
if result.problem==0
    s_g=value(g(1:2))%决策变量g1,g2输出
    s_O=value(Obj)%目标函数值输出
    s_p=value(p)%输出OPF
   % plot(Constrs); %绘制result

else
    disp('求解出错')
end
%绘制result
labelText={'p12 = 8.1818','p13 = 11.8182','p23 = 3.6364','p34 = 5.4545','p42 = -14.5455'};
labeledge(h,[1 1 2 3 4],[2 3 3 4 2],labelText)%%绘制支路潮流
txt1 = '\downarrow g1=20'; 
text(0.95,1.1,txt1,'FontSize',12) %5绘制节点潮流
txt2 = '\uparrow g2=10';
text(0.48,-0.6,txt2,'FontSize',12)
txt3 = '\uparrow d3=10';
text(-0.5,0.6,txt3,'FontSize',12)
txt4 = '\downarrow d4=20';
text(-1,-1.1,txt4,'FontSize',12)