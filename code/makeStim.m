clc
clear
close all
n=500;

%% Luminance invariant
% ----right----
imgs_right = zeros(227, 227, 1, 49, 'uint8');
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
%display
imgs_right(:,:,1,i) = stim;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('11111111_right',int2str(i));
outputFolder = 'data_test/fragment/11111111/right/';
save(fullfile(outputFolder, stimWrite), 'stim')
end
figure;
montage(imgs_right, 'Size', [7 7]);
title("right");

% ----left----
imgs_left = zeros(227, 227, 1, 49, 'uint8');
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
%display
imgs_left(:,:,1,i) = stim;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('11111111_left',int2str(i));
outputFolder = 'data_test/fragment/11111111/left/';
save(fullfile(outputFolder, stimWrite), 'stim')
end
figure;
montage(imgs_left, 'Size', [7 7]);
title("left");

%% Luminance variant
% ---- right ----
imgs_right = zeros(227, 227, 1, 49, 'uint8');
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
%random lumin
while true
    a = randi([50 250]);
    b = randi([50 250]);
    
    if abs(a - b) > 50
        break; % exit loop once condition is met
    end
end
% Left rectangle
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)= a;
% Right rectangle
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)= b;
%display
imgs_right(:,:,1,i) = stim;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_right_var',int2str(i));
outputFolder = 'data/lumin_var_100/right/';
save(fullfile(outputFolder, stimWrite), 'stim')
end
figure;
montage(imgs_right, 'Size', [7 7]);
title("right");


%---- left ----
imgs_right = zeros(227, 227, 1, 49, 'uint8');
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
%random lumin
while true
    a = randi([50 250]);
    b = randi([50 250]);
    
    if abs(a - b) > 50
        break; % exit loop once condition is met
    end
end
% Right rectangle
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)= b;
% Left rectangle
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)= a;
%display
imgs_right(:,:,1,i) = stim;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_left_var',int2str(i));
outputFolder = 'data/lumin_var_100/left/';
save(fullfile(outputFolder, stimWrite), 'stim')
end
figure;
montage(imgs_right, 'Size', [7 7]);
title("left");


%% Dash line and dotted line
% ----right----
imgs_right = zeros(227, 227, 1, 50, 'uint8');
interval = [2 3 4 5 6];  %mean every n-1 elements 1 interval
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

%for original image (control)
%Draw hollow rectangles
% Left rectangle border
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)=250;
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;
% Right rectangle border
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)=250;
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_dash_control_right_',int2str(i));
outputFolder = fullfile('data/dash_line/control/right');
save(fullfile(outputFolder, stimWrite), 'stim')

% for dash line
for k = 1:length(interval)
 stim = uint8(zeros(227));
%Draw hollow rectangles
% Left rectangle border
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)=250;
stim(start_y_left:interval(k):start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=0;
%ensure the end border is cover
rows = start_y_left:interval(k):start_y_left+width_left;
if rows(end) ~= start_y_left+width_left
    stim(start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=0;
end
cols = start_x_left:interval(k):start_x_left+length_left;
if cols(end) ~= start_x_left+length_left
    stim(start_y_left:interval(k):start_y_left+width_left,start_x_left+length_left)=0;
end
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;

% Right rectangle border
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)=250;
stim(start_y_right:interval(k):start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=0;
rows = start_y_right:interval(k):start_y_right+width_right;
if rows(end) ~= start_y_right+width_right
    stim(start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=0;
end
cols = start_x_right:interval(k):start_x_right+length_right;
if cols(end) ~= start_x_right+length_right
    stim(start_y_right:interval(k):start_y_right+width_right,start_x_right+length_right)=0;
end
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% store
% stim = repmat(stim,[1 1 3]);
% stim = uint8(stim);
% stimWrite = strcat('stimuli_dash',int2str(interval(k)-1),'_right_',int2str(i));
% outputFolder = fullfile('data/dash_line/', num2str(interval(k)-1), '/right');
% save(fullfile(outputFolder, stimWrite), 'stim')
end

% for dotted line
for k = 2:length(interval)
 stim = uint8(zeros(227));
%Draw hollow rectangles
% Left rectangle border
stim(start_y_left:interval(k):start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=250;
%ensure the end border is cover
rows = start_y_left:interval(k):start_y_left+width_left;
if rows(end) ~= start_y_left+width_left
    stim(start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=250;
end
cols = start_x_left:interval(k):start_x_left+length_left;
if cols(end) ~= start_x_left+length_left
    stim(start_y_left:interval(k):start_y_left+width_left,start_x_left+length_left)=250;
end
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;

% Right rectangle border
stim(start_y_right:interval(k):start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=250;
rows = start_y_right:interval(k):start_y_right+width_right;
if rows(end) ~= start_y_right+width_right
    stim(start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=250;
end
cols = start_x_right:interval(k):start_x_right+length_right;
if cols(end) ~= start_x_right+length_right
    stim(start_y_right:interval(k):start_y_right+width_right,start_x_right+length_right)=250;
end
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_dotted',int2str(interval(k)-1),'_right_',int2str(i));
outputFolder = fullfile('data/dotted_line/', num2str(interval(k)-1), '/right');
save(fullfile(outputFolder, stimWrite), 'stim')
end
end

% ----left----
imgs_left = zeros(227, 227, 1, 10, 'uint8');
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

%for original image (control)
%Draw hollow rectangles
% Right rectangle border
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)=250;
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% Left rectangle border
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)=250;
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;
% store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_dash_control_left_',int2str(i));
outputFolder = fullfile('data/dash_line/control/left');
save(fullfile(outputFolder, stimWrite), 'stim')

%for dash line
for k = 1:length(interval)
stim = uint8(zeros(227));
%Draw hollow rectangles
% Right rectangle border
stim(start_y_right:start_y_right+width_right,start_x_right:start_x_right+length_right)=250;
stim(start_y_right:interval(k):start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=0;
rows = start_y_right:interval(k):start_y_right+width_right;
if rows(end) ~= start_y_right+width_right
    stim(start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=0;
end
cols = start_x_right:interval(k):start_x_right+length_right;
if cols(end) ~= start_x_right+length_right
    stim(start_y_right:interval(k):start_y_right+width_right,start_x_right+length_right)=0;
end
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% Left rectangle border
stim(start_y_left:start_y_left+width_left,start_x_left:start_x_left+length_left)=250;
stim(start_y_left:interval(k):start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=0;
%ensure the end border is cover
rows = start_y_left:interval(k):start_y_left+width_left;
if rows(end) ~= start_y_left+width_left
    stim(start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=0;
end
cols = start_x_left:interval(k):start_x_left+length_left;
if cols(end) ~= start_x_left+length_left
    stim(start_y_left:interval(k):start_y_left+width_left,start_x_left+length_left)=0;
end
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_dash',int2str(interval(k)-1),'_left_',int2str(i));
outputFolder = fullfile('data/dash_line/', num2str(interval(k)-1), '/left');
save(fullfile(outputFolder, stimWrite), 'stim')
end

%for dotted line
for k = 2:length(interval)
stim = uint8(zeros(227));
%Draw hollow rectangles
% Right rectangle border
stim(start_y_right:interval(k):start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=250;
rows = start_y_right:interval(k):start_y_right+width_right;
if rows(end) ~= start_y_right+width_right
    stim(start_y_right+width_right,start_x_right:interval(k):start_x_right+length_right)=250;
end
cols = start_x_right:interval(k):start_x_right+length_right;
if cols(end) ~= start_x_right+length_right
    stim(start_y_right:interval(k):start_y_right+width_right,start_x_right+length_right)=250;
end
stim(start_y_right+1:start_y_right+width_right-1,start_x_right+1:start_x_right+length_right-1)=0;
% Left rectangle border
stim(start_y_left:interval(k):start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=250;
%ensure the end border is cover
rows = start_y_left:interval(k):start_y_left+width_left;
if rows(end) ~= start_y_left+width_left
    stim(start_y_left+width_left,start_x_left:interval(k):start_x_left+length_left)=250;
end
cols = start_x_left:interval(k):start_x_left+length_left;
if cols(end) ~= start_x_left+length_left
    stim(start_y_left:interval(k):start_y_left+width_left,start_x_left+length_left)=250;
end
stim(start_y_left+1:start_y_left+width_left-1,start_x_left+1:start_x_left+length_left-1)=0;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_dotted',int2str(interval(k)-1),'_left_',int2str(i));
outputFolder = fullfile('data/dotted_line/', num2str(interval(k)-1), '/left');
save(fullfile(outputFolder, stimWrite), 'stim')
end
end

%% removing the diagonal corner of the overlap corner (test)
% ----right----
imgs_right = zeros(227, 227, 1, 49, 'uint8');
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
%removing the corner diagonal to the overlap corner
stim(start_y_left:start_y_left+(width_left*0.25), start_x_left:start_x_left+(length_left*0.25))=0;
stim(start_y_right+(width_right*0.75)-1:start_y_right+width_right+1, start_x_right+(length_right*0.75)-1:start_x_right+length_right+1)=0;
%display
imgs_right(:,:,1,i) = stim;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_frag_one_right',int2str(i));
outputFolder = 'data_test/fragment/diagonal/right/';
save(fullfile(outputFolder, stimWrite), 'stim')
end
figure;
montage(imgs_right, 'Size', [7 7]);
title("right");

% ----left----
imgs_left = zeros(227, 227, 1, 49, 'uint8');
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
%removing the corner diagonal to the overlap corner
stim(start_y_left:start_y_left+(width_left*0.25), start_x_left:start_x_left+(length_left*0.25))=0;
stim(start_y_right+(width_right*0.75)-1:start_y_right+width_right+1, start_x_right+(length_right*0.75)-1:start_x_right+length_right+1)=0;
%display
imgs_left(:,:,1,i) = stim;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_frag_one_left',int2str(i));
outputFolder = 'data_test/fragment/diagonal/left/';
save(fullfile(outputFolder, stimWrite), 'stim')
end
figure;
montage(imgs_left, 'Size', [7 7]);
title("left");



%% size-invariant (testing)
% Parameters
s = [40,80,160];% side lengths in pixels (e.g., for 4°, 6°, 11° equivalents)
start =[80 70 30;
        100 110 140];
imgs_size = zeros(227, 227, 1, 3, 'uint8');

for i = 1:length(s)
stim = uint8(zeros(227));
% Right rectangle border
stim(start(1,i):start(1,i)+s(i),start(1,i):start(1,i)+s(i))=250;
stim(start(1,i)+1:start(1,i)-1+s(i),start(1,i)+1:start(1,i)-1+s(i))=0;
% Left rectangle border
stim(start(2,i):start(2,i)+s(i),start(2,i):start(2,i)+s(i))=250;
stim(start(2,i)+1:start(2,i)-1+s(i),start(2,i)+1:start(2,i)-1+s(i))=0;

c = floor(length(stim)/2);
stim_trim = stim(c-112:c+114, c-112:c+114);
imgs_size(:,:,1,i) = stim_trim;

stim_trim = repmat(stim_trim,[1 1 3]);
stim_trim = uint8(stim_trim);
stimWrite = strcat('stimuli_size_',int2str(i));
outputFolder = 'data/';
save(fullfile(outputFolder, stimWrite), 'stim_trim')

end

figure;
montage(imgs_size, 'Size', [1 3]);
title("size");