module and3(out, i1, i2, i3);
input i1,i2,i3;
output out;
assign out = i1 & i2 & i3;
endmodule

module RegFile32(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
input clk,reset,RegWrite;
input [4:0] ReadReg1,ReadReg2,WriteReg;
input [31:0] WriteData;
output [31:0] ReadData1,ReadData2;
//reg [31:0] ReadData1,ReadData2;
wire a;
wire [31:0] iclock,dop;
wire [31:0][31:0] q;
genvar j;

decoder5_32 d1(dop,WriteReg);

generate for (j=0;j<32;j=j+1) begin: init_reg
		and3 A(iclock[j],clk,RegWrite,dop[j]);
		reg32 R0(q[j],WriteData,iclock[j],reset);
	end
endgenerate

		
		//reg32 R1(q[1],WriteData,iclock[1],reset);
		//reg32 R2(q[2],WriteData,iclock[2],reset);
		//reg32 R3(q[3],WriteData,iclock[3],reset);

		//make 32:1 mux. fix this line
//bit32_mux4to1 m0(ReadData1,ReadReg1,q[0],q[1],q[2],q[3]);
//bit32_mux4to1 m1(ReadData2,ReadReg2,q[0],q[1],q[2],q[3]);
endmodule

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
input clk,reset,RegWrite;
input [1:0] ReadReg1,ReadReg2,WriteReg;
input [31:0] WriteData;
output [31:0] ReadData1,ReadData2;
//reg [31:0] ReadData1,ReadData2;
wire a;
wire [3:0] iclock,dop;
wire [3:0][31:0] q;
genvar j;

decoder2_4 d1(dop,WriteReg);

generate for (j=0;j<4;j=j+1) begin: init_reg
		and3 A(iclock[j],clk,RegWrite,dop[j]);
		reg32 R0(q[j],WriteData,iclock[j],reset);
	end
endgenerate

		
		//reg32 R1(q[1],WriteData,iclock[1],reset);
		//reg32 R2(q[2],WriteData,iclock[2],reset);
		//reg32 R3(q[3],WriteData,iclock[3],reset);

bit32_mux4to1 m0(ReadData1,ReadReg1,q[0],q[1],q[2],q[3]);
bit32_mux4to1 m1(ReadData2,ReadReg2,q[0],q[1],q[2],q[3]);
endmodule

module mux2to1(out,sel,in1,in2);
 input in1,in2,sel;
 output out;
 wire not_sel,a1,a2;
 not (not_sel,sel);
 and (a1,sel,in2);
 and (a2,not_sel,in1);
 or(out,a1,a2);
endmodule

module mux4to1(out,sel,in1,in2,in3,in4);
	input in1,in2,in3,in4;
	input [1:0] sel;
	output out;
	wire w1,w2;
	mux2to1 m0(w1,sel[0],in1,in2);
	mux2to1 m1(w2,sel[0],in3,in4);
	mux2to1 m2(out,sel[1],w1,w2);
endmodule

module bit32_mux4to1(out,sel,inp1,inp2,inp3,inp4);
	input [31:0] inp1,inp2,inp3,inp4;
	input [1:0] sel;
	output [31:0] out;
	genvar j;
	generate for(j=0;j<32;j=j+1) begin: mux8_loop
		mux4to1 m2(out[j],sel,inp1[j],inp2[j],inp3[j],inp4[j]);
	end
	endgenerate
endmodule

module dff(q, d, clk, reset);
	input d, reset, clk;
	output q;
	reg q;
	always @ (posedge clk)
	begin
		if (!reset) q <= 1'b0;
		else q <= d;
	end
endmodule

module reg32(q, d, clk, reset);
input [31:0] d;
input clk,reset;
output [31:0] q;
genvar j;
generate for (j=0;j<32;j=j+1) begin: reg_loop
	dff d1(q[j],d[j],clk,reset);
	end	
endgenerate
endmodule

module decoder3_8(d,x,y,z);
	input x,y,z;
	output [0:7] d;
	wire x0,y0,z0;
	
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	
	and a1(d[0],x0,y0,z0);
	and a2(d[1],x0,y0,z);
	and a3(d[2],x0,y,z0);
	and a4(d[3],x0,y,z);
	and a5(d[4],x,y0,z0);
	and a6(d[5],x,y0,z);
	and a7(d[6],x,y,z0);
	and a8(d[7],x,y,z);
endmodule

module decoder2_4(d,{x,y});
	input x,y;
	output [3:0] d;
	wire x0,y0;
	
	not n1(x0,x);
	not n2(y0,y);
	
	and a1(d[0],x0,y0);
	and a2(d[1],x0,y);
	and a3(d[2],x,y0);
	and a4(d[3],x,y);
endmodule

module decoder5_32(d,{v,w,x,y,z});
	input v,w,x,y,z;
	output [0:31] d;
	wire x0,y0,z0,v0,w0;
	
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	not n4(v0,v);
	not n5(w0,w);
	
	and a1(d[0],v0,w0,x0,y0,z0);
	and a2(d[1],v0,w0,x0,y0,z);
	and a3(d[2],v0,w0,x0,y,z0);
	and a4(d[3],v0,w0,x0,y,z);
	and a5(d[4],v0,w0,x,y0,z0);
	and a6(d[5],v0,w0,x,y0,z);
	and a7(d[6],v0,w0,x,y,z0);
	and a8(d[7],v0,w0,x,y,z);
	and a9(d[8],v0,w,x0,y0,z0);
	and a10(d[9],v0,w,x0,y0,z);
	and a11(d[10],v0,w,x0,y,z0);
	and a12(d[11],v0,w,x0,y,z);
	and a13(d[12],v0,w,x,y0,z0);
	and a14(d[13],v0,w,x,y0,z);
	and a15(d[14],v0,w,x,y,z0);
	and a16(d[15],v0,w,x,y,z);
	and a17(d[16],v,w0,x0,y0,z0);
	and a18(d[17],v,w0,x0,y0,z);
	and a19(d[18],v,w0,x0,y,z0);
	and a20(d[19],v,w0,x0,y,z);
	and a21(d[20],v,w0,x,y0,z0);
	and a22(d[21],v,w0,x,y0,z);
	and a23(d[22],v,w0,x,y,z0);
	and a24(d[23],v,w0,x,y,z);
	and a25(d[24],v,w,x0,y0,z0);
	and a26(d[25],v,w,x0,y0,z);
	and a27(d[26],v,w,x0,y,z0);
	and a28(d[27],v,w,x0,y,z);
	and a29(d[28],v,w,x,y0,z0);
	and a30(d[29],v,w,x,y0,z);
	and a31(d[30],v,w,x,y,z0);
	and a32(d[31],v,w,x,y,z);
	
endmodule

module decoder5_32P(d,in);
	output [31:0] d;
	assign d = 32'b0;
	assign d[16*in[4]+8*in[3]+4*in[2]+2*in[1]+1*in[0]] = 1'b1;
endmodule
	
