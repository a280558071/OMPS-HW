clear all;
close all;
%% ԭ����
x=sdpvar(2,1);
q=[40;50];
P=[4,0;0,6];
A=[1,2;4,3;1,-1;-1,-1];
b=[40;120;30;-30];
z=(1/2)*x'*P*x+q'*x;
Cons=[A*x<=b,x>=0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,z,ops); 
s_x=value(x),s_z=value(z)
%% ��ż����
u1=dual(Cons(1))
%% �ݶ�
% ��f0(x*)=P*(x*)+q=[120;110];
% ��fi(x*)=[1,2;4,3];
% ��h(x*)=[1;1];