function [ gbestval, g_res, CPUtime ]= PSO(fhd, fun, Xmin, Xmax)
% 2014-3-29 programming by Hu Peng at WHU
    tic;

    global initial_flag
    initial_flag=0;

    ps = 5;% 粒子数量
    D = 50;% 问题维度

    Max_FES = 10000;% 最大迭代次数

    C = 1.49618;% 学习因子
    W = 0.72984;% 惯性权重

    Vmax = 0.5*(Xmax-Xmin);% 速度下限
    Vmin = -Vmax;% 速度下限

    pos = repmat(Xmin,ps,D) +(repmat(Xmax,ps,D)-repmat(Xmin,ps,D)).*rand(ps,D);
    vel = repmat(Vmin,ps,D) +(repmat(Vmax,ps,D)-repmat(Vmin,ps,D)).*rand(ps,D);

    for i=1:ps
        e(i) = feval(fhd,pos(i,:),fun);
    end
    fitcount = ps;

    pbest    = pos;
    pbestval = e;         

    [gbestval,gbestid] = min(pbestval);
    gbest    = pbest(gbestid,:);   

    g_res = gbestval;

    while fitcount < Max_FES

        for k=1:ps

            vel(k,:)= W .* vel(k,:) + C .* rand(1,D) .* (pbest(k,:)-pos(k,:))...
                                    + C .* rand(1,D) .* (gbest-pos(k,:));

            vel(k,:) = ( (vel(k,:) >= Vmin) & (vel(k,:) <= Vmax) ) .* vel(k,:)...
                       + (vel(k,:) < Vmin) .* ( Vmin + (Vmax-Vmin) .* rand(1,D) )...
                       + (vel(k,:) > Vmax) .* ( Vmin + (Vmax-Vmin) .* rand(1,D) );

            pos(k,:)=pos(k,:)+vel(k,:); 

            pos(k,:) = ( (pos(k,:) >= Xmin) & (pos(k,:) <= Xmax) ) .* pos(k,:)...
                       + (pos(k,:) < Xmin) .* ( Xmin + (Xmax-Xmin) .* rand(1,D) )...
                       + (pos(k,:) > Xmax) .* ( Xmin + (Xmax-Xmin) .* rand(1,D) );

            e(k) = feval(fhd,pos(k,:),fun);
            

            if e(k)< pbestval(k)        
                pbest(k,:) = pos(k,:);
                pbestval(k) = e(k);

                if pbestval(k)<gbestval
                    gbest = pbest(k,:);
                    gbestval = pbestval(k);
                end
            end
        end
fitcount = fitcount+1;
        g_res = [g_res gbestval];
        
    end
    
    CPUtime   = toc;
    
end


