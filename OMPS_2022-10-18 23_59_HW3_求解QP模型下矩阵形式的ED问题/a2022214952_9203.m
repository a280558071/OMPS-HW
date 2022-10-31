clc;
clear all;
cons=[];
x=sdpvar(2,1);
P=[4 0;0 6];
q=[40;50];
G=[1 2;4 3];
h=[40;120];
b=[1 1];
cons=[cons,G*x<=h,x(1)+x(2)==30,x>=0];
ops = sdpsettings('solver','gurobi','showprogress',1);
z=1/2*x'*P*x+q'*x;
result = optimize(cons,z,ops);
if result.problem == 0    %求解成功
    value(x)
    value(z)
    else
    disp('求解过程中出错');
end

f0=P*s_x+q  
fi=G        
h=b      