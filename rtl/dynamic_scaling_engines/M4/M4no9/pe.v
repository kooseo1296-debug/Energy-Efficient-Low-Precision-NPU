`include "param.v"

module pe(
    input CLK,
    input [`BIT_ROW_ID-1:0] Row_ID,
    input /*signed*/ [`BIT_DATA-1:0] Data_I_In, Data_W_In,
    output reg signed [`BIT_DATA-1:0] Data_I_Out, Data_W_Out,
    input EN_W_In,
    output reg EN_W_Out,
    input [`BIT_ROW_ID-1:0] EN_ID_In,
    output reg [`BIT_ROW_ID-1:0] EN_ID_Out,
    input signed [`BIT_PSUM-1:0] Psum_In,
    output signed [`BIT_PSUM-1:0] Psum_Out,

    input [`BIT_ADDR-1:0]   Addr_P_In,
    input [`BIT_VALID-1:0]  Valid_P_In,
    output reg [`BIT_ADDR-1:0]   Addr_P_Out,
    output reg [`BIT_VALID-1:0]  Valid_P_Out,
    //Zero-Skip -----------------------------------------
    input ZeroFlag_In,
    output reg ZeroFlag_Out,
    input ZeroFlag_Weight_In,
    output reg ZeroFlag_Weight_Out
    //---------------------------------------------------
    );

reg /*signed*/ [`BIT_DATA-1:0] Data_W_Buf;
//Zero-Skip ---------------------------------------------
reg ZeroFlag_Weight_Buf;
//-------------------------------------------------------

reg signed [`BIT_PSUM-1:0] Psum_RAW;
wire [`BIT_DATA*2-1:0] Psum_Multiplied;

/*
wire ZeroFlag_Weight_Buf;
assign ZeroFlag_Weight_Buf = (Data_W_Buf == `BIT_DATA'd0);
*/

wire Do_Compute = (~ZeroFlag_In) & Valid_P_In & (~ZeroFlag_Weight_Buf);
reg Do_Compute_1;

CGMultiplier Multiplier(
    .CLK(CLK),
    .Do_Compute(Do_Compute),
    .Input(Data_I_In),
    .Weight(Data_W_Buf),
    .Output(Psum_Multiplied)
    );

wire signed [`BIT_DATA*2-1:0] Gated_Multiplied = Psum_Multiplied & {(`BIT_DATA*2){Do_Compute_1}};
assign Psum_Out = Gated_Multiplied + Psum_RAW;


always @(posedge CLK) begin
    Data_I_Out <= Data_I_In;
    Data_W_Out <= Data_W_In;
    EN_W_Out <= EN_W_In;
    EN_ID_Out <= EN_ID_In;
    Addr_P_Out <= Addr_P_In;
    Valid_P_Out <= Valid_P_In;
    Do_Compute_1 <= Do_Compute;
    ZeroFlag_Out <= ZeroFlag_In;
    ZeroFlag_Weight_Out <= ZeroFlag_Weight_In;
    
    if (Valid_P_In) Psum_RAW <= Psum_In;
    
    if (EN_W_In & (EN_ID_In == Row_ID)) begin
        Data_W_Buf <= Data_W_In; 
        ZeroFlag_Weight_Buf <= ZeroFlag_Weight_In;
    end

end

endmodule


