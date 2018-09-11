module and3(out, i1, i2, i3);
input i1,i2,i3;
output out;
assign out = i1 & i2 & i3;
endmodule

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
input clk,reset,RegWrite;
input [1:0] ReadReg1,ReadReg2,WriteReg;
input [31:0] WriteData;
output ReadData1,ReadData2;
reg ReadData1,ReadData2;
wire a;
wire [3:0] iclock,dop;
wire [31:0] q0,q1,q2,q3;
genvar j;

decoder2_4 d1(dop,WriteReg);

generate for (j=0;j<4;j=j+1) begin: init_reg
		and3 A(iclock[j],clk,RegWrite,dop[j]);

	end
endgenerate

		reg32 R(q0,WriteData,iclock[0],reset);
		reg32 R(q1,WriteData,iclock[1],reset);
		reg32 R(q2,WriteData,iclock[2],reset);
		reg32 R(q3,WriteData,iclock[3],reset);

bit32_mux4to1 m0(ReadData1,ReadReg1,q[0],q[1],q[2],q[3]);
bit32_mux4to1 m1(ReadData2,ReadReg2,q[0],q[1],q[2],q[3]);

endmodule

