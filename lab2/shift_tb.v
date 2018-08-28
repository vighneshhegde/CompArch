module testbench;
parameter n=4;
reg EN,in,clk;
wire [n-1:0] Q;

shiftreg shreg(EN,in,clk,Q);

initial
	begin
	clk=0;
	end

always
#2 clk = ~clk;


initial
$monitor($time,"EN=%b in= %b Q=%b\n",EN,in,Q); 
initial
	begin 
	$dumpfile("test.vcd");
	$dumpvars();
	in=0;EN=0; 
	#4 in=1;EN=1;
	#4 in=1;EN=0; 
	#4 in=0;EN=1; 
	#5 $finish; 
end
endmodule