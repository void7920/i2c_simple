`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 07:06:18 PM
// Design Name: 
// Module Name: i2c_slave_top
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


module i2c_slave_top #(parameter delay = 625)(
    inout SDA, 
    input SCL,
    input reset
    );
    
    wire sda_clk;
    wire [2:0]state;
    wire [7:0]sdata;
    wire [7:0]rdata;
    wire [7:0]mem;
    wire rd;
    
    i2c_slave_doubler #(delay) doubler(.oclk(sda_clk), .iclk(SCL), .reset(reset));
    i2c_slave_fsm sfsm(.state(state), .clk(sda_clk), .reset(reset), .SCL(SCL), .SDA(SDA));
    i2c_slave_sdalogic #(2) ssda(.SDA(SDA), .odata(sdata), .mem_addr(mem),.rd(rd), .clk(sda_clk), .reset(reset), .SCL(SCL), .state(state), .idata(rdata)); 
    i2c_slave_mem ram(.o(rdata), .clk(sda_clk), .addr(mem), .i(sdata), .rd(rd));
endmodule
