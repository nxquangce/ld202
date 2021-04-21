module bin27seg (com, enb, dat, out);

parameter  NUL_CHAR = 7'b1111111;

localparam BIT_WIDTH = 4;
localparam SEG_WIDTH = 7;

input                      com;
input                      enb;
input  [BIT_WIDTH - 1 : 0] dat;
output [SEG_WIDTH - 1 : 0] out;

reg [SEG_WIDTH - 1 : 0] seg7;

always @(dat) begin
    case (dat)
    4'd0: seg7 = 7'b1000000;
    4'd1: seg7 = 7'b1111001;
    4'd2: seg7 = 7'b0100100;
    4'd3: seg7 = 7'b0110000;
    4'd4: seg7 = 7'b0011001;
    4'd5: seg7 = 7'b0010010;
    4'd6: seg7 = 7'b0000010;
    4'd7: seg7 = 7'b1111000;
    4'd8: seg7 = 7'b0000000;
    4'd9: seg7 = 7'b0010000;
    4'd10: seg7 = 7'b0001000;
    4'd11: seg7 = 7'b0000011;
    4'd12: seg7 = 7'b1000110;
    4'd13: seg7 = 7'b0100001;
    4'd14: seg7 = 7'b0000110;
    4'd15: seg7 = 7'b0001110;
    default: seg7 = NUL_CHAR;
    endcase
end

assign out = (enb) ? (com) ? seg7 : ~seg7 : NUL_CHAR;

endmodule 