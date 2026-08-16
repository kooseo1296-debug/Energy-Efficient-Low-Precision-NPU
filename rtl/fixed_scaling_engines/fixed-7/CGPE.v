`include "param.v"

module CGPE(
    input CLK,
    input RST,
    input signed [`BIT_DATA-1:0] Input,
    output reg [`BIT_DATA_C-1:0] Output
    );
    
    wire signed [`BIT_DATA-1:0] Absolute = (Input[`BIT_DATA-1]) ? -Input : Input;
    wire [`BIT_DATA_C-2:0] Mantissa = Absolute[`BIT_DATA-1:`BIT_DATA-`BIT_DATA_C+1] + Absolute[`BIT_DATA-`BIT_DATA_C];
    always @(posedge CLK) begin
        if(~RST) begin
            Output <= {Input[`BIT_DATA-1], Mantissa};
        end
        else Output <= `BIT_DATA_C'd0;
    end
    
endmodule