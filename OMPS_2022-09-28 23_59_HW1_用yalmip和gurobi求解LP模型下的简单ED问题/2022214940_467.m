clc
x1=sdpvar(1);
x2=sdpvar(1);
st=[];
st=[st,x1+2*x2<=40 ,4*x1+3*x2<=120,x1>=0,x2>=0 ];
z=60*x1+20*x2;
ops=sdpsettings('solver', 'gurobi');
result=solvesdp(st,-z,ops);
z=value(z)
x1=value(x1)
x2=value(x2)