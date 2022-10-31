%% solve it by Yalmip and GUROBI
x=sdpvar(2,1);
z=60*x(1)+20*x(2);
Cons=[x(1)+2*x(2)<=40,...
4*x(1)+3*x(2)<=120,...
x(1)>=0,x(2)>=0];
ops=sdpsettings('solver','gurobi');
sol=optimize(Cons,-z,ops);
% max z is equivalent to min (-z)
s_x=value(x),s_z=value(z)
% plot the feasible region limited by
% the constraints
plot(Cons);
axis([0,60,0,50]);