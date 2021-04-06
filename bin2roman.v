module bin2roman(in, out);

parameter BIT_WIDTH = 6;
parameter OUT_NUM   = 6;
parameter OUT_WIDTH = 3;
parameter SYM_I     = 3'b001;
parameter SYM_V     = 3'b010;
parameter SYM_X     = 3'b011;
parameter SYM_L     = 3'b100;
parameter SYM_NULL  = 3'b000;
parameter BASE_NUM  = 7;

parameter DIV_NUM   = 3;

input  [BIT_WIDTH - 1: 0]            in;
output [OUT_WIDTH * OUT_NUM - 1 : 0] out;

wire [BIT_WIDTH     - 1 : 0] baseval [BASE_NUM - 1 : 0];
wire [OUT_WIDTH * 2 - 1 : 0] basesym [BASE_NUM - 1 : 0];
wire [OUT_WIDTH     - 1 : 0] outpos [OUT_NUM - 1 : 0];
wire [BASE_NUM      - 1 : 0] gtbase [DIV_NUM - 1 : 0];
wire [BIT_WIDTH     - 1 : 0] inmod [DIV_NUM - 1 : 0][BASE_NUM - 1 : 0];
wire [BIT_WIDTH     - 1 : 0] indiv [DIV_NUM - 1 : 0][BASE_NUM - 1 : 0];
wire [OUT_WIDTH     - 1 : 0] outposmod [DIV_NUM - 1 : 0][1 : 0];

// Base values
assign baseval[0] = 'd1;
assign baseval[1] = 'd4;
assign baseval[2] = 'd5;
assign baseval[3] = 'd9;
assign baseval[4] = 'd10;
assign baseval[5] = 'd40;
assign baseval[6] = 'd50;

// Base value symbols
assign basesym[0] = {SYM_NULL, SYM_I};
assign basesym[1] = {SYM_V, SYM_I};
assign basesym[2] = {SYM_NULL, SYM_V};
assign basesym[3] = {SYM_X, SYM_I};
assign basesym[4] = {SYM_NULL, SYM_X};
assign basesym[5] = {SYM_L, SYM_X};
assign basesym[6] = {SYM_NULL, SYM_L};

// Input div/mod base
assign indiv[0][0] = in;
assign indiv[1][0] = inmod[0][0];
assign indiv[2][0] = inmod[1][0];

assign inmod[0][0] = in;
assign inmod[1][0] = inmod[0][0];
assign inmod[2][0] = inmod[1][0];

/////////////////// BUG HERE!!!!!
generate
    genvar i;
    for (i = 1; i < BASE_NUM; i = i + 1) begin : moddiv
        assign indiv[0][i] = in / baseval[i];
        assign indiv[1][i] = inmod[0][i] / baseval[i];
        assign indiv[2][i] = inmod[1][i] / baseval[i];

        assign inmod[0][i] = in % baseval[i];
        assign inmod[1][i] = inmod[0][i] % baseval[i];
        assign inmod[2][i] = inmod[1][i] % baseval[i];
    end
endgenerate

// Compare input mod with base values
generate
    genvar i1;
    for (i1 = 0; i1 < BASE_NUM; i1 = i1 + 1) begin : gtbase0
        assign gtbase[0][i1] = in >= baseval[i1];
    end
endgenerate

generate
    genvar i2, j;
    for (i2 = 1; i2 < DIV_NUM; i2 = i2 + 1) begin : gtbasei
        for (j = 0; j < BASE_NUM; j = j + 1) begin : gtbaseij
            assign gtbase[i2][j] = inmod[i2][j] >= baseval[i2];
        end
    end
endgenerate

// Encode gtbase
wire [3:0] gtbase_code [DIV_NUM - 1 : 0];
assign gtbase_code[0] = (gtbase[0][6]) ? 4'd6 :
                        (gtbase[0][5]) ? 4'd5 :
                        (gtbase[0][4]) ? 4'd4 :
                        (gtbase[0][3]) ? 4'd3 :
                        (gtbase[0][2]) ? 4'd2 :
                        (gtbase[0][1]) ? 4'd1 : 
                        (gtbase[0][0]) ? 4'd0 : 4'b1111;

assign gtbase_code[1] = (gtbase[1][6]) ? 4'd6 :
                        (gtbase[1][5]) ? 4'd5 :
                        (gtbase[1][4]) ? 4'd4 :
                        (gtbase[1][3]) ? 4'd3 :
                        (gtbase[1][2]) ? 4'd2 :
                        (gtbase[1][1]) ? 4'd1 :
                        (gtbase[1][0]) ? 4'd0 : 4'b1111;

assign gtbase_code[2] = (gtbase[2][6]) ? 4'd6 :
                        (gtbase[2][5]) ? 4'd5 :
                        (gtbase[2][4]) ? 4'd4 :
                        (gtbase[2][3]) ? 4'd3 :
                        (gtbase[2][2]) ? 4'd2 :
                        (gtbase[2][1]) ? 4'd1 :
                        (gtbase[2][0]) ? 4'd0 : 4'b1111;

// Cal temp output
assign outposmod[0][0] = (gtbase_code[0] != 4'b1111) ? basesym[gtbase_code[0]][OUT_WIDTH - 1 : 0] : SYM_NULL;
assign outposmod[0][1] = (gtbase_code[0] != 4'b1111) ? basesym[gtbase_code[0]][OUT_WIDTH * 2 - 1 : OUT_WIDTH] : SYM_NULL;

assign outposmod[1][0] = (gtbase_code[1] != 4'b1111) ? basesym[gtbase_code[1]][OUT_WIDTH - 1 : 0] : SYM_NULL;
assign outposmod[1][1] = (gtbase_code[1] != 4'b1111) ? basesym[gtbase_code[1]][OUT_WIDTH * 2 - 1 : OUT_WIDTH] : SYM_NULL;

assign outposmod[2][0] = (gtbase_code[2] != 4'b1111) ? basesym[gtbase_code[2]][OUT_WIDTH - 1 : 0] : SYM_NULL;
assign outposmod[2][1] = (gtbase_code[2] != 4'b1111) ? basesym[gtbase_code[2]][OUT_WIDTH * 2 - 1 : OUT_WIDTH] : SYM_NULL;

// Multiple temp output
wire [OUT_WIDTH * 2 * 3 - 1 : 0] outposmod_mul [DIV_NUM - 1 : 0];
assign outposmod_mul[0] = (indiv[0][gtbase_code[0]] == 'd1) ? {{(OUT_WIDTH * 2 * 2){1'b0}}, {outposmod[0][1], outposmod[0][0]}} : 
                          (indiv[0][gtbase_code[0]] == 'd2) ? {{(OUT_WIDTH * 2){1'b0}}, {2{outposmod[0][1], outposmod[0][0]}}} : 
                                                              {{3{outposmod[0][1]}}, outposmod[0][0]};

assign outposmod_mul[1] = (indiv[1][gtbase_code[1]] == 'd1) ? {{(OUT_WIDTH * 2 * 2){1'b0}}, {outposmod[1][1], outposmod[1][0]}} : 
                          (indiv[1][gtbase_code[1]] == 'd2) ? {{(OUT_WIDTH * 2){1'b0}}, {2{outposmod[1][1], outposmod[1][0]}}} : 
                                                              {{3{outposmod[1][1]}}, outposmod[1][0]};

assign outposmod_mul[2] = (indiv[2][gtbase_code[2]] == 'd1) ? {{(OUT_WIDTH * 2 * 2){1'b0}}, {outposmod[2][1], outposmod[2][0]}} : 
                          (indiv[2][gtbase_code[2]] == 'd2) ? {{(OUT_WIDTH * 2){1'b0}}, {2{outposmod[2][1], outposmod[2][0]}}} : 
                                                              {{3{outposmod[2][1]}}, outposmod[2][0]};

// Output
assign outpos[0] = outposmod[0][0];

assign outpos[1] = (outposmod[0][1] != SYM_NULL) ? outposmod[0][1] :
                   (indiv[0][gtbase_code[0]] > 'd1) ? outposmod[0][0] : outposmod[1][0];

assign outpos[2] = (indiv[0][gtbase_code[0]] > 'd2) ? outposmod[0][0] :
                   (indiv[0][gtbase_code[0]] > 'd1) ? outposmod[1][0] :
                   (outposmod[1][1] != SYM_NULL) ? outposmod[1][1] :
                   (indiv[1][gtbase_code[1]] > 'd1) ? outposmod[1][0] : outposmod[2][0];

assign outpos[3] = (indiv[0][gtbase_code[0]] > 'd2) ? outposmod[1][0] :
                   (indiv[0][gtbase_code[0]] > 'd1) ? (outposmod[1][1] != SYM_NULL) ? outposmod[1][1] : 
                                                      (indiv[1][gtbase_code[1]] > 1) ? outposmod[1][0] : outposmod[2][0] :
                   (indiv[1][gtbase_code[1]] > 'd2) ? outposmod[1][0] :
                   (indiv[1][gtbase_code[1]] > 'd1) ? (outposmod[2][1] != SYM_NULL) ? outposmod[2][1] : outposmod[2][0] :
                   (outposmod[2][1] != SYM_NULL) ? outposmod[2][1] : outposmod[2][0];

assign outpos[4] = (indiv[0][gtbase_code[0]] > 'd2) ? (outposmod[1][1] != SYM_NULL) ? outposmod[1][1] : 
                                                      (indiv[1][gtbase_code[1]] > 'd1) ? outposmod[1][0] : outposmod[2][0] :
                   (indiv[0][gtbase_code[0]] > 'd1) ? (indiv[1][gtbase_code[1]] > 'd2) ? outposmod[1][0] :
                                                      (indiv[1][gtbase_code[1]] > 'd1) ? outposmod[2][0] : outposmod[2][1] :
                                                      outposmod[2][0];

assign outpos[5] = (indiv[0][gtbase_code[0]] > 'd2) ? (indiv[1][gtbase_code[1]] > 'd2) ? outposmod[1][0] : SYM_NULL :
                   (indiv[0][gtbase_code[0]] > 'd1) ? (indiv[1][gtbase_code[1]] > 'd2) ? outposmod[2][0] :
                                                      (indiv[1][gtbase_code[1]] > 'd1) ? (outposmod[2][1] != SYM_NULL) ? outposmod[2][1] : 
                                                                                         (indiv[1][gtbase_code[1]] > 'd1) ? outposmod[2][0] :
                                                                                                                            SYM_NULL :
                                                      (outposmod[1][1] != SYM_NULL) ? (outposmod[2][1] != SYM_NULL) ? outpos[2][1] : outpos[2][0] :
                                                                                      (indiv[2][gtbase_code[2]] > 'd2) ? outpos[2][0] : SYM_NULL :
                                                      SYM_NULL;


assign out = {outpos[0], outpos[1], outpos[2], outpos[3], outpos[4], outpos[5]};

endmodule 