`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 01:54:29 PM
// Design Name: 
// Module Name: tb_i2c_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_i2c_master();
    reg clk;
    reg rst;
    reg start;
    reg [6:0]addr;
    reg [7:0]data;
    reg rw;
    reg [7:0]mem_addr = 8'b00101111;
    
    wire SCL;
    wire SDA;
    
    i2c_master_top uut1(.SDA(SDA), .SCL(SCL), .clk(clk), .reset(rst), .start(start), .addr(addr), .data(data), .rw(rw));
    i2c_slave_top uut2(.SDA(SDA), .SCL(SCL), .clk(clk), .reset(rst));
    
    always#(62.5) clk = ~clk;
    
    initial begin
        $dumpfile("i2c.vcd");
        $dumpvars(1, uut1);
        $dumpvars(1, uut2);
    end

    initial begin
        clk = 1'b0;
        rst  = 1'b1;
        start = 1'b0;
        addr = 7'b0000010;
        data = mem_addr;
        rw = 1'b0;
    end
    
    initial begin
        #1000 rst = 1'b0;
        #1000 start = 1'b1;
        #1000 start = 1'b0;
        #40000 data = 8'b11110000;
        #40000 data = mem_addr;
        #00000 start = 1'b1;
                       rw = 1'b1;
        #75000 $finish;               
    end
endmodule
