module counter(clk);
	input clk;
	reg Q;
	reg jk = 2'b11;
	jkff jk1(jk,clk,Q);
	jkff jk2(jk,clk,Q);
	jkff jk3(jk,clk,Q);
	jkff jk4(jk,clk,Q);