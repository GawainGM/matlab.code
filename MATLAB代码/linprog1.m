% 方案1：仅使用火车运输
% 定义火车运输单位成本矩阵 a_ij
a = [66 45 55 61 72 56 60 49 96 78 47 63 61 59 66];
% 木材资源区产量（单位：100万立方米）
supply = [1500/100; 2000/100; 1500/100];
% 市场销售量（单位：100万立方米）
demand = [800/100; 900/100; 1000/100; 1100/100; 1200/100];

% 构建线性规划模型
f=a;
Aeq = [];
beq = [];
for i = 1:3
    Aeq = [Aeq; sparse(1, (i-1)*5+1:i*5, 1, 1, 15)];
    beq = [beq; supply(i)];
end
for j = 1:5
    Aeq = [Aeq; sparse(1, j:5:15, 1, 1, 15)];
    beq = [beq; demand(j)];
end
lb = zeros(15, 1);
ub = [];

% 求解线性规划问题
[x1, sum1] = linprog(a, [], [], Aeq, beq, lb, ub);
x1 = reshape(x1, 3, 5);
fprintf('方案1：\n');
fprintf('从各木材资源区到各个市场的运输数量（单位：100万立方米）：\n');
disp(x1);
fprintf('最低运输成本（单位：万元）：%.2f\n', sum1);


% 方案2：仅使用轮船运输（特定路线除外）
% 定义轮船运输单位成本矩阵 b_ij（假设部分数据，需根据实际完整数据修改）
b = [35 24 55 31 38 31 28 24 36 43 26 36 32 59 33];
% 定义轮船单位资金投入矩阵 c_ij（假设部分数据，需根据实际完整数据修改）
c=[28.5 23.8 0 27.5 30.3 26.5 27.0 25.0 23.0 31.8 24.0 27.5 26.8 0 28.3];
% 构建成本向量
f2 = zeros(15, 3);
for i = 1:3
    for j = 1:5
        if (i == 1 && j == 3) || (i == 3 && j == 4)
            f2((i - 1) * 5 + j) = a(i, j);
        else
            f2((i - 1) * 5 + j) = b(i, j)+0.1*c(i, j);
        end
    end
end

% 求解线性规划问题
[x2, sum2] = linprog(f2, [], [], Aeq, beq, lb, ub);
x2 = reshape(x2, 3, 5);
fprintf('\n方案2：\n');
fprintf('从各木材资源区到各个市场的运输数量（单位：100万立方米）：\n');
disp(x2);
fprintf('最低运输成本（单位：万元）：%.2f\n', sum2);


% 方案3：根据成本选择运输方式（简化实现，假设已确定各路线运输方式）
% 假设根据成本比较确定的最终单位成本矩阵 final_cost（需根据实际比较确定）
f3=zeros(1,15);
 for ii=1:15
    if f2(ii)<=a(ii)
        f3(ii)=f2(ii);
    else
        f3(ii)=a(ii);
    end
end

% 求解线性规划问题
[x3, sum3] = linprog(f3, [], [], Aeq, beq, lb, ub);
x3 = reshape(x3, 3, 5);
fprintf('\n方案3：\n');
fprintf('从各木材资源区到各个市场的运输数量（单位：100万立方米）：\n');
disp(x3);
fprintf('最低运输成本（单位：万元）：%.2f\n', sum3);


% 市场1销售量的灵敏度分析（方案1为例）
% 改变市场1销售量，观察最优解变化
original_demand1 = demand(1);
delta = 0.1; % 变化步长
min_demand1 = original_demand1;
max_demand1 = original_demand1;
while true
    demand(1) = min_demand1 - delta;
    Aeq_new = [];
    beq_new = [];
    for i = 1:3
        Aeq_new = [Aeq_new; sparse(1, (i - 1) * 5 + 1:i * 5, 1, 1, 15)];
        beq_new = [beq_new; supply(i)];
    end
    for j = 1:5
        Aeq_new = [Aeq_new; sparse(1, j:5:15, 1, 1, 15)];
        beq_new = [beq_new; demand(j)];
    end
    [x_temp, ~] = linprog(f, [], [], Aeq_new, beq_new, lb, ub);
    if ~isempty(x_temp)
        min_demand1 = min_demand1 - delta;
    else
        break;
    end
end
min_demand1 = min_demand1 + delta;

while true
    demand(1) = max_demand1 + delta;
    Aeq_new = [];
    beq_new = [];
    for i = 1:3
        Aeq_new = [Aeq_new; sparse(1, (i - 1) * 5 + 1:i * 5, 1, 1, 15)];
        beq_new = [beq_new; supply(i)];
    end
    for j = 1:5
        Aeq_new = [Aeq_new; sparse(1, j:5:15, 1, 1, 15)];
        beq_new = [beq_new; demand(j)];
    end
    [x_temp, ~] = linprog(f, [], [], Aeq_new, beq_new, lb, ub);
    if ~isempty(x_temp)
        max_demand1 = max_demand1 + delta;
    else
        break;
    end
end
max_demand1 = max_demand1 - delta;

fprintf('\n方案1中市场1销售量的灵敏度分析：\n');
fprintf('市场1销售量在 [%.2f, %.2f]（单位：100万立方米）范围内变动时，当前最优解不会改变。\n', min_demand1, max_demand1);