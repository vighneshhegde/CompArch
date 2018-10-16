module multicycle(PCW,PCWC,IorD,MemR,MemW,IRW,M2R,PCSrc1,PCSrc0,
	ALUOp1,ALUOp0,ALUSrcB1,ALUSrcB0,ALUSrcA,RegW,RegD,NS3,NS2,NS1,NS0,
	S3,S2,S1,S0,Op5,Op4,Op3,Op2,Op1,Op0);
output PCW,PCWC,IorD,MemR,MemW,IRW,M2R,PCSrc1,PCSrc0,
	ALUOp1,ALUOp0,ALUSrcB1,ALUSrcB0,ALUSrcA,RegW,RegD,NS3,NS2,NS1,NS0;
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

assign PCW = w[7] | w[16];
assign PCWC = w[8];
assign IorD = w[11] | w[13];
assign MemR = w[13]|w[16];
assign MemW = w[13];
assign IRW = w[16];
assign M2R = w[12];
assign PCSrc1 = w[7];
assign PCSrc0 = w[8];
assign ALUOp1 = w[10];
assign ALUOp0 = w[8];
assign ALUSrcB1 = w[14]|w[15];
assign ALUSrcB0 = w[15]|w[16];
assign ALUSrcA = w[8]|w[10]|w[14];
assign RegW = w[9]|w[12];
assign RegD = w[9];
assign NS3 = w[5]|w[6];
assign NS2 = w[3]|w[4]|w[10]|w[13];
assign NS1 = w[0]|w[1]|w[2]|w[4]|w[10];
assign NS0 = w[0]|w[3]|w[6]|w[10]|w[16];
