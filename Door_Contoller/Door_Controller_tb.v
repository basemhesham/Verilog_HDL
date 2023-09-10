module Door_Controller_tb ;


////////////////////////////////////////////////////////
/////////////////// DUT Signals //////////////////////// 
////////////////////////////////////////////////////////

reg        CLK_tb       ;
reg        RST_tb       ;
reg        Activate_tb  ;
reg        Up_Max_tb    ;
reg        Dn_Max_tb    ;
wire       Up_M_tb      ;
wire       Dn_M_tb      ;

 
////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
 begin
   
 // Save Waveform
   $dumpfile("DOOR_CONTROLLER.vcd") ;       
   $dumpvars; 
 

 // initialization
   initialize();

 // Reset
   reset();

 // Activate Motors
   Activate(); 

 // check Up Motor is Working and Down Motor is Stoping
   check(1'b1,1'b0);

 // Up Sensor
   Up_Sensor();

 // Activate Motors
   Activate(); 

 // check Up Motor is Stoping and Down Motor is Working 
   check(1'b0,1'b1);

 // Down Sensor
   Down_Sensor();

#100

  $finish ;
 
 end  


////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize;
 begin
  Activate_tb  = 1'b0  ;
  CLK_tb     = 1'b1    ;
  Up_Max_tb  = 1'b0    ;
  Dn_Max_tb  = 1'b1    ;         // initially door is competely closed
 end
endtask

///////////////////////// RESET /////////////////////////
  
task reset;
 begin
 RST_tb =  'b1;
 #1
 RST_tb  = 'b0;
 #1
 RST_tb  = 'b1;
 end
endtask  

////////////////////// Activate Motors /////////////////////
  
task Activate ();
  
begin
 Activate_tb = 1'b1 ;
 #30
 Activate_tb = 1'b0 ;             // behaviour of push button pressed then released 
end

endtask  

/////////////////////// Up Sensor ////////////////////////
  
task Up_Sensor ();

begin 
#60                  // Time for the up motor to competely open the door
Up_Max_tb = 1'b1 ;  
Dn_Max_tb = 1'b0 ;
end

endtask  

//////////////////////// Down Sensor /////////////////////
  
task Down_Sensor ();
  
begin 
#40                  // Time for the down motor to competely close the door
Up_Max_tb = 1'b0 ; 
Dn_Max_tb = 1'b1 ;
end


endtask  

////////////////////// Check Output /////////////////////
 
task check (
  input   reg   Up_M      ,
  input   reg   Dn_M      
);
  
begin
    if(Up_M_tb == Up_M &&  Dn_M_tb == Dn_M)   
     begin
      $display("Motors are Working Corectly");
     end  
    else
     begin
      $display("Motors are not Working Corectly");
     end          
end

endtask  
 
////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #10  CLK_tb = !CLK_tb ;   // period = 20 ns (50 MHz)
  
////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////

Door_Controller DUT (
.CLK(CLK_tb),
.RST(RST_tb),
.Activate(Activate_tb),
.Up_Max(Up_Max_tb),
.Dn_Max(Dn_Max_tb),
.Up_M(Up_M_tb),
.Dn_M(Dn_M_tb)
);

 
endmodule
