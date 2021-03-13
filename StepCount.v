`timescale 1ns / 1ps

module StepCount(
        input lightClk, reset, start, startCount,
        output [15:0]stepCount
    );
    //reg overflowCheck=0;
    reg [15:0] count=0;
    assign stepCount=count;
    //Light pulse when start is high
/*
always@(startCount) begin
    if(startCount==0) count=0;
    else count=count;
 end
 */
 /*
 always@(start) begin
    if (!start) count=0;
    overflowCheck=0;
end
 */
always@(posedge lightClk) begin
    if (!start||reset||!startCount) count=0;
    else begin 
        count=count+1;
//        if(count>9999) overflowCheck=1;
//        else overflowCheck=0; 
    end
end
    
    
    
endmodule
