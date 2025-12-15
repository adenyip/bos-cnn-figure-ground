function stim = remove_8(stim,start_x_left,start_y_left,start_x_right,start_y_right,length_left,width_left,length_right,width_right)

stim(start_y_left+(width_left*0.75)-1:start_y_left+width_left+1,start_x_left+(length_left*0.75)-1:start_x_left+length_left+1)=0;
stim(start_y_right:start_y_right+(width_right*0.25), start_x_right-1:start_x_right+(length_right*0.25))=0;

end