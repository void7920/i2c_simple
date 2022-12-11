`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 01:48:38 PM
// Design Name: 
// Module Name: i2c_master_top
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


module i2c_master_top(
    inout SDA,
    output SCL,
    input clk,
    input reset,
    input start,
    input [6:0]addr,
    input [7:0]data,
    input rw
    );
    
    wire scl_clk;
    wire sda_clk;
    wire [2:0]state;
    
    i2c_master_prescaler mpre(.scl_clk(scl_clk), .sda_clk(sda_clk), .sys_clk(clk), .reset(reset));
    
    i2c_master_fsm mfsm( .state(state), .SCL(SCL), .scl_clk(scl_clk), .reset(reset), .start(start));
    
    i2c_master_sdalogic msda(.SDA(SDA), .sda_clk(sda_clk), .reset(reset), .state(state), .addr(addr), .data(data), .rw(rw));
endmodule
