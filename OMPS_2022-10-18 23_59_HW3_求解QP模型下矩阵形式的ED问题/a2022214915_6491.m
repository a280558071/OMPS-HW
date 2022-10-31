clear all;
clc

%% set parameters %%
x=sdpvar(2,1);
P=[4 0;0 6];
q=[40;50];
G=[1 2;4 3];
h=[40;120];
A=[1 1];% 这里虽然是向量但是为了Ax=b的形式 还是用大写了
b=30;% 运行可知b=30和b=[30]的结果相同
ops = sdpsettings('solver', 'gurobi', 'verbose', 1);

%% minimize the total fuel cost %%
obj=1/2*x'*P*x+q'*x;
Cons=[G*x<=h;A*x==b;x>=0];
sol = optimize(Cons, obj, ops);

res = struct();
res.obj=double(obj);
res.x=double(x); 
% x1=20 x2=10
%% observe the dual variables%%  
% 10 0 -130 0 0
% 如果约束用两个不等式夹逼等式应该是130
u1_dual=dual(Cons(1));
u2_dual=dual(Cons(2));
u3_dual=dual(Cons(3));

%% calculate the gradient %%
%▽f_0(x*)=P*(x*)+q=[120 110] 对于QP来说，一般目标函数的梯度应该等于 P*x+q
%▽f_i(x*)=G=[1 2;4 3]; 不等式约束的梯度由系数矩阵G决定
%▽h(x*)=A=[1 1]; 等式约束的梯度由系数矩阵A决定