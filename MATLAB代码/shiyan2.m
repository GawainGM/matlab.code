%% figure(1); 
% subplot(2,1,1); 
% x = -pi:pi/20:pi; 
% y = sin(x); 
% plot(x,y); 
% title('Subplot 1 title'); 
% subplot(2,1,2);
% x = -pi:pi/20:pi;
% y = cos(x); 
% plot(x,y); 
% title('Subplot 2 title');


%% g = 0.5; 
% theta = 0:pi/20:2*pi;
% gain = 2*g*(1+cos(theta));
% plot(gain)
% polar (theta,gain,'r-'); 
% title ('Gain versus angle \it\theta');


%% x=0:pi/100:2*pi;
% y1=sin(2*x);
% y2=2*cos(2*x);
% plot(x,y1,'k-',x,y2,'b--');
% title(' Plot of f(x)=sin(2x) and its derivative');
% xlabel('num');
% ylabel('summer');
% legend('f(x)','d/dx f(x)') 
% grid on;

%% 线性规划，求成本最小值
% a=[66 45 55 61 72 56 60 49 96 78 47 63 61 59 66];%火车单位成本
% b=[35 24 55 31 38 31 28 24 36 43 26 36 32 59 33];%轮船成本
% c=[28.5 23.8 0 27.5 30.3 26.5 27.0 25.0 23.0 31.8 24.0 27.5 26.8 0 28.3];%第三个表的轮船投资
% d=b+c;%轮船总的单位成本
% f=zeros(1,15);
%  for ii=1:15
%     if d(ii)<=a(ii)
%         f(ii)=d(ii);
%     else
%         f(ii)=a(ii);
%     end
% end
% A=[ 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
%     0 0 0 0 0 1 1 1 1 1 0 0 0 0 0
%     0 0 0 0 0 0 0 0 0 0 1 1 1 1 1
%     1 0 0 0 0 1 0 0 0 0 1 0 0 0 0
%     0 1 0 0 0 0 1 0 0 0 0 1 0 0 0
%     0 0 1 0 0 0 0 1 0 0 0 0 1 0 0
%     0 0 0 1 0 0 0 0 1 0 0 0 0 1 0
%     0 0 0 0 1 0 0 0 0 1 0 0 0 0 1];
% B=[1500;2000; 1500; 800; 900; 1000; 1100; 1200];
% lb=zeros(15,1);
% 
% [x1,fval1]=linprog(a,[],[],A,B,lb);
% disp(x1);
% disp(fval1);
% 
% [x2,fval2]=linprog(d,[],[],A,B,lb);
% disp(x2);
% disp(fval2);
% 
% [x3,fval3]=linprog(f,[],[],A,B,lb);
% disp(x3);
% disp(fval3);


%%
% 数据读取（示例：催化剂A1）
T = [250 275 300 325 350 400]; % 温度数据
X = [4.4
7.9
11.7
17.8
30.2
69.4
];      % 乙醇转化率
X=X';
S = [4.08
6.62
12.86
18.45
25.05
38.17
];      % C4选择性
S=S';
% 多项式拟合（二次）
p_X = polyfit(T, X, 2);     %乙醇转化率与温度的函数多项式的系数
p_S = polyfit(T, S, 2);     %C4选择性与温度的函数多项式的系数

% 插值
T_fine = 250:2:400;
X_fit = polyval(p_X, T_fine);
S_fit = polyval(p_S, T_fine);

% 绘图
figure;
subplot(1,2,1);
plot(T, X, 'ro', T_fine, X_fit, 'b-');
xlabel('温度 (℃)'); ylabel('乙醇转化率 (%)');
legend('实验值', '拟合曲线');

subplot(1,2,2);
plot(T, S, 'ko', T_fine, S_fit, 'g-');
xlabel('温度 (℃)'); ylabel('C4选择性 (%)');
legend('实验值', '拟合曲线');


%%
% % 时间序列数据平滑
% t = [20 70 110 163 197 240 273]; % 时间（min）
% X_raw = [43.5 37.8 36.6 32.7 31.7 29.9 29.9];
% X_smooth = movmean(X_raw, 3); % 3点移动平均
% 
% % 绘图
% figure;
% plot(t, X_raw, 'b--', t, X_smooth, 'r-', 'LineWidth', 1.5);
% xlabel('时间 (min)'); ylabel('乙醇转化率 (%)');
% legend('原始数据', '平滑后数据');


%%
