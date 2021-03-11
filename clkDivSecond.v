`timescale 1ns / 1ps
//100MHz-> 100 000 000
//Div 2 ->  50 000 000
module clkDivSecond(
    input clk,reset, [7:0]div,
    output slow_clk
    );
    
    reg [25:0] count; //10111110101111000010000000
    reg outSig =0;
    assign slow_clk=outSig;   
    initial  count = 0;
    
    always @ (posedge clk) begin
       if(div)begin
           if (reset) begin 
            count<=0;
            outSig=0;
           end  
           //26'b10111110101111000010000000
           else if(count>=(25000/div))begin
                outSig=outSig^1;
                count=0;
            end
            else count=(count+1);
    end
        else outSig=0;
    end
endmodule