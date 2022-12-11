`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 02:19:33 PM
// Design Name: 
// Module Name: i2c_master_sdalogic
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


module i2c_master_sdalogic(
    inout SDA,
    input sda_clk,
    input reset,
    input [2:0]state,
    input [6:0]addr,
    input [7:0]data,
    input rw
    );
    
    parameter STATE_IDLE =3'd0;
    parameter STATE_START =3'd1; 
    parameter STATE_ADDR=3'd2;
    parameter STATE_RW=3'd3;
    parameter STATE_ACK=3'd4;
    parameter STATE_MEM=3'd5;
    parameter STATE_DATA=3'd6; 
    parameter STATE_STOP=3'd7;
    
    reg [6:0] buf_addr;
    reg [7:0] buf_data;
    reg buf_rw;
    reg bsda;
    
    assign SDA = bsda;
     
    always@ (posedge sda_clk, posedge reset) begin
        if (reset)
            bsda <= 1'b1;
        else begin
            case (state)
                STATE_IDLE: begin
                    bsda <= 1'b1;
                end
                
                STATE_START: begin
                    bsda <= 1'b0;
                end
                
                STATE_ADDR: begin
                    bsda <= buf_addr[6];
                end
                
                STATE_RW: begin
                    bsda <= buf_rw;
                end
                
                STATE_ACK: begin
                    bsda <= 1'bz;
                end
                
                STATE_MEM: begin
                    bsda <= buf_data[7];
                end
                
                STATE_DATA: begin
                    if (buf_rw) begin
                        bsda <= 1'bz;
                    end
                    else begin
                        bsda <= buf_data[7];
                    end
                end
                
                STATE_STOP: begin
                    bsda <= 1'b0;
                end
                
                default: bsda <= 1'b0;
            endcase
        end
    end
    
    always@(posedge sda_clk, posedge reset) begin
        if (reset)
            buf_rw <= 1'b0;
        else begin
            case (state)
                STATE_IDLE: begin
                    buf_rw <= rw;
                end
                
                STATE_START: begin
                    buf_rw <= buf_rw;
                end
                
                STATE_ADDR: begin
                    buf_rw <= buf_rw;
                end
                
                STATE_RW: begin
                    buf_rw <= buf_rw;
                end
                
                STATE_ACK: begin
                    buf_rw <= buf_rw;
                end
                
                STATE_MEM: begin
                    buf_rw <= buf_rw;
                end
                
                STATE_DATA: begin
                    buf_rw <= buf_rw;
                end
                
                STATE_STOP: begin
                    buf_rw <= buf_rw;
                end
                
                default: buf_rw <= buf_rw;
            endcase
        end
    end
    
    always@(posedge sda_clk, posedge reset) begin
        if (reset)
            buf_addr <= 1'b0;
        else begin
            case (state)
                STATE_IDLE: begin
                    buf_addr <= addr;
                end
                
                STATE_START: begin
                    buf_addr <= buf_addr;
                end
                
                STATE_ADDR: begin
                    buf_addr <= {buf_addr[5:0], 1'b0};
                end
                
                STATE_RW: begin
                    buf_addr <= buf_addr;
                end
                
                STATE_ACK: begin
                    buf_addr <= buf_addr;
                end
                
                STATE_MEM: begin
                    buf_addr <= buf_addr;
                end
                
                STATE_DATA: begin
                    buf_addr <= buf_addr;
                end
                
                STATE_STOP: begin
                    buf_addr <= buf_addr;
                end
                
                default: buf_addr <= buf_addr;
            endcase
        end
    end
    
        always@(posedge sda_clk, posedge reset) begin
        if (reset)
            buf_data <= 1'b0;
        else begin
            case (state)
                STATE_IDLE: begin
                    buf_data <= buf_data;
                end
                
                STATE_START: begin
                    buf_data <= buf_data;
                end
                
                STATE_ADDR: begin
                    buf_data <= buf_data;
                end
                
                STATE_RW: begin
                    buf_data <= buf_data;
                end
                
                STATE_ACK: begin
                    buf_data <= data;
                end
                
                STATE_MEM: begin
                    buf_data <= {buf_data[6:0], 1'b0};
                end
                
                STATE_DATA: begin
                    buf_data <= {buf_data[6:0], 1'b0};
                end
                
                STATE_STOP: begin
                    buf_data <= buf_data;
                end
                
                default: buf_data <= buf_data;
            endcase
        end
    end
endmodule
