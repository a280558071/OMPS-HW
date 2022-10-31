clear all;close all;
%% Initialize the Graph
startNode = [1;1;2;3;4];
endNode = [2;3;3;4;2];
[orderedNode,IN] = myincidence(startNode,endNode);
%% Define Variables and Constraints
% decision variables
g = sdpvar(2,1);
p = sdpvar(5,1);
theta = sdpvar(4,1);
% objective function: min z = g1^2 + 40g1 + g2^2 + 50g2
P = [1 0;0 1];
q = [40;50];
z = g.'*P*g + q.'*g;
% constraints: A*g<=b; g>=0; IN*p=g-d; IN.'*theta=p.*X;
A = [1 2;4 3];
b = [40;120];
g_all = [g;0;0];
d = [0;0;10;20];
X = [0.01;0.01;0.01;0.02;0.01];
Cons = [A*g<=b; g>=0; IN*p==g_all-d; IN.'*theta==p.*X; p<=20; p>=-20];
% solve
ops = sdpsettings('verbose',0,'solver','gurobi');
sol = optimize(Cons,z,ops);
if(~sol.problem)
    s_g = value(g)
    s_p = value(p)
    s_theta = value(theta)
    s_z = value(z)
    % visualization
    G = digraph(startNode,endNode);
    pic = plot(G);
    %layout(pic,'layered');
    labeledge(pic,1:numedges(G),s_p);% 画出线路潮流
    for i = 1:4
        if(i<3)
            strMat{i,1}=[num2str(orderedNode(i,1)),',',num2str(s_g(i,1)),',',num2str(d(i,1)),',',num2str(s_theta(i,1))];
        else
            strMat{i,1}=[num2str(orderedNode(i,1)),',',num2str(0),',',num2str(d(i,1)),',',num2str(s_theta(i,1))];
        end
    end
    labelnode(pic,1:numnodes(G),strMat);% 按编号、p、d、theta排列节点求解信息
else
    printf('Optimal result not found!');
end
%% 该函数负责生成节点关联矩阵，考虑了非连续\编号不从0开始的情况，将节点从小到大排列
function [orderedNode,y] = myincidence(startNode,endNode)
uniNode = unique([startNode;endNode]);
orderedNode= sort(uniNode);
y = zeros(size(uniNode,2),size(startNode,1));
for i = 1:size(startNode,1)
    y(orderedNode==startNode(i,1),i) = 1;
    y(orderedNode==endNode(i,1),i) = -1;
end
end
