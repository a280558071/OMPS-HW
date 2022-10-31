clear;
clc;
close all;
P = [2 0 0 0;
     0 2 0 0;
     0 0 0 0;
     0 0 0 0];
q = [40;50;0;0];
r = 0;
I = [1;1;2;3;4];
J = [2;3;3;4;2];
G = digraph(I,J);
p1 = plot(G);
p1.XData = [1;2;1;2];
p1.YData = [1;1;2;2];
hold on
IN = my_incidence(I,J);
d = [0;0;10;20];
b = [40;120];
X = [0.01;0.01;0.01;0.02;0.01];
p = sdpvar(5,1);
g = sdpvar(4,1 );
theta = sdpvar(4,1);
A = [1,2,0,0;
     4,3,0,0];
Cons = [A*g <= b;p <= 20;IN*p == g - d;IN'*theta == p.*X;g(1) >= 0;g(2) >= 0;g(3) == 0;g(4) == 0];
z = 0.5*g'*P*g + q'*g + r;
ops = sdpsettings('solver', 'gurobi','verbose',1);
reuslt = optimize( Cons,z,ops );
if reuslt.problem == 0 
    s_p = value(p)
    s_theta = value(theta)
    s_g = value(g)
    value(z)  
    
    for i = 1 : size(g,1)
     text(p1.XData(i)-0.05,p1.YData(i)-0.05,num2str(value(g(i))),'FontSize',15,'Color','g'); 
    end
    for i = 1 : size(p,1)
     CoorX_P=(p1.XData(I(i))+p1.XData(J(i)))/2;
     CoorY_P=(p1.YData(I(i))+p1.YData(J(i)))/2;
     text(CoorX_P,CoorY_P,num2str(value(p(i))),'FontSize',15,'Color','r');    
    end
else
    disp('Something is wrong');
end

function I=my_incidence(s,t)
MaxNode=max(max(s),max(t));
I=zeros(MaxNode,length(s));
for j=1:length(s)
    I(s(j),j)=1;
    I(t(j),j)=-1;
end
end
