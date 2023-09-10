
`timescale 1ns/1ps

module CRC_TB ();

/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter  DATA_WD_TB  = 8 ;      // Could be 1 Byte - 4 Bytes 
parameter  CRC_WD_TB   = 8 ;
parameter  CLK_PERIOD  = 100 ; 
parameter  Test_Cases  = 10 ;


/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////


reg            CLK_TB      ;          
reg            RST_TB      ;          
reg            DATA_TB     ;         
reg            ACTIVE_TB   ;      
wire           CRC_TB      ;         
wire           Valid_TB    ;


/////////////////////////////////////////////////////////
///////////////// Loops Variables ///////////////////////
/////////////////////////////////////////////////////////

integer              TEST_NUM ;

/////////////////////////////////////////////////////////
/////////////////////// Memories ////////////////////////
/////////////////////////////////////////////////////////

reg    [DATA_WD_TB-1:0]   DATA_IN      [Test_Cases-1:0] ;
reg    [CRC_WD_TB-1:0]    Expec_Outs   [Test_Cases-1:0] ;

////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
 begin
 
 // System Functions
 $dumpfile("CRC_DUMP.vcd") ;       
 $dumpvars; 
 
 // Read Input Files
 $readmemh("DATA_h.txt", DATA_IN);
 $readmemh("Expec_Out_h.txt", Expec_Outs);

 // Initialization
 initialize() ;


 // Test Cases
 for (TEST_NUM=0;TEST_NUM<Test_Cases;TEST_NUM=TEST_NUM+1)
  begin
   reset() ;                                          // Reset the design to initialize the LFSR with the SEED
   data_ld(DATA_IN[TEST_NUM]) ;                       // Load Data into LFSR
   chk_crc_out(Expec_Outs[TEST_NUM],TEST_NUM) ;       // check CRC out
  end

 #100
 $stop ;

 end	 

///////////////////// Clock Generator //////////////////

always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB ;


////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
  begin
	CLK_TB    = 1'b0  ;
	RST_TB    = 1'b1  ;    // rst is deactivated
	DATA_TB   = 1'b0  ;
	ACTIVE_TB = 1'b0  ;
  end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
 begin
  #(CLK_PERIOD)
  RST_TB  = 'b0;           // rst is activated
  #(CLK_PERIOD)
  RST_TB  = 'b1;
  #(CLK_PERIOD) ;
 end
endtask

////////////////// Do LFSR TEST_NUM ////////////////////

task data_ld ;
 input  [DATA_WD_TB-1:0]  DATA ;

 integer   i  ;

 begin
	ACTIVE_TB = 1'b1 ;
	
	for (i=0;i<DATA_WD_TB;i=i+1)
		begin
		DATA_TB = DATA[i] ;
		#CLK_PERIOD ;
		end

	ACTIVE_TB = 1'b0 ;
 end
endtask

//////////////////  Check CRC Out  ////////////////////

task chk_crc_out ;
 input           [CRC_WD_TB-1:0]     CRC_BITS ;
 input  integer                      Test_NUM ; 

 reg             [CRC_WD_TB-1:0]     gener_out ;

 integer   i  ;

 begin
 
	@(posedge Valid_TB)
	for(i=0; i<CRC_WD_TB; i=i+1)
		begin
		#CLK_PERIOD gener_out[i] = CRC_TB ;
		end

	if(gener_out == CRC_BITS) 
		begin
			$display("Test Case %d is succeeded",Test_NUM);
		end
	else
		begin
			$display("Test Case %d is failed", Test_NUM);
		end
 end
endtask


// Design Instaniation
CRC DUT (
.CLK(CLK_TB),           
.RST(RST_TB),           
.DATA(DATA_TB),         
.ACTIVE(ACTIVE_TB),       
.CRC(CRC_TB),          
.Valid(Valid_TB)
);

endmodule