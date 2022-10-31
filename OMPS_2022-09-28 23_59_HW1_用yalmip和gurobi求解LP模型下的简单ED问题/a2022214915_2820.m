x=sdpvar(2,1); %decision variables
obj=60*x(1)+20*x(2); %objective function
Cons=[x(1)+2*x(2)<=40];
Cons=[Cons,4*x(1)+3*x(2)<=120];
Cons=[Cons,x(1)>=0,x(2)>=0];

ops = sdpsettings('solver', 'gurobi', 'verbose', 1);
sol = optimize(Cons, -obj, ops);
s_x=value(x)
s_obj=value(obj)
% plot(Cons); axis[0 60 0 50]
