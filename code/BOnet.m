clear
clc
close all

%% Set data
imds = imageDatastore("data_train/lumin_invar_50",'FileExtensions','.mat','ReadFcn',@matRead,IncludeSubfolders=true,LabelSource="foldernames");
[trStim,teStim] = splitEachLabel(imds,0.7,0.3,"randomized");
classes = categories(imds.Labels);

function data = matRead(filename)
    inp = load(filename);
    f = fields(inp);
    data = inp.(f{1});
end
size_inception = [299 299];  % for inceptionv3
trStim_inception = augmentedImageDatastore(size_inception, trStim);
teStim_inception = augmentedImageDatastore(size_inception, teStim);
%% Alexnet
net = alexnet;
lgraph = layerGraph(net);
% Replace last layers for binary classification
lgraph = replaceLayer(lgraph, 'fc8', fullyConnectedLayer(2, 'Name', 'fc8'));
lgraph = replaceLayer(lgraph, 'prob', softmaxLayer('Name','prob'));
lgraph = replaceLayer(lgraph, 'output', classificationLayer('Name','output'));
%% Inception
net = inceptionv3;
lgraph = layerGraph(net);
lgraph = replaceLayer(lgraph, 'predictions', fullyConnectedLayer(2, 'Name', 'predictions'));
lgraph = replaceLayer(lgraph, 'predictions_softmax', softmaxLayer('Name','prob'));
lgraph = replaceLayer(lgraph, 'ClassificationLayer_predictions', classificationLayer('Name','ClassificationLayer_predictions'));
%% Resnet
net = resnet50;
lgraph = layerGraph(net)
lgraph = replaceLayer(lgraph, 'fc1000', fullyConnectedLayer(2, 'Name', 'fc1000'));
lgraph = replaceLayer(lgraph, 'fc1000_softmax', softmaxLayer('Name','prob'));
lgraph = replaceLayer(lgraph, 'ClassificationLayer_fc1000', classificationLayer('Name','ClassificationLayer_fc1000'));
%% Freeze layer
%  numLayersToFreeze = 5; % Adjust as needed
% for i = 1:numLayersToFreeze
%     layerName = lgraph.Layers(i).Name;
%     layer = lgraph.Layers(i);
%     if isprop(layer,'WeightLearnRateFactor')
%         layer.WeightLearnRateFactor = 0;
%     end
%     if isprop(layer,'BiasLearnRateFactor')
%         layer.BiasLearnRateFactor = 0;
%     end
%     lgraph = replaceLayer(lgraph, layerName, layer);
% end

%% Training options
options = trainingOptions("adam", ...
    InitialLearnRate=0.0001, ...     %Starting learning rate (1e^-4 for adam)
    minibatchSize=64,...
    shuffle="every-epoch",...       %Shuffle training data every epoch       
    Verbose=false, ...              %not display training progress
    GradientThresholdMethod="l2norm", ...
    GradientThreshold=1, ...
    ValidationData=teStim_inception, ...
    ValidationFrequency=25, ...
    Plots="training-progress", ...   %plot progress
    MaxEpochs=3, ...
    OutputNetwork="best-validation");                  %Number of full passes through the dataset
%%
bosnet = trainNetwork(trStim_inception,lgraph,options);
% save('alexnet_var.mat','bosnet')

%% Testing network
[preds, scores] = classify(bosnet, teStim);
truetest = teStim.Labels;
confusionchart(truetest,preds);

%% Grad-CAM
close all
X_left = matRead(strcat('data/lumin_var_100/left/stimuli_left_',int2str(randi([1 1000]))));
X_right = matRead(strcat('data/lumin_var_100/right/stimuli_right_',int2str(randi([1 1000]))));

preds = classify(bosnet, X_left);
preds_1 = classify(bosnet, X_right);

scoreMap_1_left = gradCAM(bosnet,X_left,preds,'FeatureLayer','pool1');
scoreMap_2_left = gradCAM(bosnet,X_left,preds,'FeatureLayer','pool2');
scoreMap_5_left = gradCAM(bosnet,X_left,preds,'FeatureLayer','pool5');
scoreMap_1_right = gradCAM(bosnet,X_right,preds_1,'FeatureLayer','pool1');
scoreMap_2_right = gradCAM(bosnet,X_right,preds_1,'FeatureLayer','pool2');
scoreMap_5_right = gradCAM(bosnet,X_right,preds_1,'FeatureLayer','pool5');

figure
subplot(2,3,1)
imshow(X_left)
hold on
imagesc(scoreMap_1_left,AlphaData=0.5)
colormap jet
hold off
title("pool1")
ylabel('True:left\npredict: %s',preds, 'Rotation', 0);
subplot(2,3,2)
imshow(X_left)
hold on
imagesc(scoreMap_2_left,AlphaData=0.5) 
colormap jet
hold off
title("pool2")
subplot(2,3,3)
imshow(X_left)
hold on
imagesc(scoreMap_5_left,AlphaData=0.5) 
colormap jet
hold off
title("pool5")

subplot(2,3,4)
imshow(X_right)
hold on
imagesc(scoreMap_1_right,AlphaData=0.5) 
colormap jet
hold off
ylabel('True:right\npredict: %s',preds_1, 'Rotation', 0);
subplot(2,3,5)
imshow(X_right)
hold on
imagesc(scoreMap_2_right,AlphaData=0.5) 
colormap jet
hold off
subplot(2,3,6)
imshow(X_right)
hold on
imagesc(scoreMap_5_right,AlphaData=0.5) 
colormap jet
hold off

%% Feature Map
layerName = 'relu2';
act = activations(bosnet, X_left, layerName, 'OutputAs', 'channels'); % Get feature maps

% FM with grayscale
figure;
montage(mat2gray(act(:,:,1:16)));
title(['Feature maps from layer: ', layerName]);

% FM with colormap
numMapsToShow = 16;
figure;
for i = 1:numMapsToShow
    subplot(4,4,i);
    fm = act(:,:,i);
    fmNorm = (fm - min(fm(:))) / (max(fm(:)) - min(fm(:))); % normalize to [0,1]
    imagesc(fmNorm);
    axis off;
    colormap jet;
    colorbar;
    title(['FM ', num2str(i)]);
end
sgtitle(['Feature maps from ', layerName]);