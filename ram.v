module regfile (
    input clk, reset,
    input we,                // write enable
    input [3:0] waddr,       // write address
    input [15:0] wdata,
    input [3:0] raddr1, raddr2,
    output [15:0] rdata1, rdata2
);
    reg [15:0] regs [0:15];
    integer i;

    always @(posedge clk) begin
        if (reset)
            for (i=0; i<16; i=i+1) regs[i] <= 16'h0;
        else if (we)
            regs[waddr] <= wdata;
    end

    assign rdata1 = regs[raddr1];
    assign rdata2 = regs[raddr2];
endmodule
