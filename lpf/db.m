% 读取verilog滤波器计算结果
fid= fopen('C:/Users/bingw\Desktop/fir/lpf/dataout.txt');
v_data= textscan(fid,'%d');
fclose(fid);

subplot(2,1,1);
% 开始时输出为0,因为在verilog代码中使用了15级流水线
plot(v_data{1}(6:end));xlabel('verilog滤波结果');

subplot(2,1,2);
plot(result_scale);xlabel('matlab滤波结果');

fprintf('verilog和matlab之间的误差(sumsqr): %d \n',sumsqr(double(v_data{1}(6:end))-result_scale'));