`timescale 1ns / 1ps

module SpeedChecker(
    input lightClk, secondClk, reset, start,
    output [15:0] speedCheck
    );
    
    reg [8:0] pulseCount=0;
    reg [15:0] speedCheckPass=0;
    reg [4:0] currentTime=0;
    reg repeatCheck=0;
    assign speedCheck=speedCheckPass;
    
always @ (reset||!start) begin
   speedCheckPass<=0;
    currentTime<=0;
    pulseCount=0;
    repeatCheck=0;
end  

 always @ (posedge secondClk) begin
    if(!repeatCheck) begin
        repeatCheck=1;
        speedCheckPass=0;
        currentTime=0;
        pulseCount=0;
    end
    if(currentTime<10) begin          
        if((pulseCount>=33)&&(speedCheckPass<9)) begin
            speedCheckPass<=speedCheckPass+1;
        end
            currentTime<=currentTime+1;

    end
    pulseCount<=0;
end
always@(posedge lightClk) begin
    if(start) pulseCount<=pulseCount+1;
end    
    
    
    
    
    
endmodule
