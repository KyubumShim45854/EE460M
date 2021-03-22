`timescale 1ns / 1ps

module Fitbit_Master(
    input [1:0] mode,
    input clk, reset, start,
    output SI, second, lightPulse,
    output [1:0] curFSM,
    output  [3:0]anode,
    output  [6:0]segment
    );
    wire [15:0] stepCount;
    wire [15:0] distance;
    wire [15:0] speedCheck;
    wire [15:0] hat;

    
    wire lightClk;
    assign lightPulse=lightClk;
    wire secondClk;
    assign second = secondClk;
    wire startCount;
    //Module: SevSeg FSM
    reg [1:0] cycle=0;
    

    wire [9:0] ppm;    
    reg [2:0]countTime=0;
    
    reg altIn=0;
    reg [15:0] segIn;

    wire [3:0] an;
    wire [6:0] seg;
    assign anode=an;
    assign segment=seg;
    
    assign curFSM=cycle;
    
//assign output values
    SendPulse pulseGen (mode, clk, reset, start, lightClk, secondClk, startCount,ppm);
    //1
    StepCount totalStep(lightClk, reset, start, startCount, stepCount/* Overflow*/);
    //2
    distancecovered totalDistance(stepCount, reset, distance);  
    //3
    SpeedChecker isntWalking(lightClk, secondClk, reset, start, speedCheck);
    //4
    HighActivityTracker isHigh(ppm, secondClk, reset, hat);
    //Overflow
    wire overflow;
    assign SI=overflow;
    checkOverflow checkPlz(reset, stepCount, overflow);
    
/*    
    SevSegDisplay fsm1(stepCount,reset,clk,1'b0,intAn1,intSeg1);
    SevSegDisplay fsm2(distance,reset,clk,1'b1,intAn2,intSeg2);
    SevSegDisplay fsm3(speedCheck,reset,clk,1'b0,intAn3,intSeg3);
    SevSegDisplay fsm4(hat,reset,clk,1'b0,intAn4,intSeg4);
*/
    SevSegDisplay overallFSM(segIn, reset, clk, altIn, an,seg);



always@(posedge clk) begin
    case (cycle)
    2'b00: begin
    //FSM1: Module to count total steps, loop at 9999, SI=1 (Me)
              altIn<=0;
              segIn<=stepCount;
        /*    an<=intAn1;
            seg<=intSeg1;*/
    end
    //FSM2: Module to count distance covered (step/2048), Round down to lowest .5, (Car) 
      2'b01: begin
            altIn<=1;
            segIn<=distance;
         /*   an<=intAn2;
            seg<=intSeg2;*/
        end
    //FSM3: Module to count number of seconds with over 32 steps/second in first 9 seconds (Me)
        2'b10: begin
            altIn<=0;
            segIn<=speedCheck;
            /*an<=intAn3;
            seg<=intSeg3;*/
        end
    //FSM4: Module to show high activity time (64+ steps/second for 60+ seconds, freeze if drop below (Car)
    //64 steps/second, restart when achieved again
        2'b11: begin
            altIn<=0;
            segIn<=hat;
            /*an<=intAn4;
            seg<=intSeg4;*/
        end
//    default cycle=2'b00;
    endcase
  
end
always @ (posedge secondClk) begin
    if (reset) begin
        cycle=0;
        countTime=0;
    end
    else if(start) begin
        countTime=countTime+1;
        if((countTime%2)) cycle=cycle+1;
    end
    
end




endmodule