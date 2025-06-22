%%
[x,y] = meshgrid(-4:0.2:4,-4:0.2:4); %三维网状图
z = exp(-0.5*(x.^2+y.^2)); 
mesh(x,y,z); 
xlabel('\bfx'); 
ylabel('\bfy'); 
zlabel('\bfz');


%%
t = 0:0.1:10;                       %三维线形图
x = exp(-0.2*t) .* cos(2*t); 
y = exp(-0.2*t) .* sin(2*t); 
plot3(x,y,t); 
title('\bfThree-Dimensional Line Plot'); 
xlabel('\bfx'); 
ylabel('\bfy'); 
zlabel('\bfTime'); 
axis square; 
grid on;


%%
[x,y] = meshgrid(-4:0.2:4,-4:0.2:4); %三维表面图
z = exp(-0.5*(x.^2+y.^2)); 
surf(x,y,z); 
xlabel('\bfx'); 
ylabel('\bfy'); 
zlabel('\bfz');


%%
[x,y] = meshgrid(-4:0.2:4,-4:0.2:4); %三维等高线图
z = exp(-0.5*(x.^2+y.^2)); 
contour(x,y,z); 
xlabel('\bfx'); 
ylabel('\bfy'); 
zlabel('\bfz');


%%
b = {[1 2], 17, [2;4]; 3-4i, 'Hello', eye(3)};%显示结构体变量的具体变量
cellplot(b);


%%
D=50;
beta = 1.5;
sigma_u = ((gamma(1 + beta) * sin(pi * beta / 2)) / (gamma((1 + beta) / 2) * beta * 2^((beta - 1) / 2)))^(1 / beta);
sigma_v = 1;
u = normrnd(0, sigma_u, 1, D);
v = normrnd(0, sigma_v, 1, D);
step = u ./ (abs(v).^(1 / beta));
plot(step,'.');


%%          levy_fly
% 参数设置
numSteps = 1000; % 飞行步数
beta = 1.5; % Levy分布的指数参数，范围 (0, 2]
s = 1; % 步长缩放因子

% 初始化位置
x = zeros(1, numSteps);
y = zeros(1, numSteps);

for i = 2:numSteps
    % 生成服从标准正态分布的随机数
    u = normrnd(0, 1);
    v = normrnd(0, 1);
    % 计算分子部分
    sigma_u = (gamma(1 + beta) * sin(pi * beta / 2) / (gamma((1 + beta) / 2) * beta * 2^((beta - 1) / 2)))^(1 / beta);
    % 计算Levy步长
    step = sigma_u * u / (abs(v)^(1 / beta));
    % 生成随机方向
    theta = 2 * pi * rand();
    % 更新位置
    x(i) = x(i - 1) + s * step * cos(theta);
    y(i) = y(i - 1) + s * step * sin(theta);
end

% 绘制Levy飞行轨迹
plot(x, y, 'b-');
title('Levy Flight Trajectory');
xlabel('X');
ylabel('Y');
grid on;   


%%