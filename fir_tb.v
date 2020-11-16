`timescale 1ns/1ps
`include "fir.v"

module fir_tb;
	reg clk;
	reg rst;
	reg signed [15:0]f_in;
	wire signed [31:0]f_out;

	fir fir(
		.clk(clk), 
		.rst(rst), 
		.f_in(f_in), 
		.f_out(f_out));

	initial begin
		rst= 0;
		#15 rst= 1;
	end

	initial begin
		clk= 0;
		forever #10 clk= ~clk;
	end

	reg signed [15:0]mem[241:0];// 输入数据寄存器
	
	initial begin
		$readmemb("C:/Users/bingw/Desktop/fir/lpf/datain.txt",mem);// 读取文件数据
	end

	integer i= 0;
	initial begin
		#15;
		for(i= 0;i<242;i= i+ 1)begin
			f_in= mem[i];// 发送数据到滤波器
			#20;
		end	
	end

	integer file;
	
	initial begin
		file= $fopen("C:/Users/bingw/Desktop/fir/lpf/dataout.txt","w");// 创建txt句柄
	end

	always@(posedge clk)begin
		$fdisplay(file,f_out);// 写入滤波器输出数据到txt文本
	end

	integer j= 0;// 计数
	always@(posedge clk)begin
		$display("%d:  %d",j,f_out);// 显示滤波器输出数据到控制台
		j= j+ 1;
		if(j==246)begin
			#20 $fclose(file);
			rst= 0;
			#20 $stop;// 停止
		end
	end
	
endmodule