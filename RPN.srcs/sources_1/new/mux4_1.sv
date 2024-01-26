module multiplixer_4_1
#(
    parameter W = 32,
    parameter DW = 4,
    parameter DEPTH = (2**DW)
)
(
    input wire              clk,
    input wire              rstn,

    input wire [W-1:0]      din[4],
    input wire [3:0]        din_vld,
    
    input wire [1:0]        selected_id,

    output logic [W-1:0]    dout,
    output logic            dout_vld
);

always_ff @ (posedge clk) begin
    case (selected_id)
        0: begin
            dout            <= din[0];
            dout_vld        <= din_vld[0];
        end
        1: begin
            dout            <= din[1];
            dout_vld        <= din_vld[1];
        end
        2: begin
            dout            <= din[2];
            dout_vld        <= din_vld[2];
        end
        3: begin
            dout            <= din[3];
            dout_vld        <= din_vld[3];
        end
        default: begin
            dout            <= din[0];
            dout_vld        <= din_vld[0];
        end
    endcase
end

endmodule