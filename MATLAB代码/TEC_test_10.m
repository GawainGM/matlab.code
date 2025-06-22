clear;
clc;

format long;
format compact;

% set random seedNUOSFWA
rand('state',sum(100*clock));
randn('state',sum(100*clock));

fhd = str2func('TEC_test_function');

DEv = cell(1,20); % DE variants%����Ԫ�����飬20��
DEv(1) = {'PSO'}; %�����㷨����

Xmin    = [-100,-5,-32,-100,-5,-32,-100,-100,-100,-5,-32,-100,-100,-100,-5,-32,-100,-100,-100,-100];
Xmax    = -Xmin;

funopt = zeros(1,13);%��ʼ��������

funchoose = 1:13;%����1��13����

fumnummax = 13;
runnummax = 10;


for kk = 1:1
for k = 1:1
    
    fhdDE = str2func( char( DEv(k) ) );%���ú��������غ������
    
    empty_result.bestval   = [];
    empty_result.bestarray = [];
    empty_result.cputime   = [];

    result = repmat(empty_result,fumnummax,runnummax);
    statistic = zeros(5,fumnummax);%��ʼ��һ��5�У�fumnummax�������

    bv  = zeros(1,runnummax);
    ct  = zeros(1,runnummax);

    for funnum=1:fumnummax  

        fun = funchoose(funnum);%ѡ��funnum

        for runnum=1:runnummax

            fprintf('function=%d runtime=%g ',funnum,runnum);%��ʽ���ַ����

            [bestval,bestarray,CPUtime] = feval(fhdDE,fhd,fun,Xmin(fun),Xmax(fun));%����Ҫִ�еĺ����Լ���Ӧ�Ĳ���һ����Ϊfeval()�Ĳ��� FWA(ffhd, ffun, xmin, xmax)
            result(funnum,runnum).bestval   = bestval-funopt(fun);
            result(funnum,runnum).bestarray = bestarray;
            result(funnum,runnum).cputime   = CPUtime;

            fprintf('bestval=%d\n',bestval-funopt(fun));

            bv(runnum) = bestval-funopt(fun);
            ct(runnum) = CPUtime;
        end

        statistic(1,funnum) = min(bv);
        statistic(2,funnum) = max(bv);
        statistic(3,funnum) = mean(bv);%ƽ��ֵ
        statistic(4,funnum) = std(bv,1);%����
        statistic(5,funnum) = mean(ct);%ƽ��ֵ
    end
    statistic=statistic';%ת�þ���
    
    feval(str2func('save'), [ char(DEv(k)) '_yao13' num2str(kk)], 'result', 'statistic');% ������������
    
end
end

                                                                                                                                                                                                                                                                                ;




