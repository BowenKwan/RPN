module RPN_multi
#(
    parameter W = 32,
    parameter DW = 2,
    //parameter DEPTH = (2**DW),
    parameter DEPTH = 1,
    parameter N = 5 ,
    parameter R = 100,
    parameter k = 100
)
(
    input wire              clk,
    input wire              rstn,
    
    input wire [W-1:0]      din[R],
    input wire [R-1:0]      din_vld,

    output wire [W-1:0]    dout[R],
    output wire [R-1:0]    dout_vld

);

wire [W-1:0]    stage_out[k-1][R];
wire [R-1:0]    stage_vld[k-1];
//logic [W-1:0]      din1[R];
//logic [R-1:0]      din1_vld;



logic rstn1=1;
/*
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
    if ((din1[0]==0)&& rstn1==1)begin
        rstn1<=0;
    end
end
*/

generate
    genvar gi;
    for (gi=0; gi<k; gi=gi+1)  begin:GEN_RPN_stage
            if (gi==0) begin
            RPN #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N), .R(R)) RPN_stage_1
            (
            .clk                (clk),
            .rstn               (rstn1),
            
            .din                (din),
            .din_vld            (din_vld),
            
            .dout               (stage_out[gi]),
            .dout_vld           (stage_vld[gi])
            //.dout_ack           (dout_ack[gi])
            );
            end
            else if (gi==k-1)begin
            RPN #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N), .R(R)) RPN_stage_last
            (
            .clk                (clk),
            .rstn               (rstn1),
            
            .din                (stage_out[gi-1]),
            .din_vld            (stage_vld[gi-1]),
            
            .dout               (dout),
            .dout_vld           (dout_vld)
            //.dout_ack           (dout_ack[gi])
            );
            end

            else begin
            RPN #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N), .R(R)) RPN_stage
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