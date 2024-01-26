module cas_multi
#(
    parameter W = 32,
    parameter DW = 2,
    parameter DEPTH = (2**DW),
    parameter N = 4,
    parameter R = 4,
    parameter k = 3
)
(
    input wire              clk,
    input wire              rstn,
    
    input wire [W-1:0]      din[R],
    input wire [R-1:0]      din_vld,

    output wire [W-1:0]    dout[R],
    output wire [R-1:0]    dout_vld

);

wire [W-1:0]    stage_out[k][R];
wire [R-1:0]    stage_vld[k];

logic [W-1:0]      din1[R];
logic [R-1:0]      din1_vld;


integer i;
initial begin
    for(i=0;i<R;i=i+1)begin
        din1[i]<=i;
        din1_vld[i]<=1;
    end
end

always_ff @ (posedge clk) begin
    din1[0]<=din1[0]+1;
    din1[1]<=din1[1]+1;
    din1[2]<=din1[2]+1;
    din1[3]<=din1[3]+1;
    
end

generate
    genvar gi;
    for (gi=0; gi<k; gi=gi+1)begin:GEN_RPN_stage
            if (gi==0) begin
            d_flipflop #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N)) RPN_stage_1
            (
            .clk                (clk),
            .rstn               (rstn),
            
            .din                (din1),
            .din_vld            (din1_vld),
            
            .dout               (stage_out[gi]),
            .dout_vld           (stage_vld[gi])
            //.dout_ack           (dout_ack[gi])
            );
            end
            else if (gi==k-1)begin
            d_flipflop #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N)) RPN_stage_last
            (
            .clk                (clk),
            .rstn               (rstn),
            
            .din                (stage_out[gi-1]),
            .din_vld            (stage_vld[gi-1]),
            
            .dout               (dout),
            .dout_vld           (dout_vld)
            //.dout_ack           (dout_ack[gi])
            );
            end
            else begin
            d_flipflop #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N)) RPN_stage
            (
            .clk                (clk),
            .rstn               (rstn),
            
            .din                (stage_out[gi-1]),
            .din_vld            (stage_vld[gi-1]),
            
            .dout               (stage_out[gi]),
            .dout_vld           (stage_vld[gi])
            //.dout_ack           (dout_ack[gi])
            );
            end
        end
endgenerate    



endmodule