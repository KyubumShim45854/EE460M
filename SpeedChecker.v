`timescale 1ns / 1ps

module SpeedChecker(
    input lightClk, secondClk, reset, start,
    output [15:0] speedCheck
    );
    
    reg [8:0] pulseCount=0;
    reg [15:0] speedCheckPass=0;
    reg [4:0] currentTime=0;
    assign speedCheck=speedCheckPass;
    
    
always @(reset) begin
    pulseCount=0;
    speedCheckPass=0;
    currentTime=0;
       
end    
    
 always @ (posedge secondClk) begin
    if(reset) begin
        speedCheckPass=0;
        currentTime=0;
    end
    else if(currentTime<=9) begin          
        if((pulseCount>=33)&&(currentTime<=5'b01001)&(speedCheckPass<9)) begin
            speedCheckPass=speedCheckPass+1;
        end
        currentTime=currentTime+1;
    end
    
    pulseCount=0;
end
always@(posedge lightClk) begin
    pulseCount=pulseCount+1;
end    
    
    
    
    
    
endmodule
