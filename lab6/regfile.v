module and3(out, i1, i2, i3);
input i1,i2,i3;
output out;
assign out = i1 & i2 & i3;
endmodule

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
input clk,reset,RegWrite;
input [1:0] ReadReg1,ReadReg2,WriteReg;
input [31:0] WriteData;
output [31:0] ReadData1,ReadData2;
//reg [31:0] ReadData1,ReadData2;
wire a;
wire [3:0] iclock,dop;
wire [31:0] q0,q1,q2,q3;
genvar j;

decoder2_4 d1(dop,WriteReg);

generate for (j=0;j<4;j=j+1) begin: init_reg
		and3 A(iclock[j],clk,RegWrite,dop[j]);

	end
endgenerate

		reg32 R0(q0,WriteData,iclock[0],reset);
		reg32 R1(q1,WriteData,iclock[1],reset);
		reg32 R2(q2,WriteData,iclock[2],reset);
		reg32 R3(q3,WriteData,iclock[3],reset);

bit32_mux4to1 m0(ReadData1,ReadReg1,q0,q1,q2,q3);
bit32_mux4to1 m1(ReadData2,ReadReg2,q0,q1,q2,q3);
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