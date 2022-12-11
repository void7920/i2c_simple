`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 02:13:32 PM
// Design Name: 
// Module Name: tb_fsm
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


module tb_fsm();
    reg clk;
    reg reset;
    reg start;
    wire [2:0]state;
    wire [2:0]cnt;
    wire SCL;
    
    i2c_master_fsm uut(.state(state), .cnt(cnt), .SCL(SCL), .scl_clk(clk), .reset(reset), .start(start));
    
    always#(10) clk = ~clk;
    
    initial begin
        clk = 1'b0;
        reset  = 1'b1;
        start = 1'b0;
    end
    
    initial begin
        # 20 reset = 1'b0;
        #10 start = 1'b1;
        #20 start = 1'b0;
    end
endmodule
