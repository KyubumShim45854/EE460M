`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: UT Austin
// Engineer: Jerry Yang

// Module Name: sevenseg
// Description: This module reads in a 16-bit value (sw) and displays the hex value
//  of each set of four bits (sw[15:12], sw[11:8], sw[7:4], sw[3:0]) on the seven-seg.
//  The module generates a divide-by-2 clock divider to drive its FSM.
// 
// Dependencies: bcd.v
//////////////////////////////////////////////////////////////////////////////////


module sevenseg(
  input clk,
  input [15:0] sw,
  input reset, //btnC
  output [3:0] an,
  output [6:0] seg
); 

// BCD instantiation
reg [3:0] bcdin = 0; // Input to BCD, output directly tied to seg
bcd b0 (bcdin, seg);

// Clock divider - Divide-by-2
//reg count = 0;
//wire slow_clk = count;
//always @(posedge clk) count = count + 1;

// State register variables
reg [1:0] current = 0;
reg [1:0] next = 0;

// Sequential logic
always @(posedge clk) current <= next; // Asynchronous reset if reset placed in sensitivity list here

// Combinational logic
reg [3:0] an_buf = 0;
assign an = an_buf;
always @(*) begin
    if(reset) begin // Synchronous reset
        bcdin = sw[3:0];// Set outputs
        an_buf = 4'b1110;
        next = 0;// set next state
        end
    else begin
        case(current)
        0: begin // state 0
            bcdin = sw[3:0]; // set outputs: segs and ans
            an_buf = 4'b1110; 
            next = 1; // set next state
            end
        1: begin // state 1
            bcdin = sw[7:4];
            an_buf = 4'b1101;
            next = 2;
            end
        2:begin
            bcdin = sw[11:8];
            an_buf = 4'b1011;
            next = 3;
            end
        3:begin
            bcdin = sw[15:12];
            an_buf = 4'b0111;
            next = 0;
            end
        default: begin
            bcdin = sw[3:0];
            an_buf = 4'b1110;
            next = 1;
            end
        endcase
    end
end

endmodule
