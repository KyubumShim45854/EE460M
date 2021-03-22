`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 03:53:02 PM
// Design Name: 
// Module Name: HighActivityTracker
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


module HighActivityTracker(
input [9:0]ppm,
input clk, // 1 sec clock
input reset,//start,
output [15:0]hat // high activity time
    );
    
    reg [8:0] temphpc=0 ;  //temporary high pulse counter 
    reg [15:0] ohpc=0;  // overall high pulse counter
    reg[2:0] s =0; // state
    reg[2:0] ns = 0 ; // next state
    wire update;
    
    assign hat = ohpc;
    

   
    

always @(posedge clk)begin
     s<=ns;
     if (s== 0) temphpc <= 0;
     if(s == 1) temphpc <= temphpc+1;
     if (s == 2) ohpc <= ohpc +1;
     if (s == 4) ohpc <= ohpc + 60;
     if ({reset,s} == 4'b1000) begin
     ohpc <=0;
     temphpc <= 0;
     end
     if ({reset,s} == 4'b1001) begin
     ohpc <= 0;
     temphpc <= 0;
     end
     if ({reset,s} == 4'b1010) begin
     ohpc <= 0;
     temphpc <=0;
     end
     if ({reset,s} == 4'b1100) begin
     ohpc <= 0;
     temphpc <= 0;
     end
     
     
     
 end
 
    
always@(s,reset,temphpc,ohpc,ppm)
    begin
        case({reset,s})
            4'b0000: begin
            
                    if(ppm >= 10'd64)
                        ns <= 1;
                    else
                     ns <= 0;
                end
            4'b0001: begin
                    
                    
                     if(temphpc >= 9'd60 && ppm >= 10'd64) // if its been 60, go to state 2, add 60 to the overal hpc   
                               ns <= 4; // goes to add 60               
                        else if(temphpc < 9'd60 && ppm >= 10'd64) // if it hasn't been 60 seconds yet, keep it there           
                                ns <= 1;
                        else if (ppm < 10'd64) // if the pulse rate drops, go back to 0
                            ns <=0;
                  
                     end     
                         
            4'b0010: begin
                  
                            if(ppm >= 10'd64)
                                    ns <= 2;
                             else
                                ns <=0;
                                
                        end
                    
                             
           
                
             4'b1000: begin
             ns <=0;
             end
             4'b1001: begin
             ns <=0;
             end
             4'b1010: begin
             ns <=0;
             end
            
             4'b1100:begin
             ns <=0;
             end
            
                
            4'b0100: begin
                
                if(ppm>= 10'd64)
                    ns <= 2;
                else
                    ns <= 0;
                 end
            default: begin
                ns<=0;
               
            end                           
                endcase
                
                end
   
endmodule 
