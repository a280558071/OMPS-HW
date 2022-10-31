 clear
%%original problem
x=sdpvar(2,1);%决策变量
A=[1 2;4 3;1 1;-1 -1];
b=[40 120 30 -30]';
h=[0 0]';
Constraints = [
    A*x<=b
    x(1)>=0
    x(2)>=0
    ];%约束条件
c=[40 50];
z = c*x;%目标函数
options = sdpsettings('verbose',2,'solver','gurobi');%参数设置
result = solvesdp(Constraints,-z,options);%求解
if result.problem==0
    s_x=value(x)%output
    s_z=value(z)
    plot(Constraints);
    axis([0,50,0,60]);
else
    disp('求解出错')
end


%%dual problem
u=sdpvar(4,1);
A1=[1 4 1 -1;2 3 1 -1];
b1=[40 50]';
Constraints = [
    A1*u>=b1
    u(1)>=0
    u(2)>=0
    u(3)>=0
    u(4)>=0
    ];%约束条件    
c1=[40 120 30 -30];
z1 = c1*u;
options = sdpsettings('verbose',2,'solver','gurobi');%参数设置
result1 = solvesdp(Constraints,z1,options);%求解最小值
if result1.problem==0
    s_u=value(u)%output
    s_z1=value(z1)
else
    disp('求解出错')
end