module test32and;
	reg [31:0] in1,in2;
	wire [31:0] out;
	or32 a1(out,in1,in2);
	
	initial
	begin
		$monitor($time," in1 = %h, in2=%h, out=%h",in1,in2,out);
		#0 in1 = 32'hA5A5;
		#0 in2 = 32'h5A5A;
		#100 in1 = 32'h5A5A;
		#400 $finish;
	end
endmodule