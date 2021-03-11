`timescale 1ns / 1ps

module SevSegDisplay(
    input [15:0] sw,
    input reset, clk,
    output reg [3:0] an, //anode signal controller
    output reg [6:0] seg //LED signal controller
    );
    wire slow_clk;
    clkdiv cl (clk, reset, slow_clk);
    
    reg [2:0]anOrder;  
    reg [2:0] nextOrder;

   wire [6:0] data0;
   wire [3:0]in0 = sw[15:12];
   
   SevSeg bcd0(in0, data0);
   wire [6:0] data1;
   SevSeg bcd1(sw[11:8], data1);
   wire [6:0] data2;
   SevSeg bcd2(sw[7:4], data2);
   wire [6:0] data3;
   SevSeg bcd3(sw[3:0], data3);
   

   //Cycle through the 4 digits by activating each an, update output seg 
    always @(*) begin
        case (anOrder)
            3'b000: begin
                an=4'b0111;//0th Activate
                seg<=data0;
                if (reset)  nextOrder=3'b111;
                else        nextOrder= 3'b001;
                end
                    
            3'b001: begin
                an=4'b1011; //1st Activate
                seg<=data1;
                if (reset)  nextOrder=3'b111;
                else        nextOrder=3'b010;
                end
                
             3'b010: begin
                an=4'b1101;//2nd Activate.
                seg<=data2;
                if (reset)  nextOrder=3'b111;
                else        nextOrder=3'b011;
                end
                    
            3'b011: begin
                an=4'b1110; //3rd Activate
                seg<=data3;
                if(reset)   nextOrder=3'b111;
                else        nextOrder=3'b000;
                end               
            
            3'b111: begin
                an=4'b1111; //no output
                //seg<=data0;
                if (reset)  nextOrder=3'b111;
                else        nextOrder=3'b000;
                end
                  
            default: begin
                nextOrder=3'b000;
            end
                
        endcase
    end
            
    
    always @ (posedge slow_clk)
            anOrder<=nextOrder;            
    
endmodule
