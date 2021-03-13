`timescale 1ns / 1ps

module StepCount(
        input lightClk, reset, start, startCount,
        output [15:0]stepCount
    );
    reg overflowCheck;
    reg [15:0] count;
    assign stepCount=count;
    //Light pulse when start is high
//always@(startCount) begin
//    if(startCount==0) count=0;
//    else count=count;
// end
// always@(start) begin
//    if (!start) count=0;
//    overflowCheck=0;
//end
 
always@(posedge lightClk) begin
    if (!start||reset||!startCount) count=0;
    else begin 
        count=count+1;
    end
end
    
    
    
endmodule
