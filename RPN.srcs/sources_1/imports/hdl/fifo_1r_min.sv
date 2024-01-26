// fifo_1r_min is the cheapest type of fifo
// 
// W    : Length of Data
// DW   : Number of bit used in FIFO address
// DEPTH: Available slot in the FIFO
//
// min latency=1 
//
// Maximum FIFO Depth of item = 2**DW-1, wasted 1 for counter.
//
// LUT count:
// 1. 64-bit DW=3 --> 53 LUTs
// 2. 64-bit DW=4 --> 55 LUTs
// 3. 64-bit DW=5 --> 67 LUTs
// 
// DW=4 is optimal

`default_nettype none
module fifo_1r_min
#(
    parameter W = 64,
    parameter DW = 4,
    parameter DEPTH = (2**DW)
)
(
    input wire              clk,
    input wire              rstn,

    // input side
    input wire  [W-1:0]     din,
    input wire              din_vld,
    output logic            din_drop,
    output logic [DW-1:0]   fifo_level,

    // output side
    output logic [W-1:0]    dout,
    output logic            dout_vld,
    input wire              dout_ack
);

(* ram_style="distributed" *)
logic [W-1:0] mem[DEPTH];
logic [DW-1:0] ridx, widx;

logic temp;
logic [W-1:0] temp1;

always_comb begin
    din_drop = (fifo_level==(1<<DW)-1) & din_vld & (dout_ack==0);
    dout = mem[ridx];
end

logic temp2;
logic temp3;
logic temp4;
logic temp5;
logic temp6;
logic temp7;

always_ff @ (posedge clk)
if (rstn==0) begin
    ridx                    <= 0;
    widx                    <= 0;
    fifo_level              <= 0;
    dout_vld                <= 0;

end else begin
        
    fifo_level              <= fifo_level
                               + (din_vld & ~din_drop)
                               - (dout_vld & dout_ack);

    dout_vld                <= (fifo_level >= 2) |
                               ((fifo_level == 1) & (din_vld==1)) |
                               ((fifo_level == 1) & (dout_ack==0)) |
                               ((fifo_level == 0) & (din_vld==1));
    
    
    if (din_vld==1 && din_drop==0) begin
        mem[widx] <= din;
        widx <= widx + 1;
    end
    if (dout_vld==1 && dout_ack==1) begin
        ridx <= ridx + 1;
    end
end

endmodule
`default_nettype wire
