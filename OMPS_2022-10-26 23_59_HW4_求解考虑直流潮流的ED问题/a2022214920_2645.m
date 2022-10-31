I=[1;1;2;3;4]; %starting nodes
J=[2;3;3;4;2]; %ending nodes
Gh=digraph(I,J);
p1=plot(Gh); % handle of figure G plot
IN=myincidence(I,J);
g=sdpvar(4,1);
g(3)=0;g(4)=0;
p=sdpvar(5,1);
theta=sdpvar(4,1);
P=[2,0;0,2];
Q=[40;50];
G=[1,2;4,3;-1,0;0,-1];
A=[1,1];
b=[40;120;0;0];
z=0.5*g(1:2)'*P*g(1:2)+Q'*g(1:2);
d=[0,0,10,20]';
X=[0.01,0.01,0.01,0.02,0.01]';
Cons=[G*g(1:2)<=b,
    A*g(1:2)==30,
    p<=20,
    IN*p==g-d,
    IN'*theta==p.*X,
    theta(1)==0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops)
g=value(g)
z=value(z)
s_p=value(p)
s_theta=value(theta)
N=["1:0";"2:-0.0818";"3:-0.1182";"4:-0.2273"]; 
for i=1:5
    labeledge(p1,I(i),J(i),s_p(i));
end
for i=1:4
    labelnode(p1,i,N(i));
end


function[IN]=myincidence(I,J)
    x=max(I);
    z=size(J);
    y=z(1);
    IN=zeros(x,y);
for j=1:y
    IN(I(j),j)=1;
    IN(J(j),j)=-1;
end
end