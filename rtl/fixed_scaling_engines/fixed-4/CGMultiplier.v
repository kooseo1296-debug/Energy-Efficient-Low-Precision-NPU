`include "param.v"

module CGMultiplier(
    input CLK,
    input [`BIT_DATA_C-1:0] Input, Weight,
    input Do_Compute,
    output [`BIT_DATA*2-1:0] Output
    );
    
    reg [2*(`BIT_DATA_C-1)-1:0] Mult;
    reg Sign;
    always @(posedge CLK) begin
        if (Do_Compute) begin
            Mult <= Input[`BIT_DATA_C-2:0]*Weight[`BIT_DATA_C-2:0];
            Sign <= Input[`BIT_DATA_C-1]^Weight[`BIT_DATA_C-1];
        end
    end
    
    assign Output[2*(`BIT_DATA-`BIT_DATA_C+1)-1:0] = {(2*(`BIT_DATA-`BIT_DATA_C+1)){1'b0}};
    assign Output[`BIT_DATA*2-1:2*(`BIT_DATA-`BIT_DATA_C+1)] = Sign ? ~Mult + 1'b1 : Mult;
    
endmodule
