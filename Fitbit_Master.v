`timescale 1ns / 1ps

module Fitbit_Master(
    input [1:0] mode,
    input clk, reset, start,
    output SI, stepLight
    );
    wire [15:0] stepCount;
    wire lightClk;
    wire secondClk;
    wire startCount;
    //Module: SevSeg FSM
    reg [1:0] cycle=0;
    reg[15:0] outputNumber;

always@(cycle) begin
    case(cycle)
    //FSM1: Module to count total steps, loop at 9999, SI=1 (Me)
        //2'b00: outputNumber=stepCount;
    //FSM2: Module to count distance covered (step/2048), Round down to lowest .5, (Car) 
            
    //FSM3: Module to count number of seconds with over 32 steps/second in first 9 seconds (Me)
    
    //FSM4: Module to show high activity time (64+ steps/second for 60+ seconds, freeze if drop below (Car)
    //64 steps/second, restart when achieved again
    default cycle=2'b00;
    endcase    
end

    wire fsmClk;
    
always @(posedge fsmClk)    begin
    cycle=cycle+1;
end

    //Module: Pulse Generator
    //module SendPulse( input [1:0] mode,  input clk, reset, start,  output reg light, [17:0]stepCount);
    SendPulse pulseGen (mode, clk, reset, start, lightClk, secondClk, startCount);
    StepCount totalStep(lightClk, reset, start, startCount, stepCount);
 
 
 reg [15:0]currentTime;    

//other methods of implementation
always @(start) begin
    if(!start) begin
        currentTime=0;
    end
    else currentTime=currentTime;
end

 always @(posedge secondClk) begin
         currentTime=currentTime+1;
 end
    
endmodule
