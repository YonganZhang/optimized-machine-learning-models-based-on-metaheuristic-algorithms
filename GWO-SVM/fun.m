%% 适应度函数，以回归mse作为适应度值
function [fitness] = fun(x,Tn_train,Pn_train)
    cmd = ['-c ', num2str(x(1)), ' -g ', num2str(x(2)) , ' -s 3 -p 0.01'];%输入超参数
    model = libsvmtrain(Tn_train',Pn_train',cmd);
   [predict,mse,~] = libsvmpredict(Tn_train',Pn_train',model);
    if size(mse,1) == 0 
        fitness = 1;
    else
        fitness = mse(2);
    end
end
%%
% LIBSVM训练时可以选择的参数很多，包括：
% 
% -s svm类型：SVM设置类型（默认0)
% 　　　　0 — C-SVC； 1 –v-SVC； 2 – 一类SVM； 3 — e-SVR； 4 — v-SVR
% -t 核函数类型：核函数设置类型（默认2）
% 　　　　0 – 线性核函数：u’v 
% 　　　　1 – 多项式核函数：（r*u’v + coef0)^degree
% 　　　　2 – RBF(径向基)核函数：exp(-r|u-v|^2）
% 　　　　3 – sigmoid核函数：tanh(r*u’v + coef0)
% -d degree：核函数中的degree设置（针对多项式核函数）（默认3）
% -g r(gamma）：核函数中的gamma函数设置（针对多项式/rbf/sigmoid核函数）（默认1/k，k为总类别数)
% -r coef0：核函数中的coef0设置（针对多项式/sigmoid核函数）（（默认0)
% -c cost：设置C-SVC，e -SVR和v-SVR的参数（损失函数）（默认1）
% -n nu：设置v-SVC，一类SVM和v- SVR的参数（默认0.5）
% -p p：设置e -SVR 中损失函数p的值（默认0.1）
% -m cachesize：设置cache内存大小，以MB为单位（默认40）
% -e eps：设置允许的终止判据（默认0.001）
% -h shrinking：是否使用启发式，0或1（默认1）
% -wi weight：设置第几类的参数C为weight*C (C-SVC中的C) （默认1）
% -v n: n-fold交互检验模式，n为fold的个数，必须大于等于2
%% libsvmpredict函数的返回值
% 分类的正确率、回归的均方根误差、回归的平方相关系数，本文取的是第二个