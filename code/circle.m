clc
clear
close all
n=1000;

% ----right----
for i = 1:n
stim = uint8(zeros(227));
%left
r_left = randi([8 90]);
x_center_left = randi([20+r_left, 207-r_left]);
y_center_left = randi([20+r_left, 207-r_left]);
[X, Y] = meshgrid(1:227, 1:227);
d2_left = (X - x_center_left).^2 + (Y - y_center_left).^2;
outer_left = d2_left <= r_left^2;
inner = d2_left <= max(r_left - 1, 0)^2;
ring_left = outer_left & ~inner;
%right
x_center_right = randi([(x_center_left+4) (x_center_left+r_left-4)]);
y_center_right = randi([(y_center_left+2) (y_center_left+r_left-2)]);
r_right = randi([(x_center_left+r_left-x_center_right+2) r_left]);
d2_right = (X - x_center_right).^2 + (Y - y_center_right).^2;
outer_right = d2_right <= r_right^2;
inner = d2_right <= max(r_right - 1, 0)^2;
ring_right = outer_right & ~inner;
%draw
stim(outer_left) = 0;
stim(ring_left) = 250;
stim(outer_right) = 0;
stim(ring_right) = 250;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_circle_right_',int2str(i));
outputFolder = 'data_test/circle_invar/right/';
save(fullfile(outputFolder, stimWrite), 'stim')
end

% ----left----
for i = 1:n
stim = uint8(zeros(227));
%left
r_left = randi([8 90]);
x_center_left = randi([20+r_left, 207-r_left]);
y_center_left = randi([20+r_left, 207-r_left]);
[X, Y] = meshgrid(1:227, 1:227);
d2_left = (X - x_center_left).^2 + (Y - y_center_left).^2;
outer_left = d2_left <= r_left^2;
inner = d2_left <= max(r_left - 1, 0)^2;
ring_left = outer_left & ~inner;
%right
x_center_right = randi([(x_center_left+4) (x_center_left+r_left-4)]);
y_center_right = randi([(y_center_left+2) (y_center_left+r_left-2)]);
r_right = randi([(x_center_left+r_left-x_center_right+2) r_left]);
d2_right = (X - x_center_right).^2 + (Y - y_center_right).^2;
outer_right = d2_right <= r_right^2;
inner = d2_right <= max(r_right - 1, 0)^2;
ring_right = outer_right & ~inner;
%draw
stim(outer_right) = 0;
stim(ring_right) = 250;
stim(outer_left) = 0;
stim(ring_left) = 250;
%store
stim = repmat(stim,[1 1 3]);
stim = uint8(stim);
stimWrite = strcat('stimuli_circle_left_',int2str(i));
outputFolder = 'data_test/circle_invar/left/';
save(fullfile(outputFolder, stimWrite), 'stim')
end