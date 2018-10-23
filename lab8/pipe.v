module prio_enco(en, a_in, y_op); 
input en; 
input [7:0] a_in; 
output [2:0] y_op; 
reg [2:0] y_op; 
always @ (a_in,en) 
begin 
case (a_in) 
8'b00000001: y_op = 3'b000; 
8'b0000001x: y_op= 3'b001; 
8'b000001xx: y_op= 3'b010; 
8'b00001xxx: y_op= 3'b011; 
8'b0001xxxx: y_op= 3'b100; 
8'b001xxxxx: y_op= 3'b101; 
8'b01xxxxxx: y_op= 3'b110; 
8'b1xxxxxxx: y_op= 3'b111; 
default: y_op=3'bxxx; 
endcase 
end 
endmodule 


module alu(x,a,b,co,ctrl);
input [3:0] a;
input [3:0] b;
input [2:0] ctrl;
output [3:0] x;
output co;

wire [3:0] bn,bo,m0,m1,m2,m3,m4,m5,m6,m7;
//wire co;

not4 n1(bn,b);
b4mux2to1 mux1(bo,ctrl[0],b,bn);
fadder4 add1(m0,co,a,bo,ctrl[0]);
fadder4 sub1(m1,co,a,bn,1'b1);
xor4 xx(m2,a,b);
or4 oo(m3,a,b);
and4 an(m4,a,b);
nor4 no(m5,a,b);
nand4 na(m6,a,b);
xnor4 xn(m7,a,b);

b4mux8to1 lastmux(x,ctrl,{m0,m1,m2,m3,m4,m5,m6,m7});

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

module b4mux2to1(out,sel,inp1,inp2);
	input [3:0] inp1,inp2;
	input sel;
	output [3:0] out;
	genvar j;
	
	generate for(j=0;j<4;j=j+1) begin: mux_loop
		mux2to1 m1(out[j],sel,inp1[j],inp2[j]);
	end
	endgenerate
endmodule

module b4mux8to1(out,sel,inp);
	input [7:0][3:0] inp;
	input [2:0] sel;
	output [3:0] out;
	wire [3:0] a1,a2,a3,a4,a5,a6;
	
	b4mux2to1 m1(a1,sel[0],inp[0],inp[1]);
	b4mux2to1 m2(a2,sel[0],inp[2],inp[3]);
	b4mux2to1 m3(a3,sel[0],inp[4],inp[5]);
	b4mux2to1 m4(a4,sel[0],inp[6],inp[7]);
	b4mux2to1 m5(a5,sel[1],a1,a2);
	b4mux2to1 m6(a6,sel[1],a3,a4);
	b4mux2to1 m7(out,sel[2],a5,a6);
endmodule

module and4(out,in1,in2);
	input [3:0] in1,in2;
	output [3:0] out;
	assign {out}=in1&in2;
endmodule

module or4(out,in1,in2);
	input [3:0] in1,in2;
	output [3:0] out;
	assign {out}=in1 | in2;
endmodule

module not4(out,in);
	input [3:0] in;
	output [3:0] out;
	assign {out} = ~in;
endmodule

module nor4(out,in1,in2);
	input [3:0] in1,in2;
	output [3:0] out;
	assign {out} = (~in1)|(~in2);
endmodule

module nand4(out,in1,in2);
	input [3:0] in1,in2;
	output [3:0] out;
	assign {out} = (~in1)&(~in2);
endmodule

module xor4(out,in1,in2);
	input [3:0] in1,in2;
	output [3:0] out;
	assign {out} = (in1)^(in2);
endmodule

module xnor4(out,in1,in2);
	input [3:0] in1,in2;
	output [3:0] out;
	assign {out} = (~in1)^(~in2);
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

module fadder4(s,co,x,y,cin);
	input [3:0] x,y;
	input cin;
	output co;
	output [3:0] s;
	wire [2:0] c;
	//wire t;
	//assign t = 1'b0;
	
	fadder f0(s[0],c[0],{x[0],y[0],cin});
	fadder f1(s[1],c[1],{x[1],y[1],c[0]});
	fadder f2(s[2],c[2],{x[2],y[2],c[1]});
	fadder f3(s[3],co,{x[3],y[3],c[2]});
endmodule

