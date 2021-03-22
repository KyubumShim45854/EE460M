`timescale 1ns / 1ps
module SevSeg(
    input [3:0]in,
    output [6:0]segment
    );
    
    reg [6:0]segData;
    assign segment=segData;
        
always@(*) begin    
    case (in) 
        4'b0000: segData = 7'b1000_000;
        4'b0001: segData = 7'b1111_001;
        4'b0010: segData = 7'b0100_100;
        4'b0011: segData = 7'b0110_000;
        4'b0100: segData = 7'b0011_001;
        4'b0101: segData = 7'b0010_010;
        4'b0110: segData = 7'b0000_010;
        4'b0111: segData = 7'b1111_000;
        4'b1000: segData = 7'b0000_000;
        4'b1001: segData = 7'b0010_000;
        4'b1010: segData=7'b1110_111;
        4'b1011: segData=7'b0000_000;
        default: segData=7'b0000001;

    endcase

 end       

endmodule
