`include "param.v"

module ZeroMask (
    input [`BIT_DATA_C-1:0] Input,
    input Disable,
    output [`BIT_DATA_C-1:0] Output
);

assign Output = (Disable) ? Input : `BIT_DATA_C'd0;

endmodule
