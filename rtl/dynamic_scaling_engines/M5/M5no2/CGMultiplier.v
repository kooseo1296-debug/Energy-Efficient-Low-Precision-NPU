`include "param.v"

module CGMultiplier(
    input CLK,
    input [`BIT_DATA-1:0] Input, Weight,
    input Do_Compute,
    output [`BIT_DATA*2-1:0] Output
    );
    wire [`BIT_DATA*2-1:0] Out;
    reg [`MAN*2-1:0] Mantissa;
    reg [`EXP:0] Exponent;
    reg Sign;
    
    always @(posedge CLK) begin
        if (Do_Compute) begin
            Mantissa <= Input[`MAN-1:0]*Weight[`MAN-1:0];
            Exponent <= Input[`MAN+:`EXP] + Weight[`MAN+:`EXP];
            Sign <= Input[`BIT_DATA-1]^Weight[`BIT_DATA-1];
        end
    end
    
    assign Out = Mantissa << Exponent;
    assign Output = Sign ? (~Out)+1'b1 : Out;
                    
endmodule
