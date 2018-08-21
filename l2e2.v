module fulladder(s,co,a,b,ci);
	input a,b,ci;
	output reg s,co;
	
	always@(a or b or ci)
		if ((a==1 and b==1 and ci==1) or (a==1 and b==0 and c==0) or (a==0 and b==1 and ci==0) or (a==0 and b==0 and c==1)) s=1;
		else s=0;
		
		if ((a==1 and b==1)or(a==1 and b==0 and ci==1) or (a==0 and b==1 and c==1))c = 1;
		else c=0;
		
endmodule

module testbench
	reg a,b,ci;
	wire s,co;
	fulladder f1(s,co,a,b,ci);
	
	initial
		begin
		$dumpfile("test.vcd");
		$dumpvars();
		$monitor(,$time,"a=%b,b=%b,ci=%b | s=%b,co=%b",a,b,ci,s,co);
		
		#0 a=1'b0;b=1'b1;ci=1'b0;
		#4 a=1'b0;b=1'b1;ci=1'b1;
		#4 a=1'b1;b=1'b1;ci=1'b1;
		#4 a=1'b1;b=1'b1;ci=1'b0;

		end

endmodule