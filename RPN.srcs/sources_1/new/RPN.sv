module RPN
#(
    parameter W = 32,
    parameter DW = 2,
    //parameter DEPTH = (2**DW),
    parameter DEPTH = 1,
    parameter N = 10,
    parameter R = 100
)
(
    input wire              clk,
    input wire              rstn,
    
    input wire [W-1:0]      din[R],
    input wire [R-1:0]      din_vld,

    output wire [W-1:0]    dout[R],
    output wire [R-1:0]    dout_vld

);

logic [1:0]                sel[4]; 

logic [DW-1:0]             cnt;

logic                      init;
 
always_ff @ (posedge clk) begin
    if (rstn==1) begin
        sel[0] <= 0;
        sel[1] <= 0;
        sel[2] <= 0;
        sel[3] <= 0;
        cnt    <= 0;
        init   <= 0;
        end
    else if(din_vld)begin 
        if(cnt==DEPTH-1)begin
            if(init==0) begin
                init   <=1;
                cnt    <= 0;
                sel[0] <= 2'b01;
                sel[1] <= 2'b10;
                sel[2] <= 2'b01;
                    if (N%2)
                        sel[3] <= 2'b11;
                    else
                        sel[3] <= 2'b10;
            end 
            else begin
                cnt    <= 0;
                sel[0][1] <= ~sel[0][1];
                sel[1] <= ~sel[1];
                sel[2] <= ~sel[2];
                sel[3][0] <= ~sel[3][0];
            end
        end
        else begin
            cnt <=cnt+1;
        end                
    end
end

generate
    genvar gi;
    for (gi=0; gi<R; gi=gi+N) 
        if((gi+N)<R) begin:GEN_norm
            seg #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(N)) seq_norm
            (
            .clk                (clk),
            .rstn               (rstn),
            
            .din                (din[gi:gi+N-1]),
            .din_vld            (din_vld[gi+N-1:gi]),
            .sel                (sel),
            .dout               (dout[gi:gi+N-1]),
            .dout_vld           (dout_vld[gi+N-1:gi])
            //.dout_ack           (dout_ack[gi])
            );
        end
        else begin:GEN_norm
            seg #(.W(W), .DW(DW), .DEPTH(DEPTH), .N(R-gi)) seq_last
            (
            .clk                (clk),
            .rstn               (rstn),
            
            .din                (din[gi:R-1]),
            .din_vld            (din_vld[R-1:gi]),
            .sel                (sel),
            .dout               (dout[gi:R-1]),
            .dout_vld           (dout_vld[R-1:gi])
            //.dout_ack           (dout_ack[gi])
            );
        end
endgenerate    



endmodule