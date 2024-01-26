module top
#(
    parameter W = 32,
    parameter DW = 2,
    //parameter DEPTH = (2**DW),
    parameter DEPTH = 1,
    parameter N = 5,
    parameter R = 100,
    parameter k = 1
)
(
input wire clk,

input wire rstn

);

logic [W-1:0]                   din[R];
logic [R-1:0]                  din_vld;

wire [R-1:0]                  dout_vld;
wire [W-1:0]                    dout[R];
generate
    if (k==1) begin
    RPN #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N), .R(R)) RPN__stage_top
    (
     .clk                (clk),
     .rstn               (rstn),
     
     .din                (din),
     .din_vld            (din_vld),
     
     .dout               (dout),
     .dout_vld           (dout_vld)
     //.dout_ack           (dout_ack[gi])
    );
    end
    else begin
    RPN_multi #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N), .R(R), .k(k)) RPN_multistage_top
            (
            .clk                (clk),
            .rstn               (rstn1),
            
            .din                (din),
            .din_vld            (din_vld),
            
            .dout               (dout),
            .dout_vld           (dout_vld)
            //.dout_ack           (dout_ack[gi])
            );
    end
endgenerate
endmodule
     