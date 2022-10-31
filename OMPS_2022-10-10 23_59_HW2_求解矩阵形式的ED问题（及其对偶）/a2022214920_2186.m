clear;
clc;
close all;
%maximize profit
x=sdpvar(2,1);
c=[40,50];
a=[1,2;4,3;1,1;-1,-1];
b=[40;120;30;-30];
C=[a*x<=b,x(1)>=0,x(2)>=0];
ops=sdpsettings('verbose',0,'solver','gurobi');
z=-(c*x);
result=optimize(C,z,ops);
if result.problem == 0%problem=0代表求解成功
    value(x)
    -value(z)
    plot(C);
    axis([0,50,0,50]);
else
    disp('求解错误');
end
%minimize cost
x1=sdpvar(4,1);
c1=[40,50];
a1=[1,2;4,3;1,1;-1,-1];
b1=[40;120;30;-30];
C1=[a1'*x1>=c1',x1(1)>=0,x1(2)>=0,x1(3)>=0,x1(4)>=0];
ops=sdpsettings('verbose',0,'solver','gurobi');
z1=b1'*x1;
result1=optimize(C1,z1,ops);
if result1.problem == 0%problem=0代表求解成功
    value(x1)
    value(z1)
else
    disp('求解错误');
end