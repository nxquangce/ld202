module top_de2i_150 (
    CLOCK_50,
    CLOCK2_50,
    CLOCK3_50,
    SW,
    KEY,
    LEDR,
    LEDG,
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    HEX6,
    HEX7
    );

input         CLOCK_50, CLOCK2_50, CLOCK3_50;
input  [17:0] SW;
input  [03:0] KEY;
output [17:0] LEDR;
output [08:0] LEDG;
output [06:0] HEX0;
output [06:0] HEX1;
output [06:0] HEX2;
output [06:0] HEX3;
output [06:0] HEX4;
output [06:0] HEX5;
output [06:0] HEX6;
output [06:0] HEX7;

// Design parameters

////////////////////////////////////////////////////////////////////////////////
//// Roman Encoder
//parameter BIT_WIDTH = 6;
//parameter OUT_NUM   = 6;
//parameter OUT_WIDTH = 3;
//// End Roman Encoder
////////////////////////////////////////////////////////////////////////////////

// Core module intantiation

////////////////////////////////////////////////////////////////////////////////
//// Roman Encoder
//wire [BIT_WIDTH - 1 : 0]           in;
//wire [3:0]                         bcd1, bcd0;
//wire [OUT_WIDTH * OUT_NUM - 1 : 0] roman;
//
//assign in = SW[BIT_WIDTH - 1 : 0];
//
//bin2roman_base10 core0(
//    .in(in),
//    .out(roman)
//);
//
//roman27seg seg5(roman[OUT_WIDTH * (OUT_NUM - 0) - 1 : OUT_WIDTH * (OUT_NUM - 1)], HEX5);
//roman27seg seg4(roman[OUT_WIDTH * (OUT_NUM - 1) - 1 : OUT_WIDTH * (OUT_NUM - 2)], HEX4);
//roman27seg seg3(roman[OUT_WIDTH * (OUT_NUM - 2) - 1 : OUT_WIDTH * (OUT_NUM - 3)], HEX3);
//roman27seg seg2(roman[OUT_WIDTH * (OUT_NUM - 3) - 1 : OUT_WIDTH * (OUT_NUM - 4)], HEX2);
//roman27seg seg1(roman[OUT_WIDTH * (OUT_NUM - 4) - 1 : OUT_WIDTH * (OUT_NUM - 5)], HEX1);
//roman27seg seg0(roman[OUT_WIDTH * (OUT_NUM - 5) - 1 : OUT_WIDTH * (OUT_NUM - 6)], HEX0);
//
//assign LEDG = in;
//assign LEDR[OUT_WIDTH * OUT_NUM - 1 : 0] = roman;
//
//bin2bcd bin2bcd_0(
//    .in({2'b0, in}),
//    .out1(bcd1),
//    .out0(bcd0)
//    );
//
//bin27seg bcd27seg0(
//    .com(1'b1),
//    .enb(1'b1),
//    .dat(bcd0),
//    .out(HEX6));
//
//bin27seg bcd27seg1(
//    .com(1'b1),
//    .enb(1'b1),
//    .dat(bcd1),
//    .out(HEX7));
//
//// End Roman Encoder
////////////////////////////////////////////////////////////////////////////////

wire edge_out, rst_out_n;
edge_detect edge0(
	.clk		(CLOCK_50),
	.type		(2'b10),
	.trigger	(KEY[0]),
	.out		(edge_out)
	);

edge_detect edge1(
	.clk		(CLOCK_50),
	.type		(2'b00),
	.trigger	(KEY[1]),
	.out		(rst_out_n)
	);

reg [17:0] out;
always @(posedge CLOCK_50) begin
	if (!rst_out_n) out <= 0;
	else if (edge_out) out <= out + 1'b1;
end

assign LEDR = out;

assign LEDG[0] = edge_out;
assign LEDG[1] = rst_out_n;

// Unused ports
// assign HEX6 = 7'b0;
// assign HEX6 = 7'b0;
// assign HEX6 = 7'b0;

endmodule