module bin2roman_tb;

reg [5:0] in;
wire [17:0] out;

//uut
bin2roman uut(in, out);

initial begin
	in <= 6'd7;
	#5 $stop;
end

endmodule