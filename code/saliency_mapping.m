clc
clear
close all

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

load('stim_test.mat');
load('stim_gap.mat');
stim_list_alexnet = {stim_1,stim_2,stim_3,stim_4,stim_5};
size_inception = [299, 299];
stim_list_inception = cell(size(stim_list_alexnet));
for i = 1:numel(stim_list_alexnet)
    stim_list_inception{i} = imresize(stim_list_alexnet{i}, size_inception);
end
size_resnet = [224, 224];
stim_list_resnet = cell(size(stim_list_alexnet));
for i = 1:numel(stim_list_alexnet)
    stim_list_resnet{i} = imresize(stim_list_alexnet{i}, size_resnet);
end


%% grad-cam
preds  = cell(numel(stim_list_alexnet), 1);
scores = cell(numel(stim_list_alexnet), 1);
layerNames_alexnet = {'pool1', 'pool2', 'pool5'};
layerNames_inception = {'mixed1','mixed6','mixed10'};
layerNames_resnet = {'add_1','add_8','add_16'};

%% alexnet
%classify
bosnet = alexnet_invar;
nStim = numel(stim_list_alexnet);
nLayers = numel(layerNames_alexnet);
for i = 1:numel(stim_list_alexnet)
[preds{i},scores{i}] = classify(bosnet, stim_list_alexnet{i});
end
%scoremap
scoreMaps = cell(nStim, nLayers);
for i = 1:nStim
    for j = 1:nLayers
        scoreMaps{i, j} = gradCAM(bosnet, stim_list_alexnet{i},preds{i},'FeatureLayer', layerNames_alexnet{j});
    end
end
% %plot
% figure;
% for i = 1:nStim
%     for j = 1:nLayers
%         subplot(nStim, nLayers, (i-1)*nLayers + j)
%         imshow(stim_list_alexnet{i});
%         hold on;
%         imagesc(scoreMaps{i,j}, 'AlphaData', 0.5);
%         colormap jet;
%         hold off;
%         if i == 1
%             title(layerNames_alexnet{j})
%         end
%     end
% end
figure;
imshow(stim_list_alexnet{1});
hold on;
imagesc(scoreMaps{1,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim1_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{1});
hold on;
imagesc(scoreMaps{1,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim1_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{1});
hold on;
imagesc(scoreMaps{1,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim1_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_alexnet{2});
hold on;
imagesc(scoreMaps{2,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim2_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{2});
hold on;
imagesc(scoreMaps{2,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim2_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{2});
hold on;
imagesc(scoreMaps{2,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim2_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_alexnet{3});
hold on;
imagesc(scoreMaps{3,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim3_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{3});
hold on;
imagesc(scoreMaps{3,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim3_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{3});
hold on;
imagesc(scoreMaps{3,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim3_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_alexnet{4});
hold on;
imagesc(scoreMaps{4,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim4_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{4});
hold on;
imagesc(scoreMaps{4,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim4_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{4});
hold on;
imagesc(scoreMaps{4,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim4_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_alexnet{5});
hold on;
imagesc(scoreMaps{5,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim5_1.jpg', 'Resolution', 600);

figure;
imshow(stim_list_alexnet{5});
hold on;
imagesc(scoreMaps{5,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim5_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_alexnet{5});
hold on;
imagesc(scoreMaps{5,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'alexnet_stim5_3.jpg', 'Resolution', 600);
%% Inception
bosnet = inception_invar;
nStim = numel(stim_list_inception);
nLayers = numel(layerNames_inception);
%classify
for i = 1:numel(stim_list_inception)
[preds{i},scores{i}] = classify(bosnet, stim_list_inception{i});
end
%scoremap
scoreMaps = cell(nStim, nLayers);
for i = 1:nStim
    for j = 1:nLayers
        scoreMaps{i, j} = gradCAM(bosnet, stim_list_inception{i},preds{i},'FeatureLayer', layerNames_inception{j});
    end
end
% %plot
% figure;
% for i = 1:nStim
%     for j = 1:nLayers
%         subplot(nStim, nLayers, (i-1)*nLayers + j)
%         imshow(stim_list_inception{i});
%         hold on;
%         imagesc(scoreMaps{i,j}, 'AlphaData', 0.5);
%         colormap jet;
%         hold off;
%         if i == 1
%             title(layerNames_inception{j})
%         end
%     end
% end

figure;
imshow(stim_list_inception{1});
hold on;
imagesc(scoreMaps{1,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim1_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{1});
hold on;
imagesc(scoreMaps{1,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim1_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{1});
hold on;
imagesc(scoreMaps{1,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim1_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_inception{2});
hold on;
imagesc(scoreMaps{2,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim2_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{2});
hold on;
imagesc(scoreMaps{2,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim2_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{2});
hold on;
imagesc(scoreMaps{2,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim2_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_inception{3});
hold on;
imagesc(scoreMaps{3,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim3_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{3});
hold on;
imagesc(scoreMaps{3,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim3_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{3});
hold on;
imagesc(scoreMaps{3,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim3_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_inception{4});
hold on;
imagesc(scoreMaps{4,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim4_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{4});
hold on;
imagesc(scoreMaps{4,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim4_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{4});
hold on;
imagesc(scoreMaps{4,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim4_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_inception{5});
hold on;
imagesc(scoreMaps{5,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim5_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{5});
hold on;
imagesc(scoreMaps{5,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim5_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_inception{5});
hold on;
imagesc(scoreMaps{5,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'inception_stim5_3.jpg', 'Resolution', 600);
%% Resnet
bosnet = resnet_invar;
nStim = numel(stim_list_resnet);
nLayers = numel(layerNames_resnet);
%classify
for i = 1:numel(stim_list_resnet)
[preds{i},scores{i}] = classify(bosnet, stim_list_resnet{i});
end
%scoremap
% 
%plot
figure;scoreMaps = cell(nStim, nLayers);
for i = 1:nStim
    for j = 1:nLayers
        scoreMaps{i, j} = gradCAM(bosnet, stim_list_resnet{i},preds{i},'FeatureLayer', layerNames_resnet{j});
    end
end
% for i = 1:nStim
%     for j = 1:nLayers
%         subplot(nStim, nLayers, (i-1)*nLayers + j)
%         imshow(stim_list_resnet{i});
%         hold on;
%         imagesc(scoreMaps{i,j}, 'AlphaData', 0.5);
%         colormap jet;
%         hold off;
%         if i == 1
%             title(layerNames_resnet{j})
%         end
%     end
% end

figure;
imshow(stim_list_resnet{1});
hold on;
imagesc(scoreMaps{1,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim1_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{1});
hold on;
imagesc(scoreMaps{1,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim1_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{1});
hold on;
imagesc(scoreMaps{1,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim1_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_resnet{2});
hold on;
imagesc(scoreMaps{2,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim2_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{2});
hold on;
imagesc(scoreMaps{2,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim2_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{2});
hold on;
imagesc(scoreMaps{2,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim2_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_resnet{3});
hold on;
imagesc(scoreMaps{3,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim3_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{3});
hold on;
imagesc(scoreMaps{3,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim3_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{3});
hold on;
imagesc(scoreMaps{3,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim3_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_resnet{4});
hold on;
imagesc(scoreMaps{4,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim4_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{4});
hold on;
imagesc(scoreMaps{4,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim4_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{4});
hold on;
imagesc(scoreMaps{4,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim4_3.jpg', 'Resolution', 600);

figure;
imshow(stim_list_resnet{5});
hold on;
imagesc(scoreMaps{5,1}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim5_1.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{5});
hold on;
imagesc(scoreMaps{5,2}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim5_2.jpg', 'Resolution', 600);
figure;
imshow(stim_list_resnet{5});
hold on;
imagesc(scoreMaps{5,3}, 'AlphaData', 0.5);
colormap jet;
hold off;
exportgraphics(gcf, 'resnet_stim5_3.jpg', 'Resolution', 600);