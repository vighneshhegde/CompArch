module jkff(jk,clk,Q);
	input [1:0] jk;
	input clk;
	output Q;
	reg Q;
	
	always @ (posedge clk)
	begin
		case(jk)
			2'b00:begin
			end
			
			2'b01:begin
			Q <=1'b0;
			end
			
			2'b10:begin
			Q <=1'b1;
			end
			
			2'b11: begin
			Q <= ~Q;
			end
			default:begin
			Q <=1'b0;
			end
		endcase
	end
endmodule