module bin2bcd(in, out1, out0);

parameter BIT_WIDTH = 8;
parameter OUT_WIDTH = 4;

input [BIT_WIDTH - 1 : 0] in;
output [OUT_WIDTH - 1 : 0] out1, out0;

assign out1 = in / 'd10;

assign out0 = in % 'd10;

endmodule 