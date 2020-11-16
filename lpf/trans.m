WIDTH= 16;

signal_trans= dec2bin(signal_scale+ 2^WIDTH* (signal_scale<0),WIDTH);

signal_trans= signal_trans';
fdata= fopen('C:/Users/bingw/Desktop/fir/lpf/datain.txt','wb');

for index= 1:length(signal_scale)
    for i= 1:WIDTH 
        fprintf(fdata,'%s',signal_trans((index-1)*WIDTH+i));
    end
    fprintf(fdata,'\r\n');
end
fclose(fdata);