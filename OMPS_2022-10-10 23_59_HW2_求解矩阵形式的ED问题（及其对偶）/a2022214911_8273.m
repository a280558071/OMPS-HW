clear all;close all;
%% Max Profit & Dual Problem
x = sdpvar(2,1);
c = [40 50];
z = c * x;
A = [1 2;
      4 3;
      1 1;
     -1 -1];
 b = [40;120;30;-30];
Cons1 = [x >= 0, (A*x <= b):'gurobi'];
ops = sdpsettings('verbose',0);
sol = optimize(Cons1,-z,ops);
if(~sol.problem)
    % Max Profit Solution
    fprintf('Max Profit Result:');
    result_x = value(x)
    result_z = value(z)
    
    fprintf('................................................\n');
    fprintf('Dual Problem Result:');
    % Dual Problem Solution
    u_dual = dual(Cons1(2));
    % Reduce the number of decision variables to 3.
    u = u_dual(1:3);
    u(3) = u_dual(3)-u_dual(4);
    u
    z_dual = b.'*u_dual
else
    fprintf('Error!');
end
%% Validation For Above Dual Problem Result
fprintf('................................................\n');
fprintf('Validation For Above Dual Problem Result:');
% Rewrite the minimize cost problem including 3 decision variables.
x2 = sdpvar(3,1);
c2 = [40 120 30];
z2 = c2 * x2;
A2 = [1 4 1;
      2 3 1];
b2 = [40;50];
% 3th variable unrestricted.
Cons2 = [x2(1:2) >= 0, (A2*x2 >= b2):'gurobi'];
sol = optimize(Cons2,z2,ops);
if(~sol.problem)
    dulResult_x  = value(x2)
    dualResult_z = value(z2)
else
    fprintf('Error!');
end