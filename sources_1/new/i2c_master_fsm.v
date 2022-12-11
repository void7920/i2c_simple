`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 01:40:52 PM
// Design Name: 
// Module Name: i2c_master_fsm
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


module i2c_master_fsm(
    output reg [2:0] state,
    output SCL,
    input scl_clk,
    input reset,
    input start
    );
    
//    `include "state_parameter.v"
    
    parameter STATE_IDLE =3'd0;
    parameter STATE_START =3'd1; 
    parameter STATE_ADDR=3'd2;
    parameter STATE_RW=3'd3;
    parameter STATE_ACK=3'd4;
    parameter STATE_MEM=3'd5;
    parameter STATE_DATA=3'd6; 
    parameter STATE_STOP=3'd7;
    
    reg [2:0] next_state;
    reg [7:0]cnt;
    reg [1:0] flag;
    
    assign SCL = (state == STATE_IDLE | state == STATE_START) ? 1'b1 : scl_clk;
    
    always@(posedge scl_clk, posedge reset) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end
    
    always@(posedge scl_clk, posedge reset) begin
        if (reset)
            cnt <= 0;
        else begin
            if (state == STATE_START)
                cnt <= 6;
            else if (state == STATE_ACK)
                cnt <= 7;
            else if (state == STATE_ADDR | state == STATE_DATA | state == STATE_MEM)
                cnt <= cnt - 1;
            else
                cnt <= 0;
        end
    end
    
    always@(posedge scl_clk, posedge reset) begin
        if (reset)
            flag <= 0;
        else begin
            if (state == STATE_RW)
                flag <= 1;
            else if (state == STATE_MEM)
                flag <= 2;
            else if (state == STATE_DATA)
                flag <= 3;
            else if (state == STATE_ACK)
                flag <= flag;
            else
                flag <= 0;
        end
    end
    
    always@(*) begin
        next_state = 0;
        
        case (state)
            STATE_IDLE: begin
                if (start) begin
                    next_state = STATE_START;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            
            STATE_START: begin
                    next_state = STATE_ADDR;
            end
            
            STATE_ADDR: begin
                if (cnt == 0) begin
                    next_state = STATE_RW;
                end
                else begin
                    next_state = STATE_ADDR;
                end
            end
            
            STATE_RW: begin
                    next_state = STATE_ACK;
            end
            
            STATE_ACK: begin
                    if (flag == 1)
                        next_state = STATE_MEM;
                    else if (flag == 2)
                        next_state = STATE_DATA;
                    else if (flag == 3)
                        next_state = STATE_STOP;
            end
            
            STATE_MEM: begin
                if (cnt == 0) begin
                    next_state = STATE_ACK;
                end
                else begin
                    next_state = STATE_MEM;
                end
            end
            
            STATE_DATA: begin
                if (cnt == 0) begin
                    next_state = STATE_ACK;
                end
                else begin
                    next_state = STATE_DATA;
                end
            end
            
            STATE_STOP: begin
                    next_state = STATE_IDLE;
            end
            
            default: next_state = STATE_IDLE;
        endcase
    end

endmodule
