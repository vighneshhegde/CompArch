module shiftreg(EN, in, clk, Q);
parameter n = 4;
input EN,in,clk;
output [n-1:0] Q;
reg [n-1:0] Q;

initial
	Q = 4'd0;
	always @(posedge clk)
	begin
	if(EN)
	Q = {in,Q[n-1:1]};
end


endmodule