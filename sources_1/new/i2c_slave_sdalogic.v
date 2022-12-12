`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2022 03:58:53 PM
// Design Name: 
// Module Name: i2c_slave_sdalogic
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


module i2c_slave_sdalogic #(parameter ID = 7'd2) (
    inout SDA,
    output [7:0]odata,
    output [7:0]mem_addr,
    output rd,
    input clk,
    input reset,
    input SCL,
    input [2:0]state,
    input [7:0]idata
    );
    
    parameter STATE_IDLE =3'd0;
    parameter STATE_START =3'd1; 
    parameter STATE_ADDR=3'd2;
    parameter STATE_RW=3'd3;
    parameter STATE_ACK=3'd4;
    parameter STATE_MEM=3'd5;
    parameter STATE_DATA=3'd6; 

    reg rw;
    reg [6:0] buf_addr;
    reg [7:0] buf_mem;
    reg [7:0] buf_data;
    reg [1:0] cnt;
    
    assign rd = (rw) ? 1'b1 : 1'b0;
    assign odata = (state==STATE_IDLE && ~rw) ? buf_data : 0;   
    assign mem_addr = (state==STATE_IDLE | state == STATE_ACK) ? buf_mem : 0;
    assign SDA = (state == STATE_ACK && buf_addr == ID) ? 1'b1 : ((state == STATE_DATA && buf_addr == ID) ? ((rw) ? buf_data[7] : 1'bz) : 1'bz);
    
    always@(posedge clk, posedge reset) begin
        if (reset)
            buf_addr <= 0;
        else begin
            if (state == STATE_ADDR)
                if (SCL)
                    buf_addr <= {buf_addr[5:0], SDA};
                else
                    buf_addr <= buf_addr;
            else if (state == STATE_START)
                buf_addr <= 0;
            else
                buf_addr <= buf_addr;
        end
    end
       
    always@(posedge clk, posedge reset) begin
        if (reset)
            buf_mem <= 0;
        else begin
            if (buf_addr == ID)
                if (state == STATE_MEM)
                    if (SCL)
                        buf_mem <= {buf_mem[6:0], SDA};
                    else
                        buf_mem <= buf_mem;
                else if (state == STATE_START)
                    buf_mem <= 0;
                else
                    buf_mem <= buf_mem;
            else 
                buf_mem <= 0;        
        end
    end
    
    always@(posedge clk, posedge reset) begin
        if(reset)
            cnt <= 0;
        else
            if (state == STATE_DATA && rw)
                if (cnt == 0)
                    cnt <= 1;
                 else
                    cnt <= cnt - 1;
            else
                cnt <= 0;
    end 
    
    always@(posedge clk, posedge reset) begin
        if (reset)
            buf_data <= 0;
        else begin
            if (buf_addr == ID)
                if(rw)
                    if (state == STATE_ACK)
                        buf_data <= idata;
                    else if (state == STATE_DATA)
                        if (cnt == 1)
                            buf_data <= {buf_data[6:0],1'b0};
                        else
                            buf_data <= buf_data;
                    else
                        buf_data <= buf_data;
                else    
                    if (state == STATE_DATA)
                        if (SCL)
                            buf_data <= {buf_data[6:0], SDA};
                        else
                            buf_data <= buf_data;
                    else if (state == STATE_START) 
                        buf_data <= 0;
                    else
                        buf_data <= buf_data;
            else
                buf_data <= 0;
        end
    end
       
    always@(posedge clk, posedge reset) begin
        if (reset)
            rw <= 0;
        else
            if (state == STATE_START)
                rw <= 0;
            else if (state == STATE_RW)
                rw <= SDA;
            else
                rw <= rw;
    end
endmodule
