`timescale 1ns/1ps
module tb_ram;

    reg clk, reset;
    reg we;
    reg [3:0] waddr, raddr1, raddr2;
    reg [15:0] wdata;
    wire [15:0] rdata1, rdata2;

    // Instantiate the regfile
    regfile uut (
        .clk(clk),
        .reset(reset),
        .we(we),
        .waddr(waddr),
        .wdata(wdata),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    // Clock generation: toggle every 5 ns
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        we = 0;
        waddr = 0;
        wdata = 0;
        raddr1 = 0;
        raddr2 = 0;

        // Create VCD dump file
        $dumpfile("tb_ram.vcd");   // waveform file
        $dumpvars(0, tb_ram);      // dump all variables in this module

        // Reset registers
        #10 reset = 0;

        // Write 16'hABCD to register 3
        #10 we = 1; waddr = 4'd3; wdata = 16'hABCD;
        #10 we = 0;

        // Write 16'h1234 to register 5
        #10 we = 1; waddr = 4'd5; wdata = 16'h1234;
        #10 we = 0;

        // Read from registers 3 and 5
        #10 raddr1 = 4'd3; raddr2 = 4'd5;

        // Read from registers 0 and 7 (expect 0)
        #10 raddr1 = 4'd0; raddr2 = 4'd7;

        // Finish simulation
        #20 $finish;
    end

    // Monitor values in console
    initial begin
        $monitor("Time=%0t | we=%b | waddr=%d | wdata=%h | raddr1=%d rdata1=%h | raddr2=%d rdata2=%h",
                 $time, we, waddr, wdata, raddr1, rdata1, raddr2, rdata2);
    end

endmodule
