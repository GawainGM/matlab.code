function text_CS()
% 布谷鸟算法MATLAB实现
% 示例测试函数：Sphere函数（可替换为其他目标函数）

% 初始化种群 → 评估适应度 → 记录最优解
%     ↓
% While (未达最大迭代次数)
%     ↓
% 莱维飞行生成新解 → 评估 → 贪婪选择更新种群
%     ↓
% 按概率pa发现并替换劣解 → 评估 → 更新最优解
%     ↓
% 迭代结束，输出最优解
close all;
clear;
clc;

% 参数设置
n = 25;          % 鸟巢数量(种群大小) 定
pa = 0.25;       % 发现概率 
max_iter = 1000; % 最大迭代次数 定
dim = 30;        % 问题维度 定
lb = -10;        % 搜索空间下界 传
ub = 10;         % 搜索空间上界 传
beta = 1.5;      % 莱维飞行参数 

% 初始化种群
nest = initialize_nests(n, dim, lb, ub);
fitness = evaluate_fitness(nest);

% 找到初始最优解
[best_fitness, best_idx] = min(fitness);
best_nest = nest(best_idx,:);

% 迭代优化
for iter = 1:max_iter
    % 通过莱维飞行生成新解
    new_nest = get_cuckoos(nest, best_nest, lb, ub, beta);
    new_fitness = evaluate_fitness(new_nest);
    
    % 选择较优解
    replace_idx = new_fitness < fitness;
    nest(replace_idx,:) = new_nest(replace_idx,:);
    fitness(replace_idx) = new_fitness(replace_idx);
    
    % 通过概率pa发现部分解并替换
    nest = abandon_nests(nest, pa, lb, ub);
    fitness = evaluate_fitness(nest);
    
    % 更新全局最优解
    [current_best, idx] = min(fitness);
    if current_best < best_fitness
        best_nest = nest(idx,:);
        best_fitness = current_best;
    end
    
    % 显示迭代信息
    if mod(iter,100) == 0
        fprintf('Iteration %d: Best Fitness = %.4e\n', iter, best_fitness);
    end
end

% 输出最终结果
fprintf('\nOptimization Completed!\n');
fprintf('Best Solution:\n');
disp(best_nest);
fprintf('Best Fitness = %.4e\n', best_fitness);
end

% 初始化鸟巢函数
function nests = initialize_nests(n, dim, lb, ub)
nests = lb + (ub - lb).*rand(n, dim);
end

% 评估适应度函数（示例为Sphere函数）
function fitness = evaluate_fitness(pop)
fitness = sum(pop.^2, 2); % 行求和
end

% 莱维飞行生成新解
function new_nest = get_cuckoos(nest, best_nest, lb, ub, beta)
[n, dim] = size(nest);
sigma = (gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);

for i = 1:n
    s = nest(i,:);
    % 莱维飞行步长
    u = randn(1,dim)*sigma;
    v = randn(1,dim);
    step = u./abs(v).^(1/beta);
    
    % 步长缩放
    stepsize = 0.01*step.*(s - best_nest);
    
    % 更新位置并保持边界
    new_s = s + stepsize.*randn(1,dim);
    new_nest(i,:) = min(max(new_s, lb), ub);
end
end

% 发现并替换劣质解
function nest = abandon_nests(nest, pa, lb, ub)
[n, dim] = size(nest);
k = rand(n,dim) < pa;
steps = rand(n,dim).*(nest(randperm(n),:) - nest(randperm(n),:));
new_nest = nest + steps.*k;
nest = min(max(new_nest, lb), ub); % 保持边界
end