`timescale 1ns/1ps

module  RegFile_tb ;

/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter WIDTH = 16 ;
parameter ADDR = 3 ;
parameter Clock_PERIOD = 10;

/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////


 reg                   CLK ;
 reg                   RST ;
 reg   [ADDR-1 : 0]    Address ;
 reg                   WrEn ;
 reg                   RdEn ;
 reg   [WIDTH-1 : 0]   WrData ;
 wire  [WIDTH-1 : 0]   RdData ;
 
 
 ////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
 begin
 
 // System Functions
 $dumpfile("RegFile_DUMP.vcd") ;       
 $dumpvars; 
 
 // initialization
 initialize();
 
 // RST Activation
 reset();
 
 
//Register Write Operations

do_write('b111,'b01) ;             // first argument is the write address & second argument is the data

do_write('b001,'b11100) ;

do_write('b101,'b1010) ;



//Register Read Operations

do_read_and_check ('b111,'b01) ;    // first argument is the read address & second argument is the expected data

do_read_and_check ('b001,'b11100) ;

do_read_and_check ('b101,'b1010) ;
   

#(10 * Clock_PERIOD)

$finish ;

end
 
 
 ////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
  begin
    CLK       = 1'b0   ;
    RST       = 1'b0   ;
    Address   = 3'b000 ;
    WrEn      = 1'b0   ;
    RdEn      = 1'b0   ;
  end
endtask



///////////////////////// RESET /////////////////////////

task reset ;
 begin
  RST =  'b1;
  #(Clock_PERIOD)
  RST  = 'b0;
  #(Clock_PERIOD)
  RST  = 'b1;
 end
endtask


////////////////// Do write Operation ////////////////////

task do_write ;
 input  [ADDR-1:0]     address ;
 input  [WIDTH-1:0]    data ;
 
 begin
  #Clock_PERIOD
  WrEn = 1'b1;
  RdEn = 1'b0 ;
  Address = address;
  WrData = data;
 end
endtask

/////////////// Do read Operation & Check /////////////////

task do_read_and_check ;
 input  [ADDR-1:0]     address ;
 input  [WIDTH-1:0]    expected_data ;
 
 begin

 #Clock_PERIOD
 WrEn = 1'b0 ;
 RdEn = 1'b1 ;
 Address = address;
 #Clock_PERIOD
  if(RdData != expected_data)
    $display("READ Operation IS Failed");
  else
   $display("READ Operation IS Passed");
 
 end
endtask

 ////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #(Clock_PERIOD/2)  CLK = ~CLK ;



////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////

RegFile DUT
(
.CLK(CLK),
.RST(RST),
.Address(Address),
.WrEn(WrEn),
.RdEn(RdEn),
.WrData(WrData),
.RdData(RdData)
);


endmodule


