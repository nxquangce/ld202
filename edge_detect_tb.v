module edge_detect_tb;

reg clk, in;
wire out;

edge_detect uut(
	.clk		(clk),
	.type		(2'b10),
	.trigger	(in),
	.out		(out)
);

initial begin
	clk <= 1'b0;
	forever #5 clk = ~clk;
end

initial begin
	in <= 1'b1;
	#24 in <= 1'b0;
	#5 in <= 1'b1;
	#20 $stop;
end

endmodule 