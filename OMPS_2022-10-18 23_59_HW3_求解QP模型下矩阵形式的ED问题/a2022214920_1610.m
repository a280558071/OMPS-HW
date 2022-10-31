%初始化
clear;
clc;
close all;
x=sdpvar(2,1);
P=[4,0;0,6];
Q=[40;50];
G=[1,2;4,3];
A=[1,1];
b=[40;120];
z=0.5*x'*P*x+Q'*x;
Cons=[G*x<=b,A*x==30,x>=0];
ops=sdpsettings('verbose',0,'solver','gurobi');
result=optimize(Cons,z,ops);
if result.problem==0
   x1=value(x)
   value(z)
   plot(Cons);
   axis([0,50,0,50]);
else 
    disp('求解错误');
end
%u45为∇𝑓0(𝑥∗),u1为 ∇𝑓𝑖(𝑥∗), u3为∇ℎ(𝑥∗)
u12=dual(Cons(1))
u3=dual(Cons(2))
u45=dual(Cons(3))

f1=P*x1+Q
f2=G
f3=A



