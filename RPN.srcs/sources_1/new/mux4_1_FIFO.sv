module multiplixer_4_1_FIFO
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

wire [W-1:0]                int_dout;
wire                        int_dout_vld;
logic                       dout_ack;

fifo_1r_min #(.W(W), .DW(DW), .DEPTH(DEPTH)) fifo_in_multiplixer_4_1
(
    .clk                (clk),
    .rstn               (rstn),

    .din                (dout),
    .din_vld            (dout_vld),
    .fifo_level         (),
          
    .dout               (int_dout),
    .dout_vld           (int_dout_vld),
    .dout_ack           (dout_ack)
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
            dout            <= int_dout;
            dout_vld        <= int_dout_vld;
        end
        default: begin
            dout            <= din[0];
            dout_vld        <= din_vld[0];
        end
    endcase
end

endmodule