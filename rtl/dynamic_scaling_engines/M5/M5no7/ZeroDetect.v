`include "param.v"
(* keep_hierarchy = "yes" *)
module ZeroDetect(
    input [`MAN-1:0] Input,
    output ZeroFlag
    );
    
assign ZeroFlag = (Input == `MAN'd0);
    
endmodule
