`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 12:28:24 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(
input clk,
input [8:0] pps,
output newclk
    );
    reg [31:0] count = 0;
    reg [31:0] comp = 0;
    reg divclock = 0;
    
    assign newclk = divclock;
    

always@(pps)
begin
case(pps)
9'd32: comp = 1562500;//31249999;// might need to divide by 20
9'd64: comp = 781250;//15624999;
9'd128: comp = 390625;// 7812499;
9'b000010100: comp = 2500000;//49999999;
9'b000100001: comp = 1515151;//30303029;
9'b001000010: comp = 757575;//15151514;
9'b000011011: comp = 1851851;//37037036;
9'b001000110: comp = 714285;//14285713;
9'b000011110: comp = 1666666;//33333332;
9'b000001011: comp = 2631579;//52631577;
9'b001000101: comp = 724637;//14492752;
9'b000100010: comp = 1470588;//29411763;
9'b001111100: comp = 403225;//8064515;
9'd1: comp = 50000000; // 1 sec
9'd0: comp = 0;

default: comp = 1;

endcase
end
always@(posedge clk)
begin
// the variable clock divider
if(comp)
begin
count = count + 1;
   if (count == comp)
    begin
    divclock = ~divclock;
    count = 0;
    end
    end
    
    end
    

endmodule
