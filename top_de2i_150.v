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

////////////////////////////////////////////////////////////////////////////////
//// Edge Detector
//wire edge_out, rst_out_n;
//edge_detect edge0(
//	.clk			(CLOCK_50),
//	.activetype	(2'b10),
//	.trigger		(KEY[0]),
//	.out			(edge_out)
//	);
//
//edge_detect edge1(
//	.clk			(CLOCK_50),
//	.activetype	(2'b00),
//	.trigger		(KEY[1]),
//	.out			(rst_out_n)
//	);
//
//reg [17:0] out;
//always @(posedge CLOCK_50) begin
//	if (!rst_out_n) out <= 0;
//	else if (edge_out) out <= out + 1'b1;
//end
//
//assign LEDR = out;
//
//assign LEDG[0] = edge_out;
//assign LEDG[1] = rst_out_n;
//// Edge Detector
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//// Edge Detector vs No Edge Detector for button
//wire edge_out, rst_out_n;
//
//edge_detect resetedge(
//	.clk        (CLOCK_50),
//	.activetype (2'b00),
//	.trigger    (KEY[0]),
//	.out        (rst_out_n)
//	);
//
//edge_detect edge0(
//	.clk        (CLOCK_50),
//	.activetype (2'b10),
//	.trigger    (KEY[3]),
//	.out        (edge_out)
//	);
//
//reg [3:0] out0, out1, out2;
//always @(posedge CLOCK_50) begin
//	if (!rst_out_n) out0 <= 0;
//	else if (!KEY[1]) out0 <= out0 + 1'b1;
//end
//
//bin27seg bcd27seg0(
//   .com(1'b1),
//   .enb(1'b1),
//   .dat(out0),
//   .out(HEX2));
//
//
//wire clkKey = ~KEY[2];
//wire rstKey = KEY[0];
//always @(posedge clkKey, negedge rstKey) begin
//	if (!rstKey) out1 <= 0;
//	else out1 <= out1 + 1'b1;
//end
//
//bin27seg bcd27seg1(
//   .com(1'b1),
//   .enb(1'b1),
//   .dat(out1),
//   .out(HEX4));
//
//always @(posedge CLOCK_50) begin
//	if (!rst_out_n) out2 <= 0;
//	else if (edge_out) out2 <= out2 + 1'b1;
//end
//
//bin27seg bcd27seg2(
//   .com(1'b1),
//   .enb(1'b1),
//   .dat(out2),
//   .out(HEX6));
//
//assign LEDG[3] = edge_out;
//assign LEDG[2] = clkKey;
//assign LEDG[1] = ~KEY[1];
//assign LEDG[0] = rst_out_n;
//// Edge Detector vs No Edge Detector for button
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//// Blinking LED
// blink blink0(CLOCK_50, LEDR[0]);
//// Blinking LED
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//// Bound flasher
// wire clk_test;
// blink #(
//     .MAX_CNT(25'd6249999)
//     ) 
// blink0 (CLOCK_50, clk_test);

// wire flick;
// // edge_detect edge0(
// // 	.clk			(CLOCK_50),
// // 	.activetype	(2'b10),
// // 	.trigger		(KEY[0]),
// // 	.out			(flick)
// // 	);

// assign flick = ~KEY[0];
// assign LEDG[7] = flick;
// bound_flasher bound_flasher0(clk_test, flick, LEDR[15:0]);
//// Bound flasher
////////////////////////////////////////////////////////////////////////////////


error_test err(CLOCK_50, SW[0], SW[1], LEDR[0], LEDR[1]);


////////////////////////////////////////////////////////////////////////////////
// Unused ports
assign LEDR[17:2] = 0;
//assign LEDG[6:0] = 0;
assign HEX0 = 7'h7f;
assign HEX1 = 7'h7f;
// assign HEX2 = 7'h7f;
assign HEX3 = 7'h7f;
// assign HEX4 = 7'h7f;
assign HEX5 = 7'h7f;
// assign HEX6 = 7'b0;
assign HEX7 = 7'h7f;

endmodule