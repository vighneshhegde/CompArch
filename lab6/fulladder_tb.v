module test32add;
	reg [31:0] in1,in2;
	reg cin;
	wire [31:0] out,in2n;
	wire co;
	not32 n1(in2n,in2);
	fadder32 f1(out,co,in1,in2n,cin);
	initial
	begin
		$monitor($time," in1 = %h, in2=%h, out=%h,co=%b",in1,in2,out,co);
		#0 in1 = 32'h10000002;
		#10 in2 = 32'h10000001;
		#0 cin = 1'b1;
		#400 $finish;
	end
endmodule