module test32add;
	reg [31:0] in1,in2;
	wire [31:0] out;
	wire co;
	fadder32 f1(out,co,in1,in2,1'b0);
	
	initial
	begin
		$monitor($time," in1 = %h, in2=%h, out=%h,co=%b",in1,in2,out,co);
		#0 in1 = 32'hFFFFA5A5;
		#0 in2 = 32'hffff5A5A;
		#100 in1 = 32'h5A5A;
		#400 $finish;
	end
endmodule