module bound_flasher_outfsm(clk, enb, ison, state, out);
input         clk;
input         enb;
input         ison;
output [4:0]  state;
output [15:0] out;

reg [4:0] state_reg, next_state_reg;
reg [15:0] out_reg;

always @(posedge clk) begin
    if (enb) begin
        state_reg <= next_state_reg;
    end
end

always  @(state_reg or ison) begin
    if (ison) begin
        next_state_reg <= state_reg + 1'b1;
    end 
    else begin 
        next_state_reg <= state_reg - 1'b1;
    end
end

always @(state_reg) begin
    case (state_reg)
        5'h0: out_reg = 16'h0000;
        5'h1: out_reg = 16'h0001;
        5'h2: out_reg = 16'h0003;
        5'h3: out_reg = 16'h0007;
        5'h4: out_reg = 16'h000f;
        5'h5: out_reg = 16'h001f;
        5'h6: out_reg = 16'h003f;
        5'h7: out_reg = 16'h007f;
        5'h8: out_reg = 16'h00ff;
        5'h9: out_reg = 16'h01ff;
        5'ha: out_reg = 16'h03ff;
        5'hb: out_reg = 16'h07ff;
        5'hc: out_reg = 16'h0fff;
        5'hd: out_reg = 16'h1fff;
        5'he: out_reg = 16'h3fff;
        5'hf: out_reg = 16'h7fff;
        5'h10: out_reg = 16'hffff;
        default: out_reg = 16'h0000;
    endcase
end

assign out = out_reg;
assign state = state_reg;

endmodule 