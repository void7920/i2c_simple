`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 12:07:09 AM
// Design Name: 
// Module Name: tb_prescaler
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


module tb_prescaler();
    reg clk;
    reg reset;
    wire scl_clk;
    wire sda_clk;
    
    i2c_master_prescaler uut(.scl_clk(scl_clk), .sda_clk(sda_clk), .sys_clk(clk), .reset(reset));
    
    always#(10) clk = ~clk;
    
    initial begin
        clk = 1'b0;
        reset  = 1'b1;
    end
    
    initial begin
        # 20 reset = 1'b0;
    end
endmodule
