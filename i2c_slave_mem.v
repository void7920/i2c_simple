`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 07:50:16 PM
// Design Name: 
// Module Name: i2c_slave_mem
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


module i2c_slave_mem(
    output reg [7:0] o,
    input clk,
    input [7:0] addr,
    input [7:0] i,
    input rd
    );
   
    reg [7:0] mem [0:(1<<7)-1];
    
    always@(posedge clk) begin
        if (~rd) begin
            mem [addr] <= i;
        end
    end
    
    always@(posedge clk) begin
        if (rd) begin
            o <= mem [addr];
        end
    end
endmodule
