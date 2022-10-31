clear;
clc;
syms x1 x2
x = sdpvar(2,1);
G=[1,2;4,3];
h=[40;120];
A=[1,1];
b=30;
P=[4,0;0,6];
q=[40;50];
r=0;
Constraints = [G*x<=h,A*x==b;x(1)>=0,x(2)>= 0];
Objective = 0.5*x'*P*x+q'*x+r;
ob=2*x1*x1+40*x1+3*x2*x2+50*x2;

gradf0=[diff(ob,x1),diff(ob,x2)];
gradf1=[1,2];
gradf2=[4,3];
gradh=[1,1];
options = sdpsettings('solver','gurobi','verbose',0);
sol = optimize(Constraints,Objective,options);
% 分析输出
if sol.problem == 0
    t=value(x)
    t1=round(t(1));
    t2=round(t(2));
    value(Objective)
    graf0=subs(gradf0,{x1,x2},{t1,t2})
    value(gradf1)
    value(gradf2)
    value(gradh)
   
    %plot(Constraints);
    %axis([0,50,0,50]);
else
 disp('something went wrong!');
end


