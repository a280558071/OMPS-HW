%% 
clc;
clear all;
%% parameters
A=[1,2;4,3];
b=[40;120];
P=[2,0;0,2];
q=[40;50];
s=[1,2,3,4,1];%s=[1,1,2,3,4];
t=[2,3,4,2,3];%t=[2,3,3,4,2];
d=[0;0;10;20];
X=[0.01,0.01,0.01,0.02,0.01]';
%% variables
g_i=sdpvar(2,1);
p_ij=sdpvar(5,1);
theta=sdpvar(4,1);
Graph=digraph(s,t);
In=incidence(Graph);  % 节支关联矩阵，node-branch incidence matrix
In=-In;
%% Constraints
Cons=[];
Cons=[Cons,A*g_i<=b,g_i>=0];
G_i=[g_i;0;0];
Cons=[Cons,In*p_ij==G_i-d,In'*theta==p_ij.*X,theta(1)==0];
Cons=[Cons,p_ij<=20];
%% objective
Obj=1/2*g_i'*P*g_i+q'*g_i;
%% solve
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,Obj,ops)
%% Save the solution with "s_" as start
s_g=value(g_i);
s_p_ij=value(p_ij);
s_theta=value(theta);
s_Obj=value(Obj);
s_G_i=value(G_i);
%% Plot the results
Gi=graph(s,t);
os=0.3; % offset value to print text in the figure
figure;
pi=plot(Gi,'Layout','force');
pi.XData=[0,3,4,6];
pi.YData=[0,3,-3,1.5];
highlight(pi,1:4,'NodeColor','b','Markersize',15,'NodeFontSize',20);
text(pi.XData, pi.YData, pi.NodeLabel,'HorizontalAlignment', 'center','FontSize', 15); % put nodes' label in right position.
text(pi.XData+os, pi.YData+os, num2str(d),'HorizontalAlignment', 'center','FontSize', 12, 'Color','g'); % printf the d .
text(pi.XData-os, pi.YData-os, num2str(s_G_i),'HorizontalAlignment', 'center','FontSize', 12, 'Color','k'); % printf G .
text(pi.XData-os, pi.YData-2*os, num2str(round(s_theta,2)),'HorizontalAlignment', 'center','FontSize', 12, 'Color','r'); % printf the theta.
for l=1:5
    Coor1_PQ=(pi.XData(s(l))+pi.XData(t(l)))/2;
    Coor2_PQ=(pi.YData(s(l))+pi.YData(t(l)))/2;
    text(Coor1_PQ, Coor2_PQ, num2str(round(s_p_ij(l),2)),'HorizontalAlignment', 'center','FontSize', 12, 'Color','b'); % printf the complex power in distribution lines(if any).
end 
pi.NodeLabel={};