module tbALU;
reg Carryin;
reg [1:0] Operation;
reg [31:0] a,b;
wire [31:0] Result;
wire CarryOut;
//ALU (a,b,Binvert,Carryin,Operation,Result,CarryOut);
alu32 a1(Result,CarryOut,a,b,Carryin,Operation);
initial
begin
$monitor($time,"Result=%h,CarryOut=%b,a=%h,b=%h,Carryin=%b,Operation=%b",Result,CarryOut,a,b,Carryin,Operation);
a=32'h21010101;
b=32'h21010101;
Operation=2'b00;//AND
//Binvert=1'b0;
Carryin=1'b0; //must perform AND resulting in zero
#100 Operation=2'b01; //OR
#100 Operation=2'b10; //ADD
#100 Carryin=1'b1;//SUB
#200 $finish;
end
endmodule
