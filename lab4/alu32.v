module alu32(res,co,a,b,cin,op)
	input [31:0] a,b;
	input cin;
	input [1:0] op;
	output [31:0] res;
	output co;
	wire [31:0] w0,w1,w2,bo,bn;
	
	not32 n1(bn,b);
	bit32_mux2to1 m1(bo,cin,b,bn);
	and32 a1(w0,a,bo);
	or32 o1(w1,a,bo);
	fadder32 f1(w2,co,in1,in2,cin);
	
	bit32_mux3to1 m2(res,op,w0,w1,w2);
	
	
	