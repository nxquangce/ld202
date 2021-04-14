module edge_dectect(clk, type, trigger, out);
input 		clk;
input [1:0] type;
input 		trigger;
output		out;

// Type[0] : trigger active level
//  	+ 0: LOW (for falling edge)
//		+ 1: HIGH (for rising edge)
// Type[1] : output active level
//		+ 0: active LOW
//		+ 1:  active HIGH

reg [2:0] pipe_reg;
wire 		 triger_p;
wire 		 out_p;

assign trigger_p = (type[0]) ? trigger : ~trigger;

always @(posedge clk) begin
	pipe_reg[0] <= trigger_p;
	pipe_reg[1] <= pipe_reg[0];
	pipe_reg[2] <= pipe_reg[1];
end

assign out_p = ~pipe_reg[2] & pipe_reg[1];

assign out = (type[1]) ? out_p : ~out_p;

endmodule 