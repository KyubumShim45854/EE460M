`timescale 1ns / 1ps

module SpeedChecker(
    input [9:0] ppm,
    input secondClk, reset, start,
    output [15:0] speedCheck
    );
    
    reg [15:0] speedCheckPass=0;
    reg [4:0] currentTime=0;
    
    reg check=0;
    assign speedCheck=speedCheckPass;
    
    
    //reg posSec=0;
    
    always @(posedge secondClk) begin
        if (reset) begin 
            currentTime<=0;
            speedCheckPass<=0;
        end
        else if(!start) begin
            currentTime<=currentTime;
            speedCheckPass<=speedCheckPass;
        end
        else begin 
           
            if(currentTime<10) begin          
                if((ppm>=33)&&(speedCheckPass<9)) begin
                    speedCheckPass<=speedCheckPass+1;
                end
                else speedCheckPass<=speedCheckPass;
            end
            currentTime<=currentTime+1;
    end
end
    
    
endmodule
