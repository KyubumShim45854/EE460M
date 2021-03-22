`timescale 1ns / 1ps
module clkdiv(
    input clk,
    input reset,
    output slow_clk
    );
    
    reg [5:0] count; //Div by 5 again
    assign slow_clk=~count[2];   
    initial  count = 5'b00000;
    
    always @ (posedge clk) begin
       if (reset) count<=5'b00000;  
        else if(count==5'b11111) count<=3'b00001;
        else count<=count+5'b001;
    end
endmodule

