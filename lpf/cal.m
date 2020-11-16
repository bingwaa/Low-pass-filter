% clc ,clear, close all;
fs= 48000; % 与fdatool工具保持一致
fpass= 7200; % 归一化 fpass= 0.3* 2/fs = 7200
fstop= 14400; % 归一化 fstop= 0.6* 2/fs = 14400
t= 0:1/fs:0.005;
signal= sin(2*pi*fpass*t)+ sin(2*pi*2*fstop*t);

figure(1);
subplot(2,1,1);
plot(t,signal);xlabel('带噪信号');
f_signal = filter(lpf,signal);
subplot(2,1,2);
plot(t,f_signal);xlabel('无噪滤波信号');

% 提取滤波器系数
coefMAT= load('coefficient');
coef= coefMAT.num;

SCALE= 14;% 缩放长度
cSCALE= 16;% 系数缩放长度

% 量化
signal_scale= round(signal* 2^SCALE);
coef_scale= round(coef* 2^cSCALE);
result_scale= filter(coef_scale,1,signal_scale);% 滤波信号

% err_signal= signal_scale* 2^(-SCALE)-signal;% 误差计算
% err_coef= coef_scale* 2^(-cSCALE)-coef;
% 
% % 缩放还原
% result= result_scale*2^(-(SCALE+cSCALE));
% fprintf('缩放信号的误差:%d\n',sumsqr(result-f_signal));
% 
% figure(2);
% subplot(2,1,1);
% plot(t,err_signal);xlabel(['信号量化误差(sumsqr):',num2str(sumsqr(err_signal))]);
% subplot(2,1,2);
% plot(0:length(coef)-1,err_coef);xlabel(['系数量化误差?(sumsqr):',num2str(sumsqr(err_coef))]);
% 
% figure(3);
% subplot(2,1,1);
% plot(t,signal_scale);xlabel('缩放信号输入');
% subplot(2,1,2);
% plot(t,result_scale);xlabel('缩放信号输出');
% 
% figure(4);
% plot(t,result-f_signal);xlabel('浮点输出和定点输出的误差');

f=fopen('C:/Users/bingw/Desktop/fir/lpf/data.txt','w');% 输出数据
fprintf(f,'%g\n',signal_scale');
fclose(f);