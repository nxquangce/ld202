module blink(clk, out);

parameter MAX_CNT = 25'd24999999;

input  clk;
output out;

reg [24:0] counter;
reg 		  out_reg;

always @(posedge clk) begin
	if (counter == MAX_CNT) begin
		counter <= 25'b0;
	end else begin
		counter <= counter + 1'b1;
	end
end

always @(posedge clk) begin
	if (counter == 25'd0) begin
		out_reg <= ~out_reg;
	end
end

assign out = out_reg;

endmodule 