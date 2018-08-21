module testbench;
	reg [7:0] x;
	reg [7:0] y;
	wire [7:0] s;
	wire c;
	fadder8 f1(s,c,x,y);
	initial
		begin
		$dumpfile("test.vcd");
		$dumpvars();
		$monitor(,$time,"x=%b,y=%b | s=%b,c=%b",x,y,s,c);
		
		#0 x=8'b01010101;y=8'b10101010;
		#4 x=8'b01010111;y=8'b11101010;
		#4 x=8'b01010101;y=8'b11111111;
		#4 x=8'b10101010;y=8'b10101010;

		end

endmodule