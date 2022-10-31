clc
% x1=sdpvar(1);
% x2=sdpvar(1);
% st=[];
% st=[st,x1+2*x2<=40 ,4*x1+3*x2<=120,x1>=0,x2>=0 ];
% z=60*x1+20*x2;
% ops=sdpsettings('solver', 'gurobi');
% result=solvesdp(st,-z,ops);
% z=value(z)
% x1=value(x1)
% x2=value(x2)
%% 原问题
x=sdpvar(2,1);
A=[40 50];
z=A*x;
E=[1 2;
   4 3;
   1 1;
  -1 -1];
b=[40;
   120;
   30;
   -30];
st=[];
st=[E*x<=b,x>=0];
% st=st+[x>=0];
ops=sdpsettings('solver', 'gurobi');
result=solvesdp(st,-z,ops);
if   result.problem == 0  %%   有解
 % Extract and display value
 s_z=value(z)
 s_x=value(x)
 %% dual problem
Z1=dual(st(1));
c=[40 120 30 -30];
k=c*Z1;
s_k=value(k)
 else
  display('错了亲！');
  result.info
  yalmiperror(result.problem)
  flag=5;%t=0  %%MP2 unbounded 无解标志位置0
end 
%% dual problem
% y=sdpvar(4,1);
% K=c*y;
% B=[1 4 1 -1;
%    2 3 1 -1];
% F=[40;
%    50];
% st1=[];
% st1=[B*y>=F,y>=0];
% result=solvesdp(st1,K,ops);
% s_K=value(K)
% s_y=value(y)
