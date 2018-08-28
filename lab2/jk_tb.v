module testbench;
	reg [1:0] jk;
	reg clk;
	wire Q;
	
	jkff jk1(jk,clk,Q);
	
	initial
		begin
			clk=0;
			jk = 2'b00;
		end

	always
	#1 clk = ~clk;
	
	always @(Q)
	begin
		$display($time," j=%b, k=%b, Q=%b\n", jk[1], jk[0], Q);
	end
	
	initial 
		begin
			#2 jk = 2'b10;
			#4 jk = 2'b01;
			#4 jk[1] = 1'b1;
			
			#12 $finish;
		end
endmodule