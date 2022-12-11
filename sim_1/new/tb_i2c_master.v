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
    i2c_slave_top #(10000) uut2(.SDA(SDA), .SCL(SCL), .reset(rst));
    
    always#(10) clk = ~clk;
    
    initial begin
        clk = 1'b0;
        rst  = 1'b1;
        start = 1'b0;
        addr = 7'b0000010;
        data = mem_addr;
        rw = 1'b0;
    end
    
    initial begin
        #40000 rst = 1'b0;
        #50000 start = 1'b1;
        #50000 start = 1'b0;
        #500000 data = $urandom%(2**8);
        #800000 data = mem_addr;
        #000000 start = 1'b1;
                       rw = 1'b1;
    end
endmodule
