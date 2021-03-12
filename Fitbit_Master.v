`timescale 1ns / 1ps

module Fitbit_Master(
    input [1:0] mode,
    input clk, reset, start,
    output SI, 
    output  [3:0]anode,
    output  [6:0]segment
    );
    wire [15:0] stepCount;
    wire [15:0] distance;
    wire [15:0] speedCheck;
    wire [15:0] hat;

    
    wire lightClk;
    wire secondClk;
    wire startCount;
    //Module: SevSeg FSM
    reg [1:0] cycle;
    reg isSat=0;
    assign SI=isSat;
    
    wire [9:0] ppm;    
    reg [1:0]countTime=3;
    
    wire [3:0] intAn1;
    wire [3:0] intAn2;
    wire [3:0] intAn3;
    wire [3:0] intAn4;
    wire [6:0] intSeg1;
    wire [6:0] intSeg2;
    wire [6:0] intSeg3;
    wire [6:0] intSeg4;
    
    reg [3:0] an=0;
    reg [6:0] seg=0;
    assign anode=an;
    assign segment=seg;
    
    
    
//assign output values
    SendPulse pulseGen (mode, clk, reset, start, lightClk, secondClk, startCount,ppm);
    //1
    StepCount totalStep(lightClk, reset, start, startCount, stepCount);
    //2
    distancecovered totalDistance(stepCount, reset, start, distance);  
    //3
    SpeedChecker isntWalking(lightClk, secondClk, reset, start, speedCheck);
    //4
    HighActivityTracker isHigh(ppm, secondClk, reset, hat);
    
    SevSegDisplay fsm1(stepCount,reset,clk,1'b0,intAn1,intSeg1);
    SevSegDisplay fsm2(distance,reset,clk,1'b1,intAn2,intSeg2);
    SevSegDisplay fsm3(speedCheck,reset,clk,1'b0,intAn3,intSeg3);
    SevSegDisplay fsm4(hat,reset,clk,1'b0,intAn4,intSeg4);


always@(posedge clk) begin
    case(cycle)
    //FSM1: Module to count total steps, loop at 9999, SI=1 (Me)
        2'b00: begin
            an<=intAn1;
            seg<=intSeg1;
        end
    //FSM2: Module to count distance covered (step/2048), Round down to lowest .5, (Car) 
        2'b01: begin
            an<=intAn2;
            seg<=intSeg2;
        end
    //FSM3: Module to count number of seconds with over 32 steps/second in first 9 seconds (Me)
        2'b10:  begin
            an<=intAn3;
            seg<=intSeg3;
        end
    //FSM4: Module to show high activity time (64+ steps/second for 60+ seconds, freeze if drop below (Car)
    //64 steps/second, restart when achieved again
        2'b11:  begin
            an<=intAn4;
            seg<=intSeg4;
        end
    default cycle=2'b00;
    endcase
    if (stepCount>9999) isSat=1;
    else isSat=0;
end


always@(start||reset) begin
    countTime=0;
end
    
always @(posedge secondClk)    begin
    if(countTime==1)  cycle=cycle+1;
    countTime=(countTime+1)%2;
end

    //Module: Pulse Generator
    //module SendPulse( input [1:0] mode,  input clk, reset, start,  output reg light, [17:0]stepCount);

    
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
