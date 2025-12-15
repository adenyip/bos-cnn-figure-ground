clc
close all
clear

inception_var = load("version/inception_var.mat").bosnet; %using inception_var to test
size_inception = [299, 299];
allImds = cell(256,1);
augImds = cell(256,1);
folderNames = arrayfun(@(x) dec2bin(x,8), 0:255, 'UniformOutput', false);
baseDir = "data_test/fragment/";
for k = 1:256
    folder = folderNames{k};
    fullPath = fullfile(baseDir, folder);

    allImds{k} = imageDatastore(fullPath, ...
        'FileExtensions', '.mat', ...
        'ReadFcn', @matRead, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');
    augImds{k} = augmentedImageDatastore(size_inception, allImds{k});

    fprintf('Loaded folder %s into imds{%d}\n', folder, k);
end
accuracy_inception = load("result/f2/accuracy_inception_invar_f2.mat").accuracy_inception;
accuracy_resnet = load("result/f2/accuracy_resnet_invar_f2.mat").accuracy_resnet;
accuracy_alexnet = load("result/f2/accuracy_alexnet_invar_f2.mat").accuracy_alexnet;
clc
%% get accuracy
% preds_inception = cell(1, numel(augImds));
% scores_inception = cell(1, numel(augImds));
% accuracy_inception = zeros(1, numel(augImds));
% 
% for i = 1:numel(augImds)
%     label = allImds{i}.Labels;
%     [preds, score] = classify(inception_var, augImds{i});
%     preds_inception{1,i} = preds;
%     scores_inception{1,i} = score;
%     truetest = label;
%     accuracy_inception(1,i) = mean(preds == truetest);
%     % figure;
%     % confusionchart(truetest, preds);
%     % title(['Confusion Chart for Dataset ' num2str(i)]);
% end
%% regression equation
%inception
F = zeros(256, 8); % building F matrix
for k = 1:256
    F(k,:) = folderNames{k} - '0';
end

pairs = nchoosek(1:8, 2);     % (28 x 2) list of index pairs
numPairs = size(pairs,1);
X_inter = zeros(256, numPairs); %building FiFj interaction matrix (X_inter)
for p = 1:numPairs
    i = pairs(p,1);
    j = pairs(p,2);
    X_inter(:,p) = F(:,i) .* F(:,j);
end

N = sum(F,2);
gN = [N, N.^2]; %building coefficient g(N)

X = [ones(256,1), F, X_inter, gN];  %building full design matrix

lambda = 1e-3;   % small regularization
coeff = (X' * X + lambda * eye(size(X,2))) \ (X' * accuracy_inception'); %getting all coeff
idx = 1;
beta0_inception = coeff(idx); 
idx = idx + 1;
d_inception = coeff(idx : idx+7);       % 8 fragment coefficients
idx = idx + 8;
f_inception = coeff(idx : idx+28-1);    % 28 interaction coefficients
idx = idx + 28;
gamma_inception = coeff(idx : idx+2-1); % [γ1, γ2]

%resnet
F = zeros(256, 8); % building F matrix
for k = 1:256
    F(k,:) = folderNames{k} - '0';
end

pairs = nchoosek(1:8, 2);     % (28 x 2) list of index pairs
numPairs = size(pairs,1);
X_inter = zeros(256, numPairs); %building FiFj interaction matrix (X_inter)
for p = 1:numPairs
    i = pairs(p,1);
    j = pairs(p,2);
    X_inter(:,p) = F(:,i) .* F(:,j);
end

N = sum(F,2);
gN = [N, N.^2]; %building coefficient g(N)

X = [ones(256,1), F, X_inter, gN];  %building full design matrix

lambda = 1e-3;   % small regularization
coeff = (X' * X + lambda * eye(size(X,2))) \ (X' * accuracy_resnet'); %getting all coeff
idx = 1;
beta0_resnet = coeff(idx); 
idx = idx + 1;
d_resnet = coeff(idx : idx+7);       % 8 fragment coefficients
idx = idx + 8;
f_resnet = coeff(idx : idx+28-1);    % 28 interaction coefficients
idx = idx + 28;
gamma_resnet = coeff(idx : idx+2-1); % [γ1, γ2]

%alexnet
F = zeros(256, 8); % building F matrix
for k = 1:256
    F(k,:) = folderNames{k} - '0';
end

pairs = nchoosek(1:8, 2);     % (28 x 2) list of index pairs
numPairs = size(pairs,1);
X_inter = zeros(256, numPairs); %building FiFj interaction matrix (X_inter)
for p = 1:numPairs
    i = pairs(p,1);
    j = pairs(p,2);
    X_inter(:,p) = F(:,i) .* F(:,j);
end

N = sum(F,2);
gN = [N, N.^2]; %building coefficient g(N)

X = [ones(256,1), F, X_inter, gN];  %building full design matrix

lambda = 1e-3;   % small regularization
coeff = (X' * X + lambda * eye(size(X,2))) \ (X' * accuracy_alexnet'); %getting all coeff
idx = 1;
beta0_alexnet = coeff(idx); 
idx = idx + 1;
d_alexnet = coeff(idx : idx+7);       % 8 fragment coefficients
idx = idx + 8;
f_alexnet = coeff(idx : idx+28-1);    % 28 interaction coefficients
idx = idx + 28;
gamma_alexnet = coeff(idx : idx+2-1); % [γ1, γ2]
%%
% predicted = X * coeff;
% 
% SS_res = sum((accuracy' - predicted).^2);
% SS_tot = sum((accuracy' - mean(accuracy)).^2);
% R2 = 1 - SS_res / SS_tot;
% fprintf('Model R^2 = %.4f\n', R2);

% figure;
% scatter(accuracy, predicted, 60, 'filled')
% hold on
% plot([0 1], [0 1], 'r--', 'LineWidth', 2)  % identity line
% xlabel('Observed Accuracy')
% ylabel('Predicted Accuracy')
% title('Model Fit: Observed vs Predicted')
% grid on

d_all = [d_inception, d_resnet,d_alexnet];   % 8×2 matrix
d_mean = mean(d_all, 2);          % mean across columns → 8×1
d_std  = std(d_all, 0, 2);
figure;
set(gcf, 'Position', [100 100 600 600]);
bar(d_mean);
hold on
errorbar(1:8, d_mean, d_std, 'k.', 'LineWidth', 1.1)
hold off
set(gca, 'FontSize', 20); 
xlabel('Fragment Index','FontWeight','bold');
ylabel('Coefficient $d_i$','FontWeight','bold','Interpreter','latex');
ylim([-0.1,0.35]);
grid on

%%
Fmat = zeros(8,8);
index = 1;
for p = 1:numPairs
    i = pairs(p,1);
    j = pairs(p,2);
    Fmat(i,j) = f_inception(index);
    Fmat(j,i) = f_inception(index);
    index = index + 1;
end

figure;
set(gcf, 'Position', [100 100 720 600]);
imagesc(Fmat);
colorbar;
set(gca, 'FontSize', 20); 
xlabel('Fragment Index','FontWeight','bold');
ylabel('Fragment Index','FontWeight','bold');
cb = colorbar;
ylabel(cb, ['Coefficient $f' ...
    '_{ij}$'], ...
       'Interpreter','latex', ...
       'FontSize',20);
%%
%Inception
close all
jitter = 0.08;
xj = N + jitter*randn(size(N));
xj(1) = 0;
xj(end) = 8;
figure;
set(gcf, 'Position', [100 100 700 600]);
scatter(xj, accuracy_inception, 40, 'filled', 'MarkerFaceAlpha',0.5)
hold on
plot(0:8, beta0_inception+(gamma_inception(1)*(0:8) + gamma_inception(2)*(0:8).^2), 'r-', 'LineWidth', 2);
txt = sprintf('\\gamma_1 = %.3f\n\\gamma_2 = %.3f', ...
              gamma_inception(1), gamma_inception(2));
text(0.75, 0.15, txt, ...
    'Units','normalized', ...     % place relative to axes
    'FontSize', 20, ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'black', ...
    'Margin', 6);
hold off
set(gca, 'FontSize', 20); 
xlabel('Fragment Availability (N)','FontWeight','bold')
ylabel('Accuracy','FontWeight','bold')
ylim([0.4,1])
xlim([0 8]);
grid on

