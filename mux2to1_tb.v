`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module mux2to1_tb;

reg in0, in1, select;
wire out;

// DUT
mux2to1 dut(out, in0, in1, select);

initial begin
	$monitor("%t : Input_0: %b Input_1: %b Select: %b  -- Output: %b", $time, in0, in1, select, out); 
end

initial begin
	in0 <= 1'b1;
	in1 <= 1'b0;
	select <= 1'b0;
	
	#5 // Wait for 5 units of time
	select <= 1'b1;
	
	#5
	in1 <= 1'b1;
	
	#5
	in1 <= 1'b0;
	
	#5
	in0 <= 1'b0;
	
	#5
	select <= 1'b0;
	
	#5;
	//	$stop;   // end of simulation. Usually be used when we have clock signal in the design.
end

endmodule 