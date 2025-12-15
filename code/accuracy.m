clear
clc
close all

%testing network
alexnet_var = load("version/alexnet_var.mat").bosnet;
alexnet_invar = load("version/alexnet_invar.mat").bosnet;
alexnet_mixed = load("version/alexnet_mixed.mat").bosnet;
inception_invar = load("version/inception_invar.mat").bosnet;
inception_var = load("version/inception_var.mat").bosnet;
inception_mixed = load("version/inception_mixed.mat").bosnet;
resnet_var = load("version/resnet_var.mat").bosnet;
resnet_mixed = load("version/resnet_mixed.mat").bosnet;
resnet_invar = load("version/resnet_invar.mat").bosnet;
alexnet_list = {alexnet_var,alexnet_mixed,alexnet_invar};
inception_list = {inception_var, inception_mixed, inception_invar};
resnet_list = {resnet_var, resnet_mixed, resnet_invar};

%testing set (dash line)
imds_1 = imageDatastore("data_test/dash_line/1",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_2 = imageDatastore("data_test/dash_line/2",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_3 = imageDatastore("data_test/dash_line/3",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_4 = imageDatastore("data_test/dash_line/4",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_5 = imageDatastore("data_test/dash_line/5",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_c = imageDatastore("data_test/dash_line/control",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_2_dot = imageDatastore("data_test/dotted_line/2",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_3_dot = imageDatastore("data_test/dotted_line/3",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_4_dot = imageDatastore("data_test/dotted_line/4",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_5_dot = imageDatastore("data_test/dotted_line/5",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_list_alexnet = {imds_c, imds_5, imds_4, imds_3, imds_2, imds_1,imds_2_dot,imds_3_dot,imds_4_dot,imds_5_dot};


size_inception = [299, 299];
imds_list_inception = cell(size(imds_list_alexnet));
for i = 1:numel(imds_list_alexnet)
    imds_list_inception{i} = augmentedImageDatastore(size_inception, imds_list_alexnet{i});
end
size_resnet = [224, 224];
imds_list_resnet = cell(size(imds_list_alexnet));
for i = 1:numel(imds_list_alexnet)
    imds_list_resnet{i} = augmentedImageDatastore(size_resnet, imds_list_alexnet{i});
end

load('result/f1/accuracy_f1.mat')
load('result/f1/prediction_f1.mat')
load('result/f1/score_f1.mat')

%% displaying testing images
x=randi([1 100]);

imgc = readimage(imds_c, x);
img5 = readimage(imds_5, x);
img4 = readimage(imds_4, x);
img3= readimage(imds_3, x);
img2= readimage(imds_2, x);
img1= readimage(imds_1, x);

% img5_dot = readimage(imds_5_dot, x);
% img4_dot = readimage(imds_4_dot, x);
% img3_dot = readimage(imds_3_dot, x);
% img2_dot = readimage(imds_2_dot, x);


% Display
figure(WindowState="maximized");
subplot(2,5,1)
imshow(imgc)
title('control')
subplot(2,5,2)
imshow(img5);
title('n=$\frac{1}{5}$','Interpreter','latex')
subplot(2,5,3)
imshow(img4);
title('n=$\frac{1}{4}$','Interpreter','latex')
subplot(2,5,4)
imshow(img3);
title('n=$\frac{1}{3}$','Interpreter','latex')
subplot(2,5,5)
imshow(img2);
title('n=$\frac{1}{2}$','Interpreter','latex')
subplot(2,5,6)
imshow(img1);
title('n=1')

% subplot(2,5,7)
% imshow(img2_dot);
% title('n=2')
% subplot(2,5,8)
% imshow(img3_dot);
% title('n=3')
% subplot(2,5,9)
% imshow(img4_dot);
% title('n=4')
% subplot(2,5,10)
% imshow(img5_dot);
% title('n=5')


%% alexnet accuracy
preds_alexnet = cell(numel(alexnet_list), numel(imds_list_alexnet));
scores_alexnet = cell(numel(alexnet_list), numel(imds_list_alexnet));
accuracy_alexnet = zeros(numel(alexnet_list), numel(imds_list_alexnet));

for i = 1:numel(imds_list_alexnet)
    imds = imds_list_alexnet{i};
    for k = 1:numel(alexnet_list)
        net = alexnet_list{k};
        [preds, score] = classify(net, imds);
        preds_alexnet{k,i} = preds;
        scores_alexnet{k,i} = score;
        truetest = imds.Labels;
        accuracy_alexnet(k,i) = mean(preds == truetest);
    % figure;
    % confusionchart(truetest, preds);
    % title(['Confusion Chart for Dataset ' num2str(i)]);
    end
end

%% inception accuracy
preds_inception = cell(numel(inception_list), numel(imds_list_inception));
scores_inception = cell(numel(inception_list), numel(imds_list_inception));
accuracy_inception = zeros(numel(inception_list), numel(imds_list_inception));

for i = 1:numel(imds_list_inception)
    imds = imds_list_inception{i};
    label = imds_list_alexnet{i}.Labels;
    for k = 1:numel(inception_list)
        net = inception_list{k};
        [preds, score] = classify(net, imds);
        preds_inception{k,i} = preds;
        scores_inception{k,i} = score;
        truetest = label;
        accuracy_inception(k,i) = mean(preds == truetest);
    % figure;
    % confusionchart(truetest, preds);
    % title(['Confusion Chart for Dataset ' num2str(i)]);
    end
end

%% Resnet accuracy
preds_resnet = cell(numel(resnet_list), numel(imds_list_resnet));
scores_resnet = cell(numel(resnet_list), numel(imds_list_resnet));
accuracy_resnet = zeros(numel(resnet_list), numel(imds_list_resnet));

for i = 1:numel(imds_list_resnet)
    imds = imds_list_resnet{i};
    label = imds_list_alexnet{i}.Labels;
    for k = 1:numel(resnet_list)
        net = resnet_list{k};
        [preds, score] = classify(net, imds);
        preds_resnet{k,i} = preds;
        scores_resnet{k,i} = score;
        truetest = label;
        accuracy_resnet(k,i) = mean(preds == truetest);
    % figure;
    % confusionchart(truetest, preds);
    % title(['Confusion Chart for Dataset ' num2str(i)]);
    end
end

%% plot accuracy
figure;
plot(accuracy_alexnet(1,:),'LineWidth',2); 
hold on
plot(accuracy_alexnet(2,:),'LineWidth',2);
plot(accuracy_alexnet(3,:),'LineWidth',2);
plot(accuracy_inception(1,:),'LineWidth',2);
plot(accuracy_inception(2,:),'LineWidth',2);
plot(accuracy_inception(3,:),'LineWidth',2);
plot(accuracy_resnet(1,:),'LineWidth',2);
plot(accuracy_resnet(2,:),'LineWidth',2);
plot(accuracy_resnet(3,:),'LineWidth',2);
hold off
grid on;
ylim([0.5 1]);
xline(6,'--black','LineWidth',1.2)
legend('alexnet (solid)','alexnet (mixed)','alexnet (contour)', ...
    'inception (solid)','inception (mixed)','inception (contour)', ...
    'resnet (solid)','resnet (mixed)','resnet (contour)')
xlabel('Dataset index');
ylabel('Accuracy');
title('Model Accuracy across Different Datasets');
xticks(1:numel(imds_list_alexnet));

%% bar chart
close all
data = [accuracy_alexnet(3,:); accuracy_resnet(3,:); accuracy_inception(3,:)];
data = data';
model_names = {'AlexNet','Resnet','Inception'};
dataset_names = {'C','$\frac{1}{5}$','$\frac{1}{4}$','$\frac{1}{3}$','$\frac{1}{2}$','1','2','3','4','5'}; 

figure;
set(gcf, 'Position', [100 100 1100 600]);
bar(data,'grouped')
legend(model_names,'FontSize',30);
xticklabels(dataset_names);
set(gca, 'TickLabelInterpreter', 'latex');
xlabel('Gap Level (n)','FontWeight','bold');
ylabel('Accuracy','FontWeight','bold');
set(gca, 'FontSize', 25); 
ylim([0.5 1.0]);
grid on;

%% Mcnemar test (use across model structure (same dataset))
n = 3;  % 1 for var, 2 for mixed, 3 for invar
p_invar = zeros(numel(imds_list_alexnet),3);
chi2_invar = zeros(numel(imds_list_alexnet),3);
tbl_invar = cell(numel(imds_list_alexnet),3);
for i = 1:numel(imds_list_alexnet)
    trueLabels = imds_list_alexnet{i}.Labels;
    pred_alexnet = preds_alexnet{n, i};
    pred_inception = preds_inception{n, i}; 
    pred_resnet = preds_resnet{n, i}; 
    [p_1, chi2_1, tbl_1] = McNemar(trueLabels, pred_alexnet, pred_inception);
    [p_2, chi2_2, tbl_2] = McNemar(trueLabels, pred_alexnet, pred_resnet);
    [p_3, chi2_3, tbl_3] = McNemar(trueLabels, pred_inception, pred_resnet);
    p_invar(i,1) = p_1;
    p_invar(i,2) = p_2;
    p_invar(i,3) = p_3;
    chi2_invar(i,1) = chi2_1;
    chi2_invar(i,2) = chi2_2;
    chi2_invar(i,3) = chi2_3;
    tbl_invar{i,1} = tbl_1;
    tbl_invar{i,2} = tbl_2;
    tbl_invar{i,3} = tbl_3;
end

stars = strings(size(p_invar));

for i = 1:size(p_invar,1)
    for j = 1:size(p_invar,2)
        p = p_invar(i,j);
        if p < 0.001
            stars(i,j) = '^{***}';
        elseif p < 0.01
            stars(i,j) = '^{**}';
        elseif p < 0.05
            stars(i,j) = '^{*}';
        else
            stars(i,j) = '';    % not significant
        end
    end
end

chi2_invar(isnan(chi2_invar)) = 0;
figure;
set(gcf, 'Position', [100 100 1100 350]);
 h = heatmap({'C','1/5','1/4','1/3','1/2','1','2','3','4','5'}, ...
     {'A/I','A/R','I/R'}, chi2_invar');
h.YLabel = '\bf Model Comparison';
h.XLabel = '\bf Gap Level (n)';
h.ColorLimits = [0 900];
h.CellLabelColor = 'none';
h.GridVisible = 'on';

ax = findobj(h.NodeChildren, 'Type', 'Axes');
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;

hs = struct(h);
set(hs.Colorbar, 'FontSize', 18);
ylabel(hs.Colorbar, "\chi^2 Statistic",'FontSize',20);

stars = stars';
xvals = 1:numel(h.XDisplayLabels);
yvals = 1:numel(h.YDisplayLabels);
[Xpos, Ypos] = meshgrid(xvals, yvals);
for i = 1:size(stars,1)
    for j = 1:size(stars,2)
        if stars(i,j) ~= ""
            text(ax, Xpos(i,j), Ypos(i,j)+0.2, stars(i,j), ...
                'HorizontalAlignment','center', ...
                'VerticalAlignment','middle', ...
                'Interpreter','tex', ...
                'FontSize',30, ...
                'Color','black');
        end
    end
end
annotation('textbox', [0.62 0.91 0.25 0.1], ...
    'String', '* p<0.05   ** p<0.01   *** p<0.001', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 15, ...
    'EdgeColor', 'none', ...
    'FontWeight','bold');
%% two proportion z-test (use for cross-validation (different dataset))
k = 2000;
imds_invar = imageDatastore("data_train/lumin_invar_100",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
imds_var = imageDatastore("data_train/lumin_var_100",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
idx_invar = randperm(numel(imds_invar.Files), k);
imds_invar_short = subset(imds_invar, idx_invar);
idx_var = randperm(numel(imds_var.Files), k);
imds_var_short = subset(imds_var, idx_var);
acc = zeros(3,2);

%inception
imds_inception_invar = augmentedImageDatastore(size_inception, imds_invar_short);
imds_inception_var = augmentedImageDatastore(size_inception, imds_var_short);
labels_invar = imds_invar_short.Labels;
labels_var = imds_var_short.Labels;
n_invar = numel(labels_invar);
n_var = numel(labels_var);
inception_var = inception_list{1};
inception_invar = inception_list{3};
pred_var = classify(inception_var, imds_inception_invar);
pred_invar = classify(inception_invar, imds_inception_var);
correct_var_inception = sum(pred_var == labels_invar);
correct_invar_inception = sum(pred_invar == labels_var);
[p_inception,z_inception] = twoProportionTest(correct_var_inception,correct_invar_inception,n_invar,n_var);
acc(1,1) = correct_var_inception/n_invar;
acc(1,2) = correct_invar_inception/n_var;
%resnet
imds_resnet_invar = augmentedImageDatastore(size_resnet, imds_invar_short);
imds_resnet_var = augmentedImageDatastore(size_resnet, imds_var_short);
resnet_var = resnet_list{1};
resnet_invar = resnet_list{3};
pred_var = classify(resnet_var, imds_resnet_invar);
pred_invar = classify(resnet_invar, imds_resnet_var);
correct_var_resnet = sum(pred_var == labels_invar);
correct_invar_resnet = sum(pred_invar == labels_var);
[p_resnet,z_resnet] = twoProportionTest(correct_var_resnet,correct_invar_resnet,n_invar,n_var);
acc(2,1) = correct_var_resnet /n_invar;
acc(2,2) = correct_invar_resnet/n_var;
%alexnet
alexnet_var = alexnet_list{1};
alexnet_invar = alexnet_list{3};
pred_var = classify(alexnet_var, imds_invar_short);
pred_invar = classify(alexnet_invar, imds_var_short);
correct_var_alexnet = sum(pred_var == labels_invar);
correct_invar_alexnet = sum(pred_invar == labels_var);
[p_alexnet,z_alexnet] = twoProportionTest(correct_var_alexnet,correct_invar_alexnet,n_invar,n_var);
acc(3,1) = correct_var_alexnet/n_invar;
acc(3,2) = correct_invar_alexnet/n_var;

%% plot
load('result/twoztest_acc.mat')
load('result/twoztest_pandz.mat')
figure;
set(gcf, 'Position', [100 100 600 600]);
bar(acc)
ylim([0.4 1]);
yline(0.5, '--','LineWidth',2);
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'FontSize', 16); 
legend('Train Solid/Test Contour','Train Contour/Test Solid','FontSize', 16);
xticklabels({'Inception','Resnet','Alexnet'});
ylabel('Accuracy','FontWeight','bold');
xlabel('Models','FontWeight','bold');
grid on;
