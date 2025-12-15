close all
clc
clear

funcs = {
    @remove_1
    @remove_2
    @remove_3
    @remove_4
    @remove_5
    @remove_6
    @remove_7
    @remove_8
};
n=500;
imgs_left = zeros(227, 227, 1, 200, 'uint8');
imgs_right = zeros(227, 227, 1, 200, 'uint8');
%% Right
for i = 1:n
%left shape
stim = uint8(zeros(227));
start_x_left = randi([20 207]);
start_y_left = randi([20 207]);
length_left = randi([10 217-start_x_left]); %[10 197]
width_left = randi([10 217-start_y_left]); %[10 197]
%right shape
start_x_right = randi([(start_x_left+5) (start_x_left+length_left-5)]); %[25 212]
start_y_right = randi([(start_y_left+5) (start_y_left+width_left-5)]); %[25 212]
length_right = randi([(length_left+start_x_left-start_x_right+3) 217-start_x_right+3]); %[5 ]
width_right = randi([(start_y_left+width_left-start_y_right+3) 217-start_y_right+3]);
%Draw hollow rectangles
% Left rectangle border
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)=250;
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;
% Right rectangle border
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)=250;
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
%store
stim_m = repmat(stim,[1 1 3]);
stim_m = uint8(stim_m);
stimWrite = strcat('11111111_right',int2str(i));
outputFolder = 'data_test/fragment/11111111/right/';
save(fullfile(outputFolder, stimWrite), 'stim_m')

%creating 255 versions
for k = 0:254
    group = dec2bin(k,8); %include all-empty set
    stim_removed = stim;
    for digit = 1:8
        if group(digit) == '0'
        stim_removed = funcs{digit}(stim_removed,start_x_left,start_y_left, ...
            start_x_right,start_y_right,length_left,width_left,length_right,width_right);
        end
    end
imgs_right(:,:,1,(k+1)) = stim_removed;
% stim_removed = repmat(stim_removed,[1 1 3]);
% stim_removed = uint8(stim_removed);
% stimWrite = sprintf('%s_right_%d.mat', group, i);
% outputFolder = sprintf('data_test/fragment/%s/right/', group);
% save(fullfile(outputFolder, stimWrite), 'stim_removed')
end
end
toc

%% left
tic
for i = 1:n
%left shape
stim = uint8(zeros(227));
start_x_left = randi([20 207]);
start_y_left = randi([20 207]);
length_left = randi([10 217-start_x_left]); %[10 197]
width_left = randi([10 217-start_y_left]); %[10 197]
%right shape
start_x_right = randi([(start_x_left+5) (start_x_left+length_left-5)]); %[25 212]
start_y_right = randi([(start_y_left+5) (start_y_left+width_left-5)]); %[25 212]
length_right = randi([(length_left+start_x_left-start_x_right+3) 217-start_x_right+3]); %[5 ]
width_right = randi([(start_y_left+width_left-start_y_right+3) 217-start_y_right+3]);
%Draw hollow rectangles
% Right rectangle border
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)=250;
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% Left rectangle border
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)=250;
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;
%store
stim_m = repmat(stim,[1 1 3]);
stim_m = uint8(stim_m);
stimWrite = strcat('11111111_left',int2str(i));
outputFolder = 'data_test/fragment/11111111/left/';
save(fullfile(outputFolder, stimWrite), 'stim_m')

%creating 255 versions
for k = 0:254
    group = dec2bin(k,8); %include all-empty set
    stim_removed = stim;
    for digit = 1:8
        if group(digit) == '0'
        stim_removed = funcs{digit}(stim_removed,start_x_left,start_y_left, ...
            start_x_right,start_y_right,length_left,width_left,length_right,width_right);
        end
    end
imgs_left(:,:,1,(k+1)) = stim_removed;
% stim_removed = repmat(stim_removed,[1 1 3]);
% stim_removed = uint8(stim_removed);
% stimWrite = sprintf('%s_left_%d.mat', group, i);
% outputFolder = sprintf('data_test/fragment/%s/left/', group);
% save(fullfile(outputFolder, stimWrite), 'stim_removed')
end
end
toc