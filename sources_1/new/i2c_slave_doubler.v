`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 01:00:15 PM
// Design Name: 
// Module Name: i2c_slave_doubler
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


module i2c_slave_doubler #(parameter delay = 625)(
    output oclk,
    input iclk,
    input reset
    );

    reg Q; 
    reg clk;
    reg temp;
    
    assign oclk = ~clk;
    
    always@ (*) begin 
        clk = iclk ^ temp;
    end
    
    always@(*) begin
        #(delay) temp = Q;
    end
    
    always@(posedge clk, posedge reset) begin
        if (reset) begin
            Q <= 0;
        end
        else begin
            Q <= iclk;
        end
    end
 endmodule
