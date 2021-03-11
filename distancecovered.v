`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 11:49:09 AM
// Design Name: 
// Module Name: distancecovered
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

// should convert stepcount to multiples of 5 
// 5 = .5, 10 = 1, 15 = 1.5
module distancecovered(
input [31:0] stepcount, 
output [20:0] distance 
    );
     reg[31:0] temp = 0;
    reg [20:0] dist = 0;
  assign distance = dist;
 
 always@(stepcount)
 begin
 assign temp = stepcount >> 11;
 assign dist = temp*5;
 
 end
 
 
endmodule
