x=sdpvar(2,1);
A=[1,2;4,3];
b=[40;120];
c=[40,50];
z=c*x;
Cons1=[A*x<=b,x(1)+x(2)==30,x(1)>=0,x(2)>=0];
u=sdpvar(4,1);% u(3)表示u3',u(4)表示u3",u3=u3'-u3"
AA=[1,4,1,-1;2,3,1,-1];
B=[40;50];
C=[40,120,30,-30];
w=C*u;
Cons2=[AA*u>=B,u(1)>=0,u(2)>=0,u(3)>=0,u(4)>=0];% 对偶
ops=sdpsettings('solver','gurobi');
sol1=optimize(Cons1,-z,ops); 
sol2=optimize(Cons2,w,ops); 
s_x=value(x),s_z=value(z),s_u=value(u),s_w=value(w)