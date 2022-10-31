clear all;
clc;

%% set parameters %%
x=sdpvar(2,1);
u=sdpvar(4,1);
c=[40 50];
A=[1 2;4 3;1 1;-1 -1];
b=[40;120;30;-30];
ops = sdpsettings('solver', 'gurobi', 'verbose', 1);
%% maximize profit %%
Cons=[A*x<=b;x(1)>=0;x(2)>=0];
obj= c*x;
sol = optimize(Cons, -obj, ops);

res = struct();
res.obj=double(obj);
res.x=double(x);

% u_dual=dual(Cons(1)); % Verify the results of the dual problem
%% dual problem-minimize cost %%
Cons_dual=[A'*u>=c';u>=0];
obj_dual=b'*u;
sol_dual=optimize(Cons_dual,obj_dual,ops);

res.u=double(u);
res.obj_dual=double(obj_dual);

