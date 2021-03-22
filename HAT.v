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
    reg[2:0] ns =0; // next state
    reg update=0;

    assign hat = ohpc;

always @(posedge clk)begin
     s<=ns;
     update=!update;
 end
    
always@(s,update,reset,ppm)
    begin
        case(s)
            3'b000: begin
            temphpc <=0;
            if(!reset)
            begin
                    if(ppm < 9'd64)
                        ns <= 0;
                    else
                        ns <= 1;
                end
             else ns <= 3;
            
             end
            3'b001: begin
                    if( !reset) // reset not asserted
                    begin
                    temphpc <= temphpc +1;
                     if(temphpc >= 9'd60 && ppm >= 9'd64) // if its been 60, go to state 2, add 60 to the overal hpc   
                               ns <= 4; // goes to add 60                
                        else if(temphpc < 9'd60 && ppm >= 9'd64) // if it hasn't been 60 seconds yet, keep it there           
                                ns <= 1;
                        else if (ppm < 9'd64) // if the pulse rate drops, go back to 0
                            ns <=0;
                     end      
                     else 
                     ns <= 3; // go to the reset state if reset asserted

                     end     
                         
            3'b010: begin
                    if(!reset)
                        begin
                        ohpc <= ohpc+1;
                            if(ppm >= 9'd64)
                                    ns <= 2;
                             else
                                ns <=0;
                                ohpc <=ohpc;
                        end
                     else begin
                        ns <= 3;
                        ohpc=ohpc;
                    end
                end
                              
            3'b011: begin
                ohpc <= 0;
                temphpc <= 0;
                ns <= 0;
                end
                
            3'b100: begin
                ohpc <= ohpc + 60;
                if(ppm>= 9'd64)
                    ns <= 2;
                else
                    ns <= 0;
                 end
            default: begin
                ns=0;
                temphpc=0;
                ohpc=0;
            end                           
                endcase
                
                end
   
endmodule 
