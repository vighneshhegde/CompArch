module test32mux;
	reg [31:0] in1,in2,in3;
	reg [1:0] sel;
	wire [31:0] out;
	bit32_mux3to1 b1(out,sel,in1,in2,in3);
	
	initial
	begin
		$monitor($time," in1 = %h, in2=%h, out=%h, sel=%b",in1,in2,out,sel);
		#0 in1 = 32'hffffA5A5;
		#0 in2 = 32'h45675A5A;
		#0 in3 = 32'h89786333;
		#0 sel = 2'b00;
		#100 sel = 2'b01;
		#200 sel = 2'b10;
		#300 sel = 2'b11;
		#400 $finish;
	end
endmodule