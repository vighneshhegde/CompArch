module multicycle(PCW,PCWC,IorD,MemR,MemW,IRW,M2R,PCSrc1,PCSrc0,
	ALUOp1,ALUOp2,ALUSrcB0,ALUSrcB1,ALUSrcA,RegW,RegD,NS3,NS2,NS1,NS0,
	S3,S2,S1,S0,Op5,Op4,Op3,Op2,Op1,Op0);
output PCW,PCWC,IorD,MemR,MemW,IRW,M2R,PCSrc1,PCSrc0,
	ALUOp1,ALUOp2,ALUSrcB0,ALUSrcB1,ALUSrcA,RegW,RegD,NS3,NS2,NS1,NS0;
input S3,S2,S1,S0;
input Op5,Op4,Op3,Op2,Op1,Op0;
wire [16:0] w;

assign w[0] = Op5 & ~Op4 & ~Op3 & ~Op2 & Op1 & Op0 & ~S3 & ~S2 & S1 & ~S0;// & NS1 & NS0;
assign w[1] = Op5 & ~Op4 & Op3 & ~Op2 & Op1 & Op0 & ~S3 & ~S2 & ~S1 & S0;// & NS1;
assign w[2] = Op5 & ~Op4 & ~Op3 & ~Op2 & Op1 & Op0 & ~S3 & ~S2 & ~S1 & S0;// & NS1;
assign w[3] = Op5 & ~Op4 & Op3 & ~Op2 & Op1 & Op0 & ~S3 & ~S2 & S1 & ~S0;// & NS0 & NS2;
assign w[4] = ~Op5 & ~Op4 & ~Op3 & ~Op2 & ~Op1 & ~Op0 & ~S3 & ~S2 & ~S1 & S0;// &  NS1 & NS2;
assign w[5] = ~Op5 & ~Op4 & ~Op3 & Op2 & ~Op1 & ~Op0 & ~S3 & ~S2 & ~S1 & S0;// & NS3;
assign w[6] = ~Op5 & ~Op4 & ~Op3 & ~Op2 & Op1 & ~Op0 & ~S3 & ~S2 & ~S1 & S0;// &  NS0 & NS3;
assign w[7] = S3 & ~S2 & ~S1 & S0;
assign w[8] = S3 & ~S2 & ~S1 & ~S0;
assign w[9] = ~S3 & S2 & S1 & S0;
assign w[10] = ~S3 & S2 & S1 & ~S0;
assign w[11] = ~S3 & S2 & ~S1 & S0;
assign w[12] = ~S3 & S2 & ~S1 & ~S0;
assign w[13] = ~S3 & ~S2 & S1 & S0;
assign w[14] = ~S3 & ~S2 & S1 & ~S0;
assign w[15] = ~S3 & ~S2 & ~S1 & S0;
assign w[16] = ~S3 & ~S2 & ~S1 & ~S0;

