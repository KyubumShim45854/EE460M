`timescale 1ns / 1ps


module pulseCount(
    input lightClk, secondClk,
    output countPulse
    );
    reg [8:0] count;
    reg clearCount=0;
always @ (posedge secondClk) begin
    clearCount=1;
end     
always @ (posedge lightClk) begin
    if(clearCount) begin
        clearCount=0;
        count=0;
    end    
    else
        count=count+1;
    end    

assign countPulse=count;    
    
endmodule
