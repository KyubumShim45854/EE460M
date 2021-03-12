`timescale 1ns / 1ps

module SpeedChecker(
    input lightClk, secondClk, reset, start,
    output [4:0] speedCheck
    );
    
    reg [8:0] pulseCount;
    reg [3:0] speedCheckPass;
    reg [4:0] currentTime;
    assign speedCheck=speedCheckPass;
    
    
always @(start||reset) begin
    pulseCount=0;
    speedCheckPass=0;
    currentTime=0;
       
end    
    
 always @ (posedge secondClk) begin
    if(!reset) begin          
        if((pulseCount>32)&&(currentTime<9)) begin
            speedCheckPass=speedCheckPass+1;
        end
        else currentTime=currentTime+1;
    end
    
    pulseCount=0;
end
always@(posedge lightClk) begin
    pulseCount=pulseCount+1;
end    
    
    
    
    
    
endmodule
