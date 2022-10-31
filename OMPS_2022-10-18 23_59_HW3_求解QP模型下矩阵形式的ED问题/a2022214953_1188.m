clc
clear all
%% 原问题
x=sdpvar(2,1);%决策变量
G=[1 2;4 3;-1 0;0 -1];
h=[40 120 0 0]';
A=[1 1];
b=30;
fi=G*x-h;
h=A*x-b;
Constraints = [
    fi<=0
     h==0
    ];%约束条件
P=[4 0;0 6];
q=[40 50]';
Obj=0.5*x'*P*x+q'*x;%目标函数
options = sdpsettings('verbose',2,'solver','gurobi');%参数设置
result = solvesdp(Constraints,Obj,options);%求解
if result.problem==0
    s_x=value(x)%output
    s_z=value(Obj)
    plot(Constraints);
else
    disp('求解出错')
end

%% 观察对偶变量
U1=dual(Constraints(1))%输出u1-u4
U2=dual(Constraints(2))%输出u5

%% 计算梯度
grad_f0=value(jacobian(Obj,x))%f0(x*)的梯度
grad_f1=full(value(jacobian(fi,x)))%f1(x*)的梯度
grad_h=full(value(jacobian(h,x)))%h(x*)的梯度