`timescale 1ns/1ps

module fir(clk,rst,f_in,f_out);
	input clk;
	input rst;
	input wire signed [15:0]f_in;
	output reg signed [31:0]f_out;
	
	parameter width=16;// 数据位宽
	parameter order=16;// 滤波器阶数

	reg signed [width-1:0]delay[order:0];// 延迟流水线
	
	wire signed [width-1:0]coef[order:0];// 滤波系数
	assign coef[0]= 212;
	assign coef[1]= 747;
	assign coef[2]= 708;
	assign coef[3]= -1359;
	assign coef[4]= -4406;
	assign coef[5]= -3348;
	assign coef[6]= 5875;
	assign coef[7]= 19049;
	assign coef[8]= 25409;
	assign coef[9]= 19049;
	assign coef[10]= 5875;
	assign coef[11]= -3348;
	assign coef[12]= -4406;
	assign coef[13]= -1359;
	assign coef[14]= 708;
	assign coef[15]= 747;
	assign coef[16]= 212;

	reg signed [31:0]multi[16:0];// 乘法器
	reg signed [31:0]sum_buf;// 求和缓冲器
	reg signed [15:0]din_buf;// 输入数据缓冲器

	always@(posedge clk or negedge rst) din_buf<= !rst?0:f_in;// 输入数据送入流水线
	always@(posedge clk or negedge rst)begin
		if(!rst)begin
			delay[0]<= 0;
			delay[1]<= 0;
			delay[2]<= 0;
			delay[3]<= 0;
			delay[4]<= 0;
			delay[5]<= 0;
			delay[6]<= 0;
			delay[7]<= 0;
			delay[8]<= 0;
			delay[9]<= 0;
			delay[10]<= 0;
			delay[11]<= 0;
			delay[12]<= 0;
			delay[13]<= 0;
			delay[14]<= 0;
			delay[15]<= 0;
			delay[16]<= 0;
		end 
		else begin
			delay[0]<= din_buf;
			delay[1]<= delay[0];
			delay[2]<= delay[1];
			delay[3]<= delay[2];
			delay[4]<= delay[3];
			delay[5]<= delay[4];
			delay[6]<= delay[5];
			delay[7]<= delay[6];
			delay[8]<= delay[7];
			delay[9]<= delay[8];
			delay[10]<= delay[9];
			delay[11]<= delay[10];
			delay[12]<= delay[11];
			delay[13]<= delay[12];
			delay[14]<= delay[13];
			delay[15]<= delay[14];
			delay[16]<= delay[15];
		end
	end

	always@(posedge clk or negedge rst)begin// 进行乘累加操作
		if(!rst)begin
			multi[0]<= 0;
			multi[1]<= 0;
			multi[2]<= 0;
			multi[3]<= 0;
			multi[4]<= 0;
			multi[5]<= 0;
			multi[6]<= 0;
			multi[7]<= 0;
			multi[8]<= 0;
			multi[9]<= 0;
			multi[10]<= 0;
			multi[11]<= 0;
			multi[12]<= 0;
			multi[13]<= 0;
			multi[14]<= 0;
			multi[15]<= 0;
			multi[16]<= 0;
		end
		else begin
			multi[0]<= coef[0]* delay[0];
			multi[1]<= coef[1]* delay[1];
			multi[2]<= coef[2]* delay[2];
			multi[3]<= coef[3]* delay[3];
			multi[4]<= coef[4]* delay[4];
			multi[5]<= coef[5]* delay[5];
			multi[6]<= coef[6]* delay[6];
			multi[7]<= coef[7]* delay[7];
			multi[8]<= coef[8]* delay[8];
			multi[9]<= coef[9]* delay[9];
			multi[10]<= coef[10]* delay[10];
			multi[11]<= coef[11]* delay[11];
			multi[12]<= coef[12]* delay[12];
			multi[13]<= coef[13]* delay[13];
			multi[14]<= coef[14]* delay[14];
			multi[15]<= coef[15]* delay[15];
			multi[16]<= coef[16]* delay[16];
		end
	end

	always@(posedge clk or negedge rst) sum_buf<= !rst?0:
	(multi[0]+ multi[1]+ multi[2]+ 
	 multi[3]+ multi[4]+ multi[5]+ 
	 multi[6]+ multi[7]+ multi[8]+ 
	 multi[9]+ multi[10]+ multi[11]+ 
	 multi[12]+ multi[13]+ multi[14]+ 
	 multi[15]+ multi[16]);
	always@(sum_buf) f_out<= !rst?0:sum_buf;

endmodule