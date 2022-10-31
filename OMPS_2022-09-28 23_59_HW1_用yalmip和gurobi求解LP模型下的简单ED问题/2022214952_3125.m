function [x,y]=Gurobi_LP
cons=[];
x=sdpvar(1,2);
y=-(60*x(1)+20*x(2));
%% 约束条件    
cons=[cons,x(1)+2*x(2)<=40];    
cons=[cons,4*x(1)+3*x(2)<=120];     
cons=[cons,x(1)>=0];    
cons=[cons,x(2)>=0];

ops = sdpsettings('solver','gurobi','showprogress',1); 
result = optimize(cons,y,ops);
if result.problem == 0    %求解成功
    x_star = double(x)
    y_star = double(-y)
    else
    disp('求解过程中出错');
end

