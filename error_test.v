module error_test(clk, in, sel, out_ff, out_latch);
input  clk;
input  in;
input  sel;
output out_ff;
output out_latch;

reg latch;
reg ff;

always @(*) begin
	if (sel) latch = in;
end

always @(posedge clk) begin
	ff <= latch;
end

assign out_ff = ff;
assign out_latch = latch;

endmodule 