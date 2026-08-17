`include "param.v"

module CGPE(
    input CLK,
    input RST,
    input signed [`BIT_DATA-1:0] Input,
    output reg [`BIT_DATA_C-1:0] Output
    );
    integer i;
    wire [`BIT_DATA-1:0] Absolute;
    wire [`EXP-1:0] Exponent, Exponent_0;
    wire [`MAN-1:0] Mantissa, Mantissa_0;
    wire [`MAN:0] Mantissa_1;
    wire RoundUp;
    
    assign Absolute = (Input[`BIT_DATA-1]) ? -Input : Input;
    
    assign Exponent_0 = (Absolute[`BIT_DATA-1]) ? `EXP'd5: 
                      (Absolute[`BIT_DATA-2]) ? `EXP'd4: 
                      (Absolute[`BIT_DATA-3]) ? `EXP'd3: 
                      (Absolute[`BIT_DATA-4]) ? `EXP'd2:
                      (Absolute[`BIT_DATA-5]) ? `EXP'd1: `EXP'd0;
    
    assign Mantissa_0 = (Exponent_0 == `EXP'd0) ? {1'b0,Absolute[`MAN-1:0]} :
                      (Exponent_0 == `EXP'd1) ? {1'b0,Absolute[`MAN:1]} :
                      (Exponent_0 == `EXP'd2) ? {1'b0,Absolute[`MAN+1:2]} : 
                      (Exponent_0 == `EXP'd3) ? {1'b0,Absolute[`MAN+2:3]} : 
                      (Exponent_0 == `EXP'd4) ? {1'b0, Absolute[`MAN+3:4]} : {1'b0, Absolute[`MAN+4:5]};
    
    assign RoundUp = (Exponent_0 == `EXP'd1) ? Absolute[0] :
                     (Exponent_0 == `EXP'd2) ? Absolute[1] : 
                     (Exponent_0 == `EXP'd3) ? Absolute[2] : 
                     (Exponent_0 == `EXP'd4) ? Absolute[3] : 1'b0;
    
    assign Mantissa_1 = Mantissa_0 + RoundUp;
    
    assign Mantissa = (Mantissa_1[`MAN]) ? Mantissa_1[`MAN:1] : Mantissa_1[`MAN-1:0];
    assign Exponent = Mantissa_1[`MAN] + Exponent_0;
                      
    always @(posedge CLK) begin
        if(~RST) Output <= {Input[`BIT_DATA-1], Exponent, Mantissa};
        else Output <= `BIT_DATA_C'd0;
    end
    
endmodule