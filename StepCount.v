`timescale 1ns / 1ps

module StepCount(
        input lightClk, reset, start, startCount,
        output [15:0]stepCount
        //output SI
    );
    //reg overflowCheck;
    //assign SI = overflowCheck;
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
    if (reset||!startCount) begin
        count=0;
 //       overflowCheck=0;
    end
    else begin 
        if(start) count=count+1;
   //     if(count>=15'b010011100001111) overflowCheck=1;
    end
end
    
    
    
endmodule
