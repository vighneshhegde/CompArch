module mux2to1(out,sel,in1,in2);
 input in1,in2,sel;
 output out;
 wire not_sel,a1,a2;
 not (not_sel,sel);
 and (a1,sel,in2);
 and (a2,not_sel,in1);
 or(out,a1,a2);
endmodule

module bit8_mux2to1(out,sel,inp1,inp2);
	input [7:0] inp1,inp2;
	input sel;
	output [7:0] out;
	genvar j;
	
	generate for(j=0;j<8;j=j+1) begin: mux_loop
		mux2to1 m1(out[j],sel,inp1[j],inp2[j]);
	end
	endgenerate
endmodule

module bit32_mux2to1(out,sel,inp1,inp2);
	input [31:0] inp1,inp2;
	input sel;
	output [31:0] out;
	genvar j;
	
	generate for(j=0;j<32;j=j+8) begin: mux8_loop
		bit8_mux2to1 m2(out[j+7:j],sel,inp1[j+7:j],inp2[j+7:j]);
	end
	endgenerate
endmodule
	
module mux3to1(out,sel,in1,in2,in3);
	input in1,in2,in3;
	input [1:0] sel;
	output out;
	wire w;
	mux2to1 m0(w,sel[0],in1,in2);
	mux2to1 m1(out,sel[1],w,in3);
endmodule

module bit32_mux3to1(out,sel,inp1,inp2,inp3);
	input [31:0] inp1,inp2,inp3;
	input [1:0] sel;
	output [31:0] out;
	genvar j;
	generate for(j=0;j<32;j=j+1) begin: mux8_loop
		mux3to1 m2(out[j],sel,inp1[j],inp2[j],inp3[j]);
	end
	endgenerate
endmodule