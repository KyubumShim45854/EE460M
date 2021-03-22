`timescale 1ns / 1ps

module checkOverflow(
    input reset, 
    input [15:0] stepCount,
    output overflow
    );
    reg check=0;
    always @ (stepCount,reset)    begin
        if (reset) check<=0;
        else if(stepCount>9999) check<=1;
    end
        
    assign overflow=check;
endmodule
