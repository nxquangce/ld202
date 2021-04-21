module bound_flasher(clk, flick, out);
input  		  clk;
input  		  flick;
output [15:0] out;

reg        enb = 0;
wire       ison;
wire [4:0] outstate;

always @(posedge clk) begin
    if (!enb) begin
        if (flick) enb <= 1'b1;
    end
end

bound_flasher_outfsm outfsm (
    .clk    (clk),
    .enb    (enb),
    .ison   (ison),
    .state  (outstate),
    .out    (out)
    );

bound_flasher_ctrlfsm ctrlfsm (
    .clk            (clk),
    .enb            (enb),
    .flick          (flick),
    .outfsm_state   (outstate),
    .out            (ison)
    );

endmodule 