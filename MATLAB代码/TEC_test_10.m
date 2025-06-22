clear;
clc;

format long;
format compact;

% set random seedNUOSFWA
rand('state',sum(100*clock));
randn('state',sum(100*clock));

fhd = str2func('TEC_test_function');

DEv = cell(1,20); % DE variants%创建元胞数组，20个
DEv(1) = {'PSO'}; %调用算法函数

Xmin    = [-100,-5,-32,-100,-5,-32,-100,-100,-100,-5,-32,-100,-100,-100,-5,-32,-100,-100,-100,-100];
Xmax    = -Xmin;

funopt = zeros(1,13);%初始化零向量

funchoose = 1:13;%产生1到13个数

fumnummax = 13;
runnummax = 10;


for kk = 1:1
for k = 1:1
    
    fhdDE = str2func( char( DEv(k) ) );%调用函数，返回函数句柄
    
    empty_result.bestval   = [];
    empty_result.bestarray = [];
    empty_result.cputime   = [];

    result = repmat(empty_result,fumnummax,runnummax);
    statistic = zeros(5,fumnummax);%初始化一个5行，fumnummax的零矩阵

    bv  = zeros(1,runnummax);
    ct  = zeros(1,runnummax);

    for funnum=1:fumnummax  

        fun = funchoose(funnum);%选中funnum

        for runnum=1:runnummax

            fprintf('function=%d runtime=%g ',funnum,runnum);%格式化字符输出

            [bestval,bestarray,CPUtime] = feval(fhdDE,fhd,fun,Xmin(fun),Xmax(fun));%将想要执行的函数以及相应的参数一起作为feval()的参数 FWA(ffhd, ffun, xmin, xmax)
            result(funnum,runnum).bestval   = bestval-funopt(fun);
            result(funnum,runnum).bestarray = bestarray;
            result(funnum,runnum).cputime   = CPUtime;

            fprintf('bestval=%d\n',bestval-funopt(fun));

            bv(runnum) = bestval-funopt(fun);
            ct(runnum) = CPUtime;
        end

        statistic(1,funnum) = min(bv);
        statistic(2,funnum) = max(bv);
        statistic(3,funnum) = mean(bv);%平均值
        statistic(4,funnum) = std(bv,1);%方差
        statistic(5,funnum) = mean(ct);%平均值
    end
    statistic=statistic';%转置矩阵
    
    feval(str2func('save'), [ char(DEv(k)) '_yao13' num2str(kk)], 'result', 'statistic');% 保存运行数据
    
end
end

                                                                                                                                                                                                                                                                                ;




