function f=TEC_test_function(x,fun)

[~,D]=size(x);

if fun==1
    %sphere
    f=sum(x.^2,2); %a=sum(x);列求和 a=sum(x,2); 行求和 a=sum(x(:));矩阵求和 “.”矩阵对应位置相乘

elseif fun==2
    %schwefel2.22
    f=sum(abs(x),2)+prod(abs(x),2);
    
elseif fun==3
    %schwefel1.2
    f=0;
    for i=1:D
        f=f+sum(x(1:i))^2;
    end
    
elseif fun==4
    %schwefel2.21
    f=max(abs(x));
    
elseif fun==5
    %rosenbrock
    f=sum(100.*(x(:,1:D-1).^2-x(:,2:D)).^2+(x(:,1:D-1)-1).^2,2);

elseif fun==6
    %step
    f=sum(floor(x+0.5).^2,2);
    
elseif fun==7
    %quartic with noise
    f=0;
    for i=1:D
        f=f+i*x(i)^4;
    end
    f=f+rand;
    
elseif fun==8
    %schwefel2.26
    f=0;
    for i=1:D
        f=f+x(i)*sin(sqrt(abs(x(i))));
    end
    f=418.9829*D-f;

elseif fun==9
    %rastrigin
    f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
    
elseif fun==10
    %ackley
    f=sum(x.^2,2);
    f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);
    
elseif fun==11
    %griewank
    f=1;
    for i=1:D
        f=f.*cos(x(:,i)./sqrt(i));
    end
    f=sum(x.^2,2)./4000-f+1;

elseif fun==12
    %penalized1
    f=10*sin(pi*(1+0.25*(x(1)+1)))^2;
    for i=1:D-1
        f=f+(0.25*(x(i)+1))^2*(1+10*sin(pi*(1+0.25*(x(i+1)+1)))^2);
    end
    f=(f+(0.25*(x(D)+1))^2)*pi/D;
    for i=1:D
        if x(i)>10
            f=f+100*(x(i)-10)^4;
        elseif x(i)<-10
            f=f+100*(-x(i)-10)^4;
        end
    end
    
elseif fun==13
    %penalized2
    f=sin(3*pi*x(1))^2;
    for i=1:D-1
        f=f+(x(i)-1)^2*(1+sin(3*pi*x(i+1))^2);
    end
    f=(f+(x(D)-1)^2*(1+sin(2*pi*x(D))^2))*0.1;
    for i=1:D
        if x(i)>5
            f=f+100*(x(i)-5)^4;
        elseif x(i)<-5
            f=f+100*(-x(i)-5)^4;
        end
    end

elseif fun==14
    %shift sphere
    x=x-2;
    f=sum(x.^2,2);    
    
elseif fun==15
    %shift schwefel1.2
    x=x-2;
    f=0;
    for i=1:D
        f=f+sum(x(1:i))^2;
    end
    
elseif fun==16
    %shift schwefel1.2 with noise
    x=x-2;
    f=0;
    for i=1:D
        f=f+(sum(x(1:i))^2)*(1+0.4*rand);
    end
    
elseif fun==17
    %shift griewank
    x=x-2;
    f=1;
    for i=1:D
        f=f.*cos(x(:,i)./sqrt(i));
    end
    f=sum(x.^2,2)./4000-f+1;
    
elseif fun==18
    %shift ackley
    x=x-2;
    f=sum(x.^2,2);
    f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);
    
elseif fun==19
    %shift penalized1
    x=x-2;
    f=10*sin(pi*(1+0.25*(x(1)+1)))^2;
    for i=1:D-1
        f=f+(0.25*(x(i)+1))^2*(1+10*sin(pi*(1+0.25*(x(i+1)+1)))^2);
    end
    f=(f+(0.25*(x(D)+1))^2)*pi/D;
    for i=1:D
        if x(i)>10
            f=f+100*(x(i)-10)^4;
        elseif x(i)<-10
            f=f+100*(-x(i)-10)^4;
        end
    end
    
elseif fun==20
    %shift penalized2
    x=x-2;
    f=sin(3*pi*x(1))^2;
    for i=1:D-1
        f=f+(x(i)-1)^2*(1+sin(3*pi*x(i+1))^2);
    end
    f=(f+(x(D)-1)^2*(1+sin(2*pi*x(D))^2))*0.1;
    for i=1:D
        if x(i)>5
            f=f+100*(x(i)-5)^4;
        elseif x(i)<-5
            f=f+100*(-x(i)-5)^4;
        end
    end
    
elseif fun==21
    %shift rastrigin
    x=x-2;
    f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
    
elseif fun==22
    %shift rosenbrock
    x=x-2;
    f=sum(100.*(x(:,1:D-1).^2-x(:,2:D)).^2+(x(:,1:D-1)-1).^2,2);
    
end

function y = w(x,c1,c2)
y = zeros(length(x),1);
for k = 1:length(x)
	y(k) = sum(c1 .* cos(c2.*x(:,k)));
end