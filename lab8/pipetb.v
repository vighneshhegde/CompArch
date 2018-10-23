module testpipe;

reg [3:0] a,b;
reg [2:0] ctrl;
reg clk;
wire [3:0] x;
wire co;

alu a1(x,a,b,co,ctrl);
//fadder4 add1(x,co,a,b,1'b1);

always @(clk) #5 clk <= ~clk;

initial
begin
	$monitor($time,"a = %b, b = %b, co=%b ctrl = %b, x = %b",a,b,co,ctrl,x);
	clk = 1'b1;
	a = 4'b1001;
	b = 4'b0000;
	#5 ctrl = 3'b000;
	#5 ctrl = 3'b001;
	//#5 ctrl = 3'b011;
	#20 $finish;
end
endmodule 