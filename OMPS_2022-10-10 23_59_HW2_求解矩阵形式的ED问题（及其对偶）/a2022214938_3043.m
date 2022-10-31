clear;
clc;
close all;
x = sdpvar( 2,1 );
c = [40,50];
a = [1,2;
     4,3;
     1,1];
n = [40;120;30];
m = sdpvar( 2,1 );
C = [ a*x+m=n;x(1)>=0;x(2)>=0;m(1)>=0;m(2)>=0 ];
ops = sdpsettings('verbose',0,'solver','gurobi');
z = -( c*x );
reuslt = optimize( C,z,ops );
if reuslt.problem == 0 
    value(x);
    dual_x = dual(C(1));
    dual_z = dual_x'*n;
    -value(z);
    plot(C);
    axis([0,50,0,50]);
else
    disp('Something is error');
end