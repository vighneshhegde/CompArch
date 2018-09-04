module and32(out,in1,in2);
	input [31:0] in1,in2;
	output [31:0] out;
	assign {out}=in1&in2;
endmodule

module or32(out,in1,in2);
	input [31:0] in1,in2;
	output [31:0] out;
	assign {out}=in1 | in2;
endmodule

module not32(out,in);
	input [31:0] in;
	output [31:0] out;
	assign {out} = ~in;
endmodule