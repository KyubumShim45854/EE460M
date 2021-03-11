`timescale 1ns / 1ps

module StepCount(
        input lightClk, reset, start, startCount,
        output reg [15:0]count
    );

    
    //Light pulse when start is high
always@(startCount) begin
    if(startCount==0) count=0;
    else count=count;
 end
 always@(start) if (!start) count=0;
 
always@(posedge lightClk) begin
    if (!start||reset) count=0;
    else begin 
        count=count+1;
    end
end
    
    
    
endmodule
