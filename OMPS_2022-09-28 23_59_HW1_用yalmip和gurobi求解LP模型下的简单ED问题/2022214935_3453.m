x = sdpvar(2,1);
z=60*x(1)+20*x(2);
cons=[x(1)+2*x(2)<=40,4*x(1)+3*x(2)<=120,x(1)>=0,x(2)>=0];
ops=sdpsettings('solver','gurobi');
sol = optimize (cons,-z,ops);
sx=value(x)
sz=value(z)
plot(cons)
axis([0,60,0,60])

