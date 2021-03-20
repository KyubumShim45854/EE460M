`timescale 1ns / 1ps

// should convert stepcount to multiples of 5 
// 5 = .5, 10 = 1, 15 = 1.5
module distancecovered(
input [15:0] stepcount, 
input reset,start,
output [15:0] distance 
    );
     reg[31:0] temp = 0;
    reg [15:0] dist = 0;
  assign distance = dist;
 
 always@(reset or stepcount)begin
    if(reset) begin
        temp=0;
        dist=0;
    end
    else begin
        temp = stepcount >> 11;
        dist = temp*5;
    end
 end
 
 
endmodule