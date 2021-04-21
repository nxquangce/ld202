module bound_flasher_ctrlfsm(clk, enb, flick, outfsm_state, out);
input        clk;
input        enb;
input        flick;
input  [4:0] outfsm_state;
output       out;

reg init = 1;
reg [5:0] min;
reg [5:0] max;
reg ison_state_reg;
wire ison_next_state;
wire onmax;
wire offmin;
wire flickative;

assign out = ~ison_state_reg;

always @(posedge clk) begin
    if (enb) begin
        ison_state_reg <= ison_next_state;
    end
end

assign onmax  = (~ison_state_reg) & (outfsm_state == (max - 1'b1));
assign offmin =  ison_state_reg & (outfsm_state == (min + 1'b1));
assign flickative =  (~init) & (~ison_state_reg) & flick & ((outfsm_state == 5'h6) | (outfsm_state == 5'hb));

assign ison_next_state = (flickative) ? 1'b1 :
                         (onmax ) ? 1'b1 : 
                         (offmin) ? 1'b0 : ison_state_reg;


always @(posedge clk) begin
    if (init) begin
        max <= 5'h6;
        min <= 5'h0;
        init <= 1'b0;
    end
    else if (flickative) begin 
        if (max == 5'h6) begin
            max <= 5'h6;
            min <= 5'h0;
        end
        else if (max == 4'hb) begin
            max <= 5'hb;
            min <= 5'h0;
        end
        else begin
            max <= 5'h10;
            min <= 5'h0;
        end
    end
    else if (offmin) begin
        if (max == 5'h6) begin
            max <= 5'hb;
            min <= 5'h5;
        end
        else if (max == 4'hb) begin
            max <= 5'h10;
            min <= 5'h0;
        end
        else begin
            max <= 5'h6;
            min <= 5'h0;
        end
    end
end

// reg [2:0] state_reg, next_state_reg;

// always @(posedge clk) begin
//     state_reg <= next_state_reg;
// end

// always @(state_reg) begin
//     case (state_reg)
//         3'b000: next_state_reg = 3'b001;
//         3'b001: begin
//             if (flick) begin
//                 next_state_reg = 3'b010;
//             end
//             else begin
//                 next_state_reg = (max == 4'h5) ? 3'b010 : 3'b011;
//             end
//         end
//         3'b010: next_state_reg = 3'b000;
//         3'b011: next_state_reg = 3'b100;
//         3'b100: begin
//             if (flick) begin
//                 next_state_reg = 3'b010;
//             end
//             else begin
//                 next_state_reg = (max == 4'h5) ? 3'b010 : 3'b011;
//             end
//         end
//         default: begin
//             min = 4'h0;
//             max = 4'h5;
//             next_state_reg = 0;
//         end
//     endcase
// end

endmodule 