clear;
clc;
close all;
x=sdpvar(2,1);
P=[2,0;0,2];
q=[40;50];
z=(1/2)*x'*P*x+q'*x;
A=[1,2;4,3];
b=[40;120];
I=[1;1;2;3;4]; %starting nodes 
J=[2;3;3;4;2]; %ending nodes
G=digraph(I,J); 
p1=plot(G);
IN=-incidence(G);
d=[0,0,10,20]';
X=[0.01,0.01,0.01,0.02,0.01]';
g=[x(1),x(2),0,0]';
p=sdpvar(5,1);
theta=sdpvar(4,1);
Cons=[A*x<=b,x>=0,IN*p==g-d,IN'*theta==p.*X,p<=20,theta(1)==0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops);
s_x=value(x),s_z=value(z)
s_p=value(p)
s_theta=value(theta),s_IN=value(IN)
s_g=value(g),s_d=value(d)
for k=1:5
    if s_p(k)~=0
        h=(p1.XData(I(k))+p1.XData(J(k)))/2;
        m=(p1.YData(I(k))+p1.YData(J(k)))/2;
        text(h,m,['p=',num2str(s_p(k),6)],'HorizontalAlignment','center','FontSize',10,'Color','r');
    end
end
for n=1:4
    text(p1.XData(n),p1.YData(n)+0.1,['\theta_',num2str(n),'=',num2str(s_theta(n),6)],'HorizontalAlignment','center','FontSize',10,'Color','b');
end
for n=1:4
    text(p1.XData(n)-0.2,p1.YData(n),['g_',num2str(n),'=',num2str(value(g(n)),2)],'HorizontalAlignment','center','FontSize',10,'Color','r');
end
for n=1:4
    text(p1.XData(n)+0.2,p1.YData(n),['d_',num2str(n),'=',num2str(value(d(n)),2)],'HorizontalAlignment','center','FontSize',10,'Color','g');
end
    