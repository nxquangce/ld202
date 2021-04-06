module roman27seg(in, out);

    parameter NUL_CHAR  = 7'b1111111;
    parameter BIT_WIDTH = 3;
    parameter SEG_WIDTH = 7;

    parameter SEG_I     = 7'b1111001;
    parameter SEG_V     = 7'b1000001;
    parameter SEG_X     = 7'b0001001;
    parameter SEG_L     = 7'b1000111;

    input  [BIT_WIDTH - 1 : 0] in;
    output reg [SEG_WIDTH - 1 : 0] out;

    always @(*) begin
        case(in)
        3'b000: out = NUL_CHAR;
        3'b001: out = SEG_I;
        3'b010: out = SEG_V;
        3'b011: out = SEG_X;
        3'b100: out = SEG_L;
        default: out = NUL_CHAR;
        endcase
    end

endmodule 