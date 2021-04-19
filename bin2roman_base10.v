module bin2roman_base10(in, out);

parameter BIT_WIDTH = 6;
parameter OUT_NUM   = 6;
parameter OUT_WIDTH = 3;
parameter SYM_I     = 3'b001;
parameter SYM_V     = 3'b010;
parameter SYM_X     = 3'b011;
parameter SYM_L     = 3'b100;
parameter SYM_NULL  = 3'b000;
parameter BASE_NUM  = 16;

parameter DIV_NUM   = 3;

input  [BIT_WIDTH - 1: 0]            in;
output [OUT_WIDTH * OUT_NUM - 1 : 0] out;

wire [BIT_WIDTH     - 1 : 0] baseval [BASE_NUM - 1 : 0];
wire [OUT_WIDTH * 4 - 1 : 0] basesym [BASE_NUM - 1 : 0];
wire [2:0]                   baseshift [BASE_NUM - 1 : 0];
wire [BIT_WIDTH     - 1 : 0] digit1, digit0;
wire [OUT_WIDTH     - 1 : 0] outpos [OUT_NUM - 1 : 0];

// Base values
assign baseval[0] = 'd0;
assign baseval[1] = 'd1;
assign baseval[2] = 'd2;
assign baseval[3] = 'd3;
assign baseval[4] = 'd4;
assign baseval[5] = 'd5;
assign baseval[6] = 'd6;
assign baseval[7] = 'd7;
assign baseval[8] = 'd8;
assign baseval[9] = 'd9;
assign baseval[10] = 'd10;
assign baseval[11] = 'd20;
assign baseval[12] = 'd30;
assign baseval[13] = 'd40;
assign baseval[14] = 'd50;
assign baseval[15] = 'd60;

// Base value symbols
assign basesym[0] = {SYM_NULL, SYM_NULL, SYM_NULL, SYM_NULL};
assign basesym[1] = {SYM_NULL, SYM_NULL, SYM_NULL, SYM_I};
assign basesym[2] = {SYM_NULL, SYM_NULL, SYM_I, SYM_I};
assign basesym[3] = {SYM_NULL, SYM_I, SYM_I, SYM_I};
assign basesym[4] = {SYM_NULL, SYM_NULL, SYM_I, SYM_V};
assign basesym[5] = {SYM_NULL, SYM_NULL, SYM_NULL, SYM_V};
assign basesym[6] = {SYM_NULL, SYM_NULL, SYM_V, SYM_I};
assign basesym[7] = {SYM_NULL, SYM_V, SYM_I, SYM_I};
assign basesym[8] = {SYM_V, SYM_I, SYM_I, SYM_I};
assign basesym[9] = {SYM_NULL, SYM_NULL, SYM_I, SYM_X};
assign basesym[10] = {SYM_NULL, SYM_NULL, SYM_NULL, SYM_X};
assign basesym[11] = {SYM_NULL, SYM_NULL, SYM_X, SYM_X};
assign basesym[12] = {SYM_NULL, SYM_X, SYM_X, SYM_X};
assign basesym[13] = {SYM_NULL, SYM_NULL, SYM_X, SYM_L};
assign basesym[14] = {SYM_NULL, SYM_NULL, SYM_NULL, SYM_L};
assign basesym[15] = {SYM_NULL, SYM_NULL, SYM_L, SYM_X};

// Base shift
assign baseshift[0] = 3'd4;
assign baseshift[1] = 3'd3;
assign baseshift[2] = 3'd2;
assign baseshift[3] = 3'd1;
assign baseshift[4] = 3'd2;
assign baseshift[5] = 3'd3;
assign baseshift[6] = 3'd2;
assign baseshift[7] = 3'd1;
assign baseshift[8] = 3'd0;
assign baseshift[9] = 3'd2;
assign baseshift[10] = 3'd3;
assign baseshift[11] = 3'd2;
assign baseshift[12] = 3'd1;
assign baseshift[13] = 3'd2;
assign baseshift[14] = 3'd3;
assign baseshift[15] = 3'd2;

assign digit1 = in / 'd10;
assign digit0 = in % 'd10;

assign out = (digit1 != 0) ? (digit0 != 0) ? {basesym[digit1 + 'd9], 
                                             (basesym[digit0] <<  (baseshift[digit0] * OUT_WIDTH))} 
                                             >> (baseshift[digit0] * OUT_WIDTH) : 
                                             basesym[digit1 + 'd9] :
                             basesym[digit0];

endmodule 