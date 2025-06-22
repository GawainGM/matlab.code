%%
x=-2:0.2:2;
y=exp(x);
plot(x,y,"k+");
title('指数函数e^x图像');
xlabel('x');
ylabel('y');
grid on;
legend('e^x');

%%
x=0:10;
fprintf('%d\n',x);
fprintf('%d ',x);

%%
a=[1 3 5];
b=1:2:10;
c=zeros(2,3);
s=input('Please enter a number:');

%%
z=zeros(5);
z(2,3)=5;

%%
a=3;
b=2;
c=a/b;

%%
x=[1,2,0,1];
y=[0,3,0,0];
z=[-1,1,0,-1];
plot3(x,y,z);
xlabel('x');
ylabel('y');
zlabel('z');
grid on;

%%
x = 0:0.1:2; 
y = x .^2; 
Hnd1 = plot(x, y); 
propedit(Hnd1);

%%
 a=zeros(4);
 b=zores(4);
 for i=0:3
     for j=0:3
         a(i+1,j+1)=i.*j;
         b(i+1,j+1)=i+j;
     end
 end
 c=a+b;

 %%
 