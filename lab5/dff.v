module dff(q, d, clk, reset);
	input d, reset, clk;
	output q;
	reg q;
	always @ (posedge clk)
	begin
		if (!reset) q <= 1'b0;
		else q <= d;
	end
endmodule

module reg32(q, d, clk, reset);
input [31:0] d;
input clk,reset;
output [31:0] q;


genvar j;

generate for (j=0;j<32;j=j+1) begin: reg_loop
	dff d1(q[j],d[j],clk,reset);
	end	
endgenerate
endmodule