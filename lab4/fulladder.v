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
	
	fadder8 f0(s[7:0],c[0],a[7:0],b[7:0],1'b0);
	fadder8 f1(s[15:8],c[1],a[15:8],b[15:8],c[0]);
	fadder8 f2(s[23:16],c[2],a[23:16],b[23:16],c[1]);
	fadder8 f3(s[31:24],co,a[31:24],b[31:24],c[2]);
	
	
endmodule
	
	