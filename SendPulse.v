`timescale 1ns / 1ps
module SendPulse(
    input [1:0] mode,
    input clk, reset, start,
    output lightOut, secondOut,
    output reg startCount,
    output [9:0] ppm
    //Max Step Count: 7 Seg can only accept up to FFFF
    );
    reg [7:0] beat=0;
    reg [7:0] pulse [13:0];
    reg [8:0]sec=0;
    wire secondClk;
    assign secondOut=secondClk;
    clkDivSecond secClock(clk, 8'b1, secondClk);
    wire lightClk;
    //No issue with Div by 0
    clkDivSecond ltClock(clk, beat,lightClk);
    assign lightOut=lightClk;
    assign ppm= beat;
    reg [15:0] count=0;
    assign stepCount=count;
    
    //Change mode when mode changes
always @(mode) begin
   case(mode)
//Walk
       2'b00: begin 
        pulse[0]=8'd32;
        end
//Jog
      2'b01: pulse[0]=8'd64;
//Run
       2'b10: pulse[0]=8'd128;
//Hybrid
       2'b11: begin
        pulse[0]=8'd0;
        end
       default: pulse[0]=8'd32;
     endcase
     
    pulse[1]=8'd20;
    pulse[2]=8'd33;
    pulse[3]=8'd66;
    pulse[4]=8'd27;
    pulse[5]=8'd70;
    pulse[6]=8'd30;
    pulse[7]=8'd19;
    pulse[8]=8'd30;
    pulse[9]=8'd33;
    pulse[10]=8'd69;
    pulse[11]=8'd34;
    pulse[12]=8'd124;
    pulse[13]=8'd0;
 
 end

//No issue with Div by 0        
always @(posedge secondClk) begin
    if(reset) begin sec=0; beat=0; sec=0; startCount=0; end
//    else if(reset) begin sec=0; startCount=0; end
    else begin
        startCount=1;        
        if(!start) sec=sec+1;
        if(pulse[0]==0) begin        
            if ((sec>=1)&&(sec<=9)) beat=pulse[sec];
            else if((sec>=10)&&(sec<=73)) beat=pulse[10];
            else if((sec>=74)&&(sec<=79)) beat=pulse[11];
            else if((sec>=80)&&(sec<=144)) beat=pulse[12];
            else beat=8'd0;
        end
        else beat=pulse[0];
    end   
end

 
endmodule
