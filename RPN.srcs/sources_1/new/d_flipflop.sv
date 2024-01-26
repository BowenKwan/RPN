module d_flipflop
#(
    parameter W = 32,
    parameter DW = 4,
    parameter DEPTH = (2**DW),
    parameter R=4
)
(
    input wire              clk,
    input wire              rstn,

    input wire [W-1:0]      din[4],
    input wire [3:0]        din_vld,
    
    output logic [W-1:0]    dout[4],
    output logic [3:0]      dout_vld
);
integer i;

always_ff @ (posedge clk) begin
    for(i=0;i<R;i=i+1)begin
        dout[i]<=din[i];
        dout_vld[i]<=din_vld[i];
end
end

endmodule