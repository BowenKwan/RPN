//module RPN_partial
//#(
//    parameter W = 32,
//    parameter DW = 2,
//    parameter DEPTH = (2**DW),
//    parameter N = 4,
//    parameter R = 8,
//    parameter START_i = 2,
//    parameter END_i = 6
//)
//(
//    input wire              clk,
//    input wire              rstn,
    
//    input wire [W-1:0]      din[R],
//    input wire [R-1:0]      din_vld,

//    output wire [W-1:0]    dout[START_i:END_i],
//    output wire [R-1:0]    dout_vld

//);


//generate
//    genvar gi;
//    for (gi=START_i; gi<R-END_i; gi=gi+N) 
//        if((gi+N)<R-END_i) begin:GEN_norm
//            seq #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N)) seq_norm
//            (
//            .clk                (clk),
//            .rstn               (rstn),
            
//            .din                (din[gi+N:gi]),
//            .din_vld            (din_vld[gi+N:gi]),
            
//            .dout               (dout[gi+N:gi]),
//            .dout_vld           (dout_vld[gi+N:gi])
//            //.dout_ack           (dout_ack[gi])
//            );
//        end
//        else begin:GEN_norm
//            seq #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N)) seq_norm
//            (
//            .clk                (clk),
//            .rstn               (rstn),
            
//            .din                (din[R-End_i-1:gi]),
//            .din_vld            (din_vld[R-End_i-1:gi]),
            
//            .dout               (dout[R-End_i-1:gi]),
//            .dout_vld           (dout_vld[R-End_i-1:gi])
//            //.dout_ack           (dout_ack[gi])
//            );
//        end
//endgenerate    


//endmodule