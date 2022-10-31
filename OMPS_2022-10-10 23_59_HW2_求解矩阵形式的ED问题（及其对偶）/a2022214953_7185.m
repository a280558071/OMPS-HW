 clear
%%original problem
x=sdpvar(2,1);%���߱���
A=[1 2;4 3;1 1;-1 -1];
b=[40 120 30 -30]';
h=[0 0]';
Constraints = [
    A*x<=b
    x(1)>=0
    x(2)>=0
    ];%Լ������
c=[40 50];
z = c*x;%Ŀ�꺯��
options = sdpsettings('verbose',2,'solver','gurobi');%��������
result = solvesdp(Constraints,-z,options);%���
if result.problem==0
    s_x=value(x)%output
    s_z=value(z)
    plot(Constraints);
    axis([0,50,0,60]);
else
    disp('������')
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
    ];%Լ������    
c1=[40 120 30 -30];
z1 = c1*u;
options = sdpsettings('verbose',2,'solver','gurobi');%��������
result1 = solvesdp(Constraints,z1,options);%�����Сֵ
if result1.problem==0
    s_u=value(u)%output
    s_z1=value(z1)
else
    disp('������')
end