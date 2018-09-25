module tbcontrol;
reg [1:0] ao;
reg [5:0] func;
wire [2:0] oper;

ALUcontrol a1(ao, func, oper);

initial
begin
	$monitor($time, "ao = %b, func = %b, oper = %b",ao,func,oper);
	ao = 2'b00;
	#10 ao = 2'b01;
	#10 ao = 2'b10;
	func = 6'b000000;
	#10 func = 6'b000010;
	#10 func = 6'b000100;
	#10 func = 6'b000101;
	#10 func = 6'b001010;
	#100 $finish;
end
endmodule