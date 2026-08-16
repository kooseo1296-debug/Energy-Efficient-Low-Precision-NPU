`include "param.v"

module pe(
    input CLK,
    input [`BIT_ROW_ID-1:0] Row_ID,
    input /*signed*/ [`BIT_DATA_C-1:0] Data_I_In, Data_W_In,
    output reg [`BIT_DATA_C-1:0] Data_I_Out, Data_W_Out,
    input EN_W_In,
    output reg EN_W_Out,
    input [`BIT_ROW_ID-1:0] EN_ID_In,
    output reg [`BIT_ROW_ID-1:0] EN_ID_Out,
    input signed [`BIT_PSUM-1:0] Psum_In,
    output signed [`BIT_PSUM-1:0] Psum_Out,

    input [`BIT_ADDR-1:0]   Addr_P_In,
    input [`BIT_VALID-1:0]  Valid_P_In,
    output reg [`BIT_ADDR-1:0]   Addr_P_Out,
    output reg [`BIT_VALID-1:0]  Valid_P_Out
    );


reg /*signed*/ [`BIT_DATA_C-1:0] Data_W_Buf;

//wire Do_Compute;
//wire Do_Compute_1;

reg signed [`BIT_PSUM-1:0] Psum_Uncomputed;

wire signed [`BIT_DATA*2-1:0] Psum_Multiplied;

//assign Do_Compute = Valid_P_In; 
//assign Do_Compute_1 = Valid_P_Out;

CGMultiplier Multiplier(
    .CLK(CLK),
    .Do_Compute(Valid_P_In),
    .Input(Data_I_In),
    .Weight(Data_W_Buf),
    .Output(Psum_Multiplied)
    );
    
assign Psum_Out = Psum_Multiplied + Psum_Uncomputed;

always @(posedge CLK) begin
    Data_I_Out <= Data_I_In;
    Data_W_Out <= Data_W_In;
    EN_W_Out <= EN_W_In;
    EN_ID_Out <= EN_ID_In;
    Addr_P_Out <= Addr_P_In;
    Valid_P_Out <= Valid_P_In;
    
    
    if (Valid_P_In) Psum_Uncomputed <= Psum_In;
    
    if (EN_W_In & (EN_ID_In == Row_ID)) Data_W_Buf <= Data_W_In;
    

end

endmodule


