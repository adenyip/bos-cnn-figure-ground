function stim = remove_2(stim,start_x_left,start_y_left,start_x_right,start_y_right,length_left,width_left,length_right,width_right)

stim(start_y_left,start_x_left+(length_left*0.25):start_x_left+(length_left*0.75))=0;
stim(start_y_right+width_right, start_x_right+(length_right*0.25):start_x_right+(length_right*0.75))=0;

end