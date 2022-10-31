%原问题求解
clc;clear;
x = sdpvar(2,1);
C1 = [40,50];
A1 = [1,2;4,3;1,1];
B1 = [40;120;30];
Cons1 = [A1(1:2,:)*x <= B1(1:2,:),A1(3,:)*x == B1(3,:),x(1)>=0,x(2)>=0];
ops = sdpsettings('verbose',0,'solver','gurobi');
z1 = -(C1*x);
result1 = optimize(Cons1,z1,ops);
if result1.problem == 0
    value(x)
    -value(z1)
else
    disp('error');
end

%对偶问题求解
%解法1，利用dual函数求解对偶问题
u1 = dual(Cons1(1));
u2 = dual(Cons1(2));
u1
u2
%解法2，转化为对偶问题求解
y = sdpvar(3,1);
C2 = B1';
A2 = A1';
B2 = C1';
Cons2 = [A2*y>=B2,y(1)>=0,y(2)>=0];
z2 = C2*y;
result2 =  optimize(Cons2,z2,ops);
if result2.problem == 0
    value(y)
    value(z2)
else
    disp('error');
end