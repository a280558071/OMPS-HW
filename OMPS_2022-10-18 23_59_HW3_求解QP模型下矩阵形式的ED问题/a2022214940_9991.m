clc
x=sdpvar(2,1);
P=[4 0;
   0 6];
Q=[40;50];
r=0;
z=x'*P*x/2+Q'*x+r;
A=[1 2;
   4 3];
B=[1 1];
b=[40;
   120];
st=[];
st=[A*x<=b,B*x==30,x>=0];
ops=sdpsettings('solver', 'cplex');
result=solvesdp(st,z,ops);
if   result.problem == 0  %%   有解
 % Extract and display value
 s_z=value(z)
s_x=value(x)
u_1=dual(st(1));
u_2=dual(st(2));
s_u1=value(u_1)
s_u2=value(u_2)
m=P*s_x+Q ;%obj 一阶导数
n=A;  %不等式一阶导数
h=B;  %等式一阶导数
value(m)
value(n)
value(h)
  else
  display('错了亲！');
  result.info
  yalmiperror(result.problem)
  flag=5;%t=0  %%MP2 unbounded 无解标志位置0
end 
