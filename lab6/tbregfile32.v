module tbregfile;
reg clk,reset,RegWrite;
reg [4:0] ReadReg1,ReadReg2,WriteReg;
reg [31:0] WriteData;
wire [31:0] ReadData1,ReadData2;
wire out;

RegFile R(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
//and3 A(out, clk, RegWrite, ReadReg1[0]);


always @(clk) #5 clk <= ~clk;

initial
begin
	$monitor($time," ReadReg1 = %b, ReadReg2 = %b, WriteData = %h ,WriteReg = %b ,RegWrite = %b, ReadData1 = %h, ReadData2 = %h",ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
	clk= 1'b1;
	reset=1'b0;
	#10 reset = 1'b1;
	#0 ReadReg1 = 5'b00000;
	#0 ReadReg2 = 5'b00001;
	#20 RegWrite = 1'b1;
	#0 WriteReg = 5'b00000;
	#0 WriteData = 32'hadacabaf;
	
	#20 WriteReg = 5'b00001;
	#0 WriteData = 32'h12345678;
	
	#20 RegWrite = 1'b0;
	#10 ReadReg1 = 5'b00000;
	#10 ReadReg2 = 5'b01000;
	#10 ReadReg2 = 5'b00001;
	#50 $finish;
end
endmodule