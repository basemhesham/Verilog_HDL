module ALU_TOP 

#( parameter IN_DATA_WIDTH   = 16 ,
             Arith_OUT_WIDTH = 32 , 
             Logic_OUT_WIDTH = 16 ,
             Shift_OUT_WIDTH = 16 ,
             CMP_OUT_WIDTH = 3 			 
)

(
input  wire [IN_DATA_WIDTH-1:0]   A , B   ,
input  wire [3:0]                  ALU_FUNC ,
input  wire                        CLK ,
input  wire                        RST ,
output wire [Arith_OUT_WIDTH-1:0]  Arith_OUT,
output wire                        Carry_OUT,
output wire                        Arith_Flag,
output wire [Logic_OUT_WIDTH-1:0]  Logic_OUT,
output wire                        Logic_Flag,
output wire [Shift_OUT_WIDTH-1:0]  Shift_OUT,
output wire                        Shift_Flag,
output wire [CMP_OUT_WIDTH-1:0]    CMP_OUT,
output wire                        CMP_Flag
);

// internal connection
wire        CMP_Enable ;
wire        Shift_Enable ;
wire        Logic_Enable ;
wire        Arith_Enable ;

Decoder U0 (
.IN(ALU_FUNC[3:2]),
.OUT({Shift_Enable,CMP_Enable,Logic_Enable,Arith_Enable})
);


ARITHMETIC_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH), .OUT_DATA_WIDTH(Arith_OUT_WIDTH)) U0_ARITHMETIC_UNIT (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.Arith_Enable(Arith_Enable),
.Arith_OUT(Arith_OUT),
.Carry_OUT(Carry_OUT),
.Arith_Flag(Arith_Flag)
);

LOGIC_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH), .OUT_DATA_WIDTH(Logic_OUT_WIDTH)) U0_LOGIC_UNIT (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.Logic_Enable(Logic_Enable),
.Logic_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)
);


  
SHIFT_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH), .OUT_DATA_WIDTH(Shift_OUT_WIDTH)) U0_SHIFT_UNIT (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.Shift_Enable(Shift_Enable),
.Shift_OUT(Shift_OUT),
.Shift_Flag(Shift_Flag)
);

CMP_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH), .OUT_DATA_WIDTH(CMP_OUT_WIDTH)) U0_CMP_UNIT (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.CMP_Enable(CMP_Enable),
.CMP_OUT(CMP_OUT),
.CMP_Flag(CMP_Flag)
);


endmodule