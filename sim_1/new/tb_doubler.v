`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 01:07:30 PM
// Design Name: 
// Module Name: tb_doubler
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


module tb_doubler();
    reg SCL;
    reg reset;
    wire out;
    
    i2c_slave_doubler #(50) uut(.oclk(out), .iclk(SCL), .reset(reset));
    
    always#100 SCL = ~SCL;
    
    initial begin
        SCL = 1'b0;
        reset = 1'b0;
        #10 reset = 1'b1;
        #10 reset = 1'b0;
    end
endmodule
