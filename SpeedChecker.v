`timescale 1ns / 1ps

module SpeedChecker(
    input lightClk, secondClk, reset, start,
    output [15:0] speedCheck
    );
    
    reg [8:0] pulseCount=0;
    reg [15:0] speedCheckPass=0;
    reg [4:0] currentTime=0;
    reg [4:0] prevTime=0;
    reg check=0;
    assign speedCheck=speedCheckPass;
    
    
    //reg posSec=0;
    
    always @(posedge secondClk) begin
        if (reset) currentTime<=0;
        else if(!start) currentTime<=currentTime;
        else currentTime<=currentTime+1;
    end


always@(posedge lightClk) begin
    if(reset) begin
        speedCheckPass<=0;
        pulseCount<=0;
    end
    else begin
        if(start) pulseCount<=pulseCount+1;
        else pulseCount<=pulseCount;
        if(prevTime!=currentTime) begin
            if(currentTime<=10) begin          
                if((pulseCount>=33)&&(speedCheckPass<9)) begin
                    speedCheckPass<=speedCheckPass+1;
                end
                else speedCheckPass<=speedCheckPass;
            end
            prevTime<=currentTime;
            pulseCount<=0;
        end
        
    end
    
end    
    
    
    
    
    
endmodule
