clc
clear 
close all;
x=sdpvar(2,1);
G=[1 2;4 3];
h=[40 120]';
P=[2 0;0 2];
q=[40 50]';
r=0;

I=[1 1 2 3 4]';
J=[2 3 3 4 2]';
IN=myincidence(I,J); 
p=sdpvar(5,1);
theta=sdpvar(4,1);
g=[x(1),x(2),0,0]';
d=[0,0,10,20]';
X=[0.01,0.01,0.01,0.02,0.01]';

Cons=[G*x<=h,x>=0,IN*p==g-d,IN'*theta==p.*X,p<=20,-p<=20,theta(1)==0];
ops = sdpsettings('solver', 'gurobi');
z=1/2*x'*P*x+q'*x+r;
sol = optimize(Cons, z, ops);
if sol.problem==0
    s_g=value(g)
    s_z=value(z)
    s_p=value(p)
    s_theta=value(theta)

else
    disp('求解出错');
end

names={'1','2','3','4'};
G1=digraph(I,J,s_p,names);
%  p1=plot(G1);
p1=plot(G1,'Layout','force','EdgeLabel',G1.Edges.Weight); % handle of figure G plot
% p1=plot(G1,'Layout','force','NodeLabel',s_g-d,'EdgeLabel',G1.Edges.Weight); % handle of figure G plot



function IN=myincidence(I,J)
IN=zeros(length(unique([I,J])),length(J));
for i=1:length(I)
    IN(I(i),i)=1;
end
for i=1:length(J)
    IN(J(i),i)=-1;
end
end


