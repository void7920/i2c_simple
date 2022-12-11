`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 01:43:12 PM
// Design Name: 
// Module Name: state_parameter
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

    parameter STATE_IDLE =3'd0;
    parameter STATE_START =3'd1; 
    parameter STATE_ADDR=3'd2;
    parameter STATE_RW=3'd3;
    parameter STATE_ACK=3'd4;
    parameter STATE_MEM=3'd5;
    parameter STATE_DATA=3'd6; 
    parameter STATE_STOP=3'd7;