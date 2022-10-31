clc
clear all
%% ԭ����
x=sdpvar(2,1);%���߱���
G=[1 2;4 3;-1 0;0 -1];
h=[40 120 0 0]';
A=[1 1];
b=30;
fi=G*x-h;
h=A*x-b;
Constraints = [
    fi<=0
     h==0
    ];%Լ������
P=[4 0;0 6];
q=[40 50]';
Obj=0.5*x'*P*x+q'*x;%Ŀ�꺯��
options = sdpsettings('verbose',2,'solver','gurobi');%��������
result = solvesdp(Constraints,Obj,options);%���
if result.problem==0
    s_x=value(x)%output
    s_z=value(Obj)
    plot(Constraints);
else
    disp('������')
end

%% �۲��ż����
U1=dual(Constraints(1))%���u1-u4
U2=dual(Constraints(2))%���u5

%% �����ݶ�
grad_f0=value(jacobian(Obj,x))%f0(x*)���ݶ�
grad_f1=full(value(jacobian(fi,x)))%f1(x*)���ݶ�
grad_h=full(value(jacobian(h,x)))%h(x*)���ݶ�