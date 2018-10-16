//helper modules for single cycle

module instmem(PC,instr);
input PC;
reg [31:0] instr = 8'h00000020;
output [31:0] instr;
endmodule

module signext(in,out);
input [15:0] in;
reg [31:0] out;
genvar j;
for(j=0;j<16;j=j+1) begin: in_loop
	out[j] = in[j];
	end
endgenerate
for(j=16;j<32;j=j+1) begin: in_loop
	out[j] = in[15];
	end
endgenerate

module signext(in,out);
input [15:0] in;
reg [31:0] out;
genvar j;
for(j=0;j<16;j=j+1) begin: in_loop
	out[j] = in[j];
	end
endgenerate
for(j=16;j<32;j=j+1) begin: in_loop
	out[j] = in[15];
	end
endgenerate
