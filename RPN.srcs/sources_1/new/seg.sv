module seg
#(
    parameter W = 32,
    parameter DW = 2,
    //parameter DEPTH = (2**DW),
    parameter DEPTH = 1,
    parameter N = 10
)
(
    input wire              clk,
    input wire              rstn,
    
    input wire [W-1:0]      din[N],
    input wire [N-1:0]      din_vld,

    input wire [1:0]        sel[4],

    output wire [W-1:0]    dout[N],
    output wire [N-1:0]    dout_vld

);

logic [N-1:0]              dout_ack;
/*
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
*/

generate
    genvar gi;
    for (gi=0; gi<N; gi=gi+1) 
        if(gi==0) begin:GEN_left
            multiplixer_4_1 #(.W(W), .DW(DW), .DEPTH(DEPTH)) mux_group_no_F_l
            (
            .clk                (clk),
            .rstn               (rstn),
            
//            .din                ({dout[gi],dout[gi+1],dout[gi+1],din[gi]}),
//            .din_vld            ({dout_vld[gi],dout_vld[gi+1],dout_vld[gi+1],din_vld[gi]}),
            .din                ({din[gi],dout[gi+1],dout[gi+1],dout[gi]}),
            .din_vld            ({dout_vld[gi],dout_vld[gi+1],dout_vld[gi+1],din_vld[gi]}),
            
            .dout               (dout[gi]),
            .dout_vld           (dout_vld[gi]),
            //.dout_ack           (dout_ack[gi])
            
            .selected_id          (sel[0])
            );
        end
    
        else if(gi<N-1)begin:GEN_FIFO_main 
            if(gi%2)begin: GEN_FIFO_odd
            multiplixer_4_1 #(.W(W), .DW(DW), .DEPTH(DEPTH)) mux_group_no_F_odd
            (
            .clk                (clk),
            .rstn               (rstn),
        
//            .din                ({dout[gi],dout[gi-1],dout[gi+1],din[gi]}),
//            .din_vld            ({dout_vld[gi],dout_vld[gi-1],dout_vld[gi+1],din_vld[gi]}),
            .din                ({din[gi],dout[gi+1],dout[gi-1],dout[gi]}),
            .din_vld            ({dout_vld[gi],dout_vld[gi-1],dout_vld[gi+1],din_vld[gi]}),
            
            .dout               (dout[gi]),
            .dout_vld           (dout_vld[gi]),
            //.dout_ack           (dout_ack[gi])
            
            .selected_id          (sel[1])
            );
            end
            if((gi-1)%2)begin: GEN_FIFO_even
            multiplixer_4_1 #(.W(W), .DW(DW), .DEPTH(DEPTH)) mux_group_no_even
            (
            .clk                (clk),
            .rstn               (rstn),
        
//            .din                ({dout[gi],dout[gi-1],dout[gi+1],din[gi]}),
//            .din_vld            ({dout_vld[gi],dout_vld[gi-1],dout_vld[gi+1],din_vld[gi]}),
            .din                ({din[gi],dout[gi+1],dout[gi-1],dout[gi]}),
            .din_vld            ({dout_vld[gi],dout_vld[gi-1],dout_vld[gi+1],din_vld[gi]}),
                        
            .dout               (dout[gi]),
            .dout_vld           (dout_vld[gi]),
            //.dout_ack           (dout_ack[gi])
            
            .selected_id          (sel[2])
            );
            end
        end
        else if(gi==(N-1)) begin:GEN_right
            multiplixer_4_1 #(.W(W), .DW(DW), .DEPTH(DEPTH)) mux_group_no_F_r
            (
            .clk                (clk),
            .rstn               (rstn),
        
//            .din                ({dout[gi],dout[gi-1],dout[gi-1],din[gi]}),
//            .din_vld            ({dout_vld[gi],dout_vld[gi-1],dout_vld[gi-1],din_vld[gi]}),
            .din                ({din[gi],dout[gi-1],dout[gi-1],dout[gi]}),
            .din_vld            ({dout_vld[gi],dout_vld[gi-1],dout_vld[gi-1],din_vld[gi]}),
                        
            
            .dout               (dout[gi]),
            .dout_vld           (dout_vld[gi]),
            //.dout_ack           (dout_ack[gi])
            
            .selected_id          (sel[3])
            );
        end
endgenerate

endmodule