`timescale 1ns / 1ps

module SevSegDisplay(
    input [15:0] inVal,
    input reset, clk,altIn,
    output reg [3:0] an, //anode signal controller
    output reg [6:0] seg //LED signal controller
    );
    wire slow_clk;
    clkdiv cl (clk, reset, slow_clk);
    reg [15:0] sw=0;
    reg[3:0] binaryVal[3:0];
    reg [3:0]underBar= 4'b1010; 
    
    reg [2:0]anOrder;  
    reg [2:0] nextOrder;

   wire [6:0] data0;
   wire [6:0] data1;
   wire [6:0] data2;
   wire [6:0] data3;
   
   always@(inVal) begin
        binaryVal[0]=inVal/1000;
        binaryVal[1]=(inVal/100)%10;
        binaryVal[2]=(inVal/10)%10;
        binaryVal[3]=inVal%10;
    end   
   

   always @ (posedge slow_clk) begin
        anOrder<=nextOrder;     
        if(altIn)   sw[15:0]={binaryVal[1],binaryVal[2],4'b1010,binaryVal[3]};
        else        sw={binaryVal[0],binaryVal[1],binaryVal[2],binaryVal[3]};
    end
    SevSeg bcd0(sw[15:12], data0);
   SevSeg bcd1(sw[11:8], data1);
   SevSeg bcd2(sw[7:4], data2);
   SevSeg bcd3(sw[3:0], data3);   
   
   
   //Cycle through the 4 digits by activating each an, update output seg 
    always @(*) begin
        case (anOrder)
            3'b000: begin
                an=4'b0111;//0th Activate
                seg<=data0;
                if (reset)  nextOrder=3'b111;
                else        nextOrder= 3'b001;
                end
                    
            3'b001: begin
                an=4'b1011; //1st Activate
                seg<=data1;
                if (reset)  nextOrder=3'b111;
                else        nextOrder=3'b010;
                end
                
             3'b010: begin
                an=4'b1101;//2nd Activate.
                seg<=data2;
                if (reset)  nextOrder=3'b111;
                else        nextOrder=3'b011;
                end
                    
            3'b011: begin
                an=4'b1110; //3rd Activate
                seg<=data3;
                if(reset)   nextOrder=3'b111;
                else        nextOrder=3'b000;
                end               
            
            3'b111: begin
                an=4'b1111; //no output
                //seg<=data0;
                if (reset)  nextOrder=3'b111;
                else        nextOrder=3'b000;
                end
                  
            default: begin
                nextOrder=3'b000;
            end
                
        endcase
    end
            
    
       
    
endmodule
