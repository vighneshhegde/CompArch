module alu32(res,co,a,b,cin,op);
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
	fadder32 f1(w2,co,a,bo,cin);
	
	bit32_mux3to1 m2(res,op,w0,w1,w2);
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

module decoder(d,x,y,z);
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
module fadder(s,c,x);
	input [0:2] x;
	output s,c;
	wire [0:7] d;
	
	decoder d1(d,x[0],x[1],x[2]);
	
	assign s = d[1] | d[2] | d[4] | d[7];
	assign c = d[3] | d[5] | d[6] | d[7];
	
endmodule

module fadder8(s,co,x,y,cin);
	input [7:0] x,y;
	input cin;
	output co;
	output [7:0] s;
	wire [6:0] c;
	//wire t;
	//assign t = 1'b0;
	
	fadder f0(s[0],c[0],{x[0],y[0],cin});
	fadder f1(s[1],c[1],{x[1],y[1],c[0]});
	fadder f2(s[2],c[2],{x[2],y[2],c[1]});
	fadder f3(s[3],c[3],{x[3],y[3],c[2]});
	fadder f4(s[4],c[4],{x[4],y[4],c[3]});
	fadder f5(s[5],c[5],{x[5],y[5],c[4]});
	fadder f6(s[6],c[6],{x[6],y[6],c[5]});
	fadder f7(s[7],co,{x[7],y[7],c[6]});
	
endmodule

module fadder32(s,co,a,b,ci);
	input [31:0] a,b;
	input ci;
	wire c[3:0];
	output [31:0] s;
	output co;
	
	fadder8 f0(s[7:0],c[0],a[7:0],b[7:0],ci);
	fadder8 f1(s[15:8],c[1],a[15:8],b[15:8],c[0]);
	fadder8 f2(s[23:16],c[2],a[23:16],b[23:16],c[1]);
	fadder8 f3(s[31:24],co,a[31:24],b[31:24],c[2]);
endmodule


