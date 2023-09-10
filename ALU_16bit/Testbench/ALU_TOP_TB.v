`timescale 1us/1us

module ALU_TOP_TB();

/*************************************************************************/
/****************************** TB Parameters ****************************/
/*************************************************************************/

parameter    IN_DATA_WIDTH_TB   = 16 ;
parameter    Arith_OUT_WIDTH_TB = 32 ; 
parameter    Logic_OUT_WIDTH_TB = 16 ;
parameter    Shift_OUT_WIDTH_TB = 16 ;
parameter    CMP_OUT_WIDTH_TB   = 3 	;	 


// Clock Period
parameter  CLK_PERIOD  = 10 ;
      
      		   		   
/*************************************************************************/
/******************************** TB Signals *****************************/
/*************************************************************************/

   reg     [IN_DATA_WIDTH_TB-1:0]       A_TB         ;
   reg     [IN_DATA_WIDTH_TB-1:0]       B_TB         ;
   reg     [3:0]                     ALU_FUNC_TB  ;
   reg                               CLK_TB       ;
   reg                               RST_TB       ;
   wire    [Arith_OUT_WIDTH_TB-1:0]  Arith_OUT_TB ;
   wire                              Carry_OUT_TB ;
   wire                              Arith_Flag_TB;
   wire    [Logic_OUT_WIDTH_TB-1:0]  Logic_OUT_TB ;
   wire                              Logic_Flag_TB;
   wire    [Shift_OUT_WIDTH_TB-1:0]  Shift_OUT_TB ;
   wire                              Shift_Flag_TB;
   wire    [CMP_OUT_WIDTH_TB-1:0]    CMP_OUT_TB   ;
   wire                              CMP_Flag_TB  ;
   
   
  
//concatenate flags
  wire [4:0] Flags ;

assign Flags = {Carry_OUT_TB , Arith_Flag_TB , Logic_Flag_TB , CMP_Flag_TB , Shift_Flag_TB};
 
    
  
initial
  begin
    $dumpfile("ALU.vcd");
    $dumpvars ;

//initial values
CLK_TB = 1'b0;
RST_TB = 1'b1;

// RST Activation
#CLK_PERIOD
RST_TB = 1'b0 ;

// RST De-activation
#CLK_PERIOD
RST_TB = 1'b1 ;
    
    $display ("*** TEST CASE 1 ***");
    
A_TB = 'd15;
B_TB = 'd10;
ALU_FUNC_TB = 4'b0000; 

#CLK_PERIOD
    
   if (Arith_OUT_TB == 'd25 && Flags == 5'd8)
       $display ("Addition IS PASSED") ;
   else
      begin
       $display ("Addition IS FAILED") ;
      end
    
    

    $display ("*** TEST CASE 2 ***") ;

   A_TB = 'd15;
   B_TB = 'd10;
   ALU_FUNC_TB = 4'b0001; 

#CLK_PERIOD
    
   if (Arith_OUT_TB == 'd5 && Flags == 5'd8)      
      $display ("Subtraction IS PASSED") ; 
   else
      $display ("Subtraction IS FAILED") ;

    
    $display ("*** TEST CASE 3 ***") ;

A_TB = 'd15;
B_TB = 'd10;
ALU_FUNC_TB = 4'b0010; 

#CLK_PERIOD
    
    if (Arith_OUT_TB == 'd150 && Flags == 5'd8)         
    $display ("Multiplication IS PASSED") ; 
   else
     $display ("Multiplication IS FAILED") ;
    
    
    $display ("*** TEST CASE 4 ***") ;
    
A_TB = 'd150;
B_TB = 'd10;
ALU_FUNC_TB = 4'b0011;     

#CLK_PERIOD
    
   if (Arith_OUT_TB == 'd15 && Flags == 5'd8)         
    $display ("Division IS PASSED") ; 
   else
     $display ("Division IS FAILED") ;   

    
    $display ("*** TEST CASE 5 ***") ;
 
A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b0100;  

#CLK_PERIOD
        
   if (Logic_OUT_TB == 'b0001 && Flags == 5'd4)     
    $display ("ANDING IS PASSED") ; 
   else
     $display ("ANDING IS FAILED") ;

    
    $display ("*** TEST CASE 6 ***") ;

A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b0101;  

#CLK_PERIOD
        
   if (Logic_OUT_TB == 'b1011 && Flags == 5'd4)   
    $display ("ORING IS PASSED") ; 
   else
     $display ("ORING IS FAILED") ;

    
    $display ("*** TEST CASE 7 ***") ;
 
A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b0110;  

#CLK_PERIOD
        
   if (Logic_OUT_TB == 'hfffe && Flags == 5'd4)      
    $display ("NANDING IS PASSED") ; 
   else
     $display ("NANDING IS FAILED") ;

    
    $display ("*** TEST CASE 8 ***") ;

A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b0111;  

#CLK_PERIOD
        
   if (Logic_OUT_TB == 'hfff4 && Flags == 5'd4)   
    $display ("NORING IS PASSED") ; 
   else
     $display ("NORING IS FAILED") ;

    
    $display ("*** TEST CASE 9 ***") ;

A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1000;  

#CLK_PERIOD
        
   if (CMP_OUT_TB == 3'b0 && Flags == 5'd2)    
    $display ("NOP IS PASSED") ; 
   else
     $display ("NOP IS FAILED") ;


    $display ("*** TEST CASE 10 ***") ;

A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1001;  

#CLK_PERIOD
        
    if (CMP_OUT_TB == 3'b0 && Flags == 5'd2)    
     $display ("CMP_EQ IS PASSED") ; 
   else
     $display ("CMP_EQ IS FAILED") ;
    
    
    $display ("*** TEST CASE 11 ***") ;

A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1010;  

#CLK_PERIOD
        
    if (CMP_OUT_TB == 3'b10 && Flags == 5'd2)   
    $display ("CMP_GR IS PASSED") ; 
   else
     $display ("CMP_GR IS FAILED") ;

    
    $display ("*** TEST CASE 12 ***") ;

A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1011;  

#CLK_PERIOD
        
    if (Arith_OUT_TB == 3'b0 && Flags == 5'd2) 
    $display ("CMP_LS IS PASSED") ; 
   else
     $display ("CMP_LS IS FAILED") ;

    
    $display ("*** TEST CASE 13 ***") ;
 
A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1100;  

#CLK_PERIOD
        
    if (Shift_OUT_TB == 'b0100 && Flags == 5'd1)  
    $display ("A_SF_R IS PASSED") ; 
   else
     $display ("A_SF_R IS FAILED") ;

    
    $display ("*** TEST CASE 14 ***") ;
 
A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1101;  

#CLK_PERIOD
        
    if (Shift_OUT_TB == 'b10010 && Flags == 5'd1)    
    $display ("A_SF_L IS PASSED") ; 
   else
     $display ("A_SF_L IS FAILED") ;

    
    $display ("*** TEST CASE 15 ***") ;
 
A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1110;  

#CLK_PERIOD
        
    if (Shift_OUT_TB == 'b01 && Flags == 5'd1)    
    $display ("B_SF_R IS PASSED") ; 
   else
     $display ("B_SF_R IS FAILED") ;	 

    
    $display ("*** TEST CASE 16 ***") ;
 
A_TB = 'b1001;
B_TB = 'b0011;
ALU_FUNC_TB = 4'b1111;  

#CLK_PERIOD
        
   if (Shift_OUT_TB == 'b0110 && Flags == 5'd1)    
    $display ("B_SF_L IS PASSED") ; 
   else
     $display ("B_SF_L IS FAILED") ;	 
	 
   #100 $finish;  //finished with simulation 
  end
  
  
// Clock Generator 
  always   #(CLK_PERIOD/2) CLK_TB = ~ CLK_TB ;
   

// instantiate Design Unit
ALU_TOP DUT (
.A(A_TB), 
.B(B_TB),
.ALU_FUNC(ALU_FUNC_TB),
.CLK(CLK_TB),
.RST(RST_TB),
.Arith_OUT(Arith_OUT_TB),
.Carry_OUT(Carry_OUT_TB),
.Arith_Flag(Arith_Flag_TB),
.Logic_OUT(Logic_OUT_TB),
.Logic_Flag(Logic_Flag_TB),
.Shift_OUT(Shift_OUT_TB),
.Shift_Flag(Shift_Flag_TB),
.CMP_OUT(CMP_OUT_TB),
.CMP_Flag(CMP_Flag_TB)
);

endmodule