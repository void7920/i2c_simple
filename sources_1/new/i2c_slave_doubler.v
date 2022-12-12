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


module i2c_slave_doubler (
    output oclk,
    input iclk,
    input reset
    );

    reg Q; 
    reg temp; 
    reg clk;
    
    assign oclk = ~clk;
    
    always@(*) begin
        if (reset) begin
            clk <= 0;
        end
        else begin
            clk <= iclk ^ temp;
        end
    end
    
    always@(*) begin
        if (reset) begin
            temp <= 0;
        end
        else begin
            #(625) temp <= Q;
        end
    end

    always@(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 0;
        end
        else begin
            Q <= iclk;
        end
    end
 endmodule