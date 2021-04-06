module error_test(data, sel, out);
input  [7:0] data;
input  [1:0] sel;
output [7:0] out;

assign out = data << sel;

endmodule 