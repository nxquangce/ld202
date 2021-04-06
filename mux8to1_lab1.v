module mux8to1_lab1(out, in, sel);

input  wire [7:0] in;
input  wire [2:0] sel;
output wire       out;

wire [3:0] out_muxl1;
wire [1:0] out_muxl2;

// Level 1 MUXes
mux2to1 mux2to1_l1_0(out_muxl1[0], in[0], in[1], sel[0]);
mux2to1 mux2to1_l1_1(out_muxl1[1], in[2], in[3], sel[0]);
mux2to1 mux2to1_l1_2(out_muxl1[2], in[4], in[5], sel[0]);
mux2to1 mux2to1_l1_3(out_muxl1[3], in[6], in[7], sel[0]);

// Level 2 MUXes
mux2to1 mux2to1_l2_0(out_muxl2[0], out_muxl1[0], out_muxl1[1], sel[1]);
mux2to1 mux2to1_l2_1(out_muxl2[1], out_muxl1[2], out_muxl1[3], sel[1]);

// Level 3 MUXes
mux2to1 mux2to1_l3_0(out, out_muxl2[0], out_muxl2[1], sel[2]);

endmodule 