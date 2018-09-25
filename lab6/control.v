module ANDarray (RegDst,ALUSrc, MemtoReg, RegWrite,
MemRead, MemWrite,Branch,ALUOp1,ALUOp2,Op);
	input [5:0] Op;
	output RegDst,ALUSrc,MemtoReg, RegWrite, MemRead,
	MemWrite,Branch,ALUOp1,ALUOp2;
	wire Rformat, lw,sw,beq;
	assign Rformat = (~Op[0])& (~Op[1])& (~Op[2])& (~Op[3])&
	(~Op[4])& (~Op[5]);
	assign lw = (Op[0])& (Op[1])& (~Op[2])& (~Op[3])&
	(~Op[4])& (Op[5]);
	assign sw = (Op[0])& (Op[1])& (~Op[2])& (Op[3])&
	(~Op[4])& (Op[5]);
	assign beq = (~Op[0])& (~Op[1])& (Op[2])& (~Op[3])&
	(~Op[4])& (~Op[5]);

	// complete rest of the module
	assign RegDst = Rformat;
	assign ALUSrc = lw|sw;
	assign MemtoReg = lw;
	assign RegWrite = Rformat|lw;
	assign MemRead = lw;
	assign MemWrite = sw;
	assign Branch = beq;
	assign ALUOp1 = Rformat;
	assign ALUOp2 = beq;
endmodule

module ALUcontrol ( ALUop, Func, Operation);
	input [1:0] ALUop;
	input [5:0] Func;
	output [2:0] Operation;
	//reg [2:0] Operation;
	
	assign Operation[2] = ALUop[0] | (ALUop[1] & Func[1]);
	assign Operation[1] = ~ALUop[1] | ~Func[2];
	assign Operation[0] = (Func[3] | Func[0]) & ALUop[1];
endmodule