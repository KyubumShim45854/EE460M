`timescale 1ns / 1ps
module clkdiv(
    input clk,
    input reset,
    output slow_clk
    );
    
    reg [3:0] count; //Div by 5 again
    assign slow_clk=~count[2];   
    initial  count = 3'b000;
    
    always @ (posedge clk) begin
       if (reset) count<=3'b000;  
        else if(count==3'b101) count<=3'b001;
        else count<=count+3'b001;
    end
endmodule
