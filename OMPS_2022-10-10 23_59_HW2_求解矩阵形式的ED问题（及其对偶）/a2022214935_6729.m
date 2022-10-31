
x = sdpvar( 2,1 );
c = [60,20];
a = [1,2;
     4,3;
     1,1;
     1,1];
b = [40;120;30;30];
con = [ a*x<=b,x(1)>=0,x(2)>=0 ];
ops = sdpsettings('verbose',0,'solver','gurobi');
z = -( c*x );
reuslt = optimize( con,z,ops );
value(x);
dual_x = dual(con(1));
dual_z = dual_x'*b
-value(z)
plot(C);
axis([0,50,0,50]);