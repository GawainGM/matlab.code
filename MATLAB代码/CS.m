function [gbestval, g_res, CPUtime] = CS(fhd, fun, Xmin, Xmax)
    tic;

    % 参数设置
    ps = 5; % 鸟巢数量（等同于粒子群算法中的粒子数量）
    D = 50; % 问题维度
    Max_FES = 10000; % 最大迭代次数
    pa = 0.25; % 发现外来鸟蛋的概率

    % 初始化鸟巢位置
    nests = repmat(Xmin, ps, D) + (repmat(Xmax, ps, D) - repmat(Xmin, ps, D)).* rand(ps, D);

    % 计算初始适应度
    for i = 1:ps
        fitness(i) = feval(fhd, nests(i, :), fun);
    end
    fitcount = ps;

    % 找到当前最优鸟巢
    [gbestval, gbestid] = min(fitness);
    gbest = nests(gbestid, :);
    g_res = gbestval;

    % 迭代更新
    for FES=1:Max_FES
        % 生成新解
        for k = 1:ps
            % 莱维飞行生成新解
            new_nest = nests(k, :) + levy_flight(D);
            % 边界处理
            new_nest = max(new_nest, Xmin);
            new_nest = min(new_nest, Xmax);

            % 计算新解的适应度
            new_fitness = feval(fhd, new_nest, fun);

            % 随机选择一个鸟巢进行替换
            j = randi(ps);
            if new_fitness < fitness(j)
                nests(j, :) = new_nest;
                fitness(j) = new_fitness;
            end
        end

        % 部分鸟巢被发现并替换（宿主鸟发现外来鸟蛋）
        n = floor(pa * ps); % 被发现的鸟巢数量
        for i = 1:n
            j = randi(ps);
            nests(j, :) = repmat(Xmin, 1, D) + (repmat(Xmax, 1, D) - repmat(Xmin, 1, D)).* rand(1, D);
            fitness(j) = feval(fhd, nests(j, :), fun);
        end

        % 更新全局最优
        [current_bestval, current_bestid] = min(fitness);
        if current_bestval < gbestval
            gbestval = current_bestval;
            gbest = nests(current_bestid, :);
        end

        g_res = [g_res gbestval];
    end

    CPUtime = toc;
end

% 莱维飞行函数
function step = levy_flight(D)
    beta = 1.5;
    sigma_u = ((gamma(1 + beta) * sin(pi * beta / 2)) / (gamma((1 + beta) / 2) * beta * 2^((beta - 1) / 2)))^(1 / beta);
    sigma_v = 1;
    u = normrnd(0, sigma_u, 1, D);
    v = normrnd(0, sigma_v, 1, D);
    step = u ./ (abs(v).^(1 / beta));
end
