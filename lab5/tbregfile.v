module tbregfile;
reg clk,reset,RegWrite;
reg [1:0] ReadReg1,ReadReg2,WriteReg;
reg [31:0] WriteData;
wire [31:0] ReadData1,ReadData2;

RegFile R(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);

always @(clk) #5 clk = ~clk;

initial
begin
	
end