`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 04:15:54 PM
// Design Name: 
// Module Name: sda_slave_fsm
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


module i2c_slave_fsm(
    output reg [2:0] state,
    input clk,
    input reset,
    input SCL,
    input SDA
    );
    
    parameter STATE_IDLE=3'd0;
    parameter STATE_START =3'd1; 
    parameter STATE_ADDR=3'd2;
    parameter STATE_RW=3'd3;
    parameter STATE_ACK=3'd4;
    parameter STATE_MEM=3'd5;
    parameter STATE_DATA=3'd6; 
    parameter STATE_STOP=3'd7;
    
    reg [2:0] next_state;
    reg [7:0] cnt;
    reg [1:0] flag;
    
    always@(posedge clk, posedge reset) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end
    
    always@(posedge clk, posedge reset) begin
        if (reset)
            cnt  <= 0;
        else
            case (state)
                STATE_IDLE: begin
                    cnt <= 0;
                end
                STATE_START: begin
                    cnt <= 13;
                end
                STATE_ADDR: begin
                    if (cnt == 0)
                        cnt <= 1;
                    else
                        cnt <= cnt - 1;
                end
                STATE_RW: begin
                    if (cnt == 0)
                        cnt <= 1;
                    else
                        cnt <= cnt - 1;
                end
                STATE_ACK: begin
                    if (cnt == 0)
                        cnt <= 15;
                    else
                        cnt <= cnt - 1;
                end
                STATE_MEM: begin
                    if (cnt == 0)
                        cnt <= 1;
                    else
                        cnt <= cnt - 1;
                end
                STATE_DATA: begin
                    if (cnt == 0)
                        cnt <= 1;
                    else
                        cnt <= cnt - 1;
                end
                STATE_STOP: begin
                    cnt <= 0;
                end
                 
                default: cnt <= 0;
            endcase
    end
    
        
    always@(posedge clk, posedge reset) begin
        if (reset)
            flag  <= 0;
        else
            case (state)
                STATE_IDLE: begin
                    flag <= 0;
                end
                STATE_ADDR: begin
                    flag <= 1;
                end
                STATE_RW: begin
                    flag <= flag;
                end
                STATE_ACK: begin
                    flag <= flag;
                end
                STATE_MEM: begin
                    flag <= 2;
                end
                STATE_DATA: begin
                    flag <= 3;
                end
                STATE_STOP: begin
                    flag <= 0;
                end
                default: flag <= 0;
            endcase
    end
    
    always@(*) begin
        next_state = 0;
        
        case (state)
             STATE_IDLE: begin
                if (SDA == 1 || SCL == 1)
                    next_state = STATE_START;
                else
                    next_state = STATE_IDLE;
             end
            STATE_START: begin
                if (SDA == 0 && SCL == 0)
                    next_state = STATE_ADDR;
                else 
                    next_state = STATE_START;
             end
            STATE_ADDR: begin
                if (cnt == 0)
                    next_state = STATE_RW;
                else
                    next_state = STATE_ADDR;
             end
            STATE_RW: begin
                if (cnt == 0)
                    next_state = STATE_ACK;
                else
                    next_state = STATE_RW;
             end
            STATE_ACK: begin
                if (cnt ==0) begin
                    if (flag == 1)
                        next_state = STATE_MEM;
                    else if (flag == 2)
                        next_state = STATE_DATA;
                    else if (flag == 3)
                        next_state = STATE_IDLE;
                end
                else
                    next_state = STATE_ACK;
             end
            STATE_MEM: begin
                if (cnt == 0)
                    next_state = STATE_ACK;
                else
                    next_state = STATE_MEM;
             end
            STATE_DATA: begin
                if (cnt == 0)
                    next_state = STATE_ACK;
                else
                    next_state = STATE_DATA;
             end
            STATE_STOP: begin
                next_state = STATE_IDLE;
             end
             
             default: next_state = STATE_IDLE;
        endcase
    end
endmodule
