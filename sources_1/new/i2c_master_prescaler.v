`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 11:54:33 PM
// Design Name: 
// Module Name: i2c_master_prescaler
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


module i2c_master_prescaler #(parameter ihz = 80, parameter ohz = 4)(
    output reg scl_clk,
    output reg sda_clk,
    input sys_clk,
    input reset
    );
    
    reg [10:0] i;
    
    always@ (posedge sys_clk, posedge reset) begin
        if(reset)
            i <= 0;
        else if (i == 999)
            i <= 0;
        else
            i <= i + 1;
    end
    
    always@ (posedge sys_clk, posedge reset) begin
        if(reset)
            scl_clk <= 1'b0;
        else if (i == 999)
            scl_clk <= ~scl_clk;
        else
            scl_clk <= scl_clk;
    end
    
    always@ (posedge sys_clk, posedge reset) begin
        if(reset)
            sda_clk <= 1'b0;
        else if (i == 499)
            sda_clk <= ~sda_clk;
        else
            sda_clk <= sda_clk;
    end
endmodule
