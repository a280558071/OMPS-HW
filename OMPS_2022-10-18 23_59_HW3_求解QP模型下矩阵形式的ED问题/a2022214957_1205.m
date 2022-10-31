clc;
clear;
X=sdpvar(2,1);
A=[2 0;0 3];
B=[40;50];
Z=X'*A*X+B'*X;
C=[1 2;4 3;1 1;-1 -1];
D=[-40;-120;-30;30];
Cons=[C*X+D<=0,X(1)>=0,X(2)>=0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,Z,ops);
s_X=value(X),s_Z=value(Z)
plot(Cons);
axis([0,60,0,50]);
%求▽f0(X*)、▽f1(X*) 、▽f2(X*)、▽h(X*),分别记作s1、s2、s3、s4
s1=[4*X(1)+40;6*X(2)+50];
s2=[1;2];
s3=[4;3];
s4=[1;1];
s_s1=value(s1),s_s2=value(s2),s_s3=value(s3),s_s4=value(s4)