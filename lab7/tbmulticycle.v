module tbmc;
wire PCW,PCWC,IorD,MemR,MemW,IRW,M2R,PCSrc1,PCSrc0,
	ALUOp1,ALUOp0,ALUSrcB1,ALUSrcB0,ALUSrcA,RegW,RegD;
reg [5:0] Op;
reg clk, reset;

wire [3:0] S;


multicycle m(PCW,PCWC,IorD,MemR,MemW,IRW,M2R,PCSrc1,PCSrc0,
	ALUOp1,ALUOp0,ALUSrcB1,ALUSrcB0,ALUSrcA,RegW,RegD,Op,clk,reset,S);
	
always @(clk) #5 clk <= ~clk;

initial 
begin
	$monitor($time," S = %b, PCW = %b, PCSrc = %b%b, ALUSrcA = %b, ALUSrcB = %b%b, ALUOp = %b%b",S,PCW,PCSrc1,PCSrc0,ALUSrcA,ALUSrcB1,ALUSrcB0,ALUOp1,ALUOp0);
	clk= 1'b1;
	reset=1'b0;
	Op = 6'b000000; //100011 for lw, 000000 for r, 000100 for beq, 000010 for j
	#10 reset = 1'b1;
	
	#100 $finish;
end
endmodule