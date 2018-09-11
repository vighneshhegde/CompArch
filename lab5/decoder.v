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