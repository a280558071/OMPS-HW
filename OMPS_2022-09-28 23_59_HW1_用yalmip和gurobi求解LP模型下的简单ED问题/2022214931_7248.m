clear;
clc;
close all;
x = sdpvar( 2,1 );
c = [60,20];
a = [1,2;4,3];
b = [40;120];
C = [ a*x<=b,x(1)>=0,x(2)>=0 ];
ops = sdpsettings('verbose',0,'solver','gurobi');
z = -( c*x );
reuslt = optimize( C,z,ops );
if reuslt.problem == 0 % problem =0 代表求解成功
    value(x)
    -value(z)
    plot(C);
    axis([0,50,0,50]);
else
    disp('求解出错');
end
% created by 王浩然（学号2022214931）