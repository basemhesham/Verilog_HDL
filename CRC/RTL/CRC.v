
module CRC #( parameter SEED = 8'hD8) 

  ( 
   input      wire          CLK ,          // module operating clock
   input      wire          RST ,          // module reset to intialize the LFSR
   input      wire          DATA ,         // input serial data 
   input      wire          ACTIVE ,       // high signal during  data transaction, low otherwise
   output     reg           CRC ,          // serial output CRC bits
   output     reg           Valid          // high during output transmission, low otherwise 
            );
            

   reg    [7:0]        LFSR ;  
   reg    [4:0]        count ;        
   wire                Feedback ;  
   wire                count_max ;


   // feedback
   assign Feedback = DATA ^ LFSR[0] ;
	  
   always@(posedge CLK or negedge RST)
     begin
        if(!RST)
          begin
             LFSR <= SEED;
             CRC <= 1'b0;
             Valid <= 1'b0;
          end
        else
           if(ACTIVE)      
             begin 
           LFSR <= {Feedback, LFSR[7] ^ Feedback , LFSR[6:4], LFSR[3] ^ Feedback, LFSR[2:1]} ;
              
              Valid <= 1'b0; 			  
             end 
           else if(!count_max)
             begin
             {LFSR,CRC} <= {1'b0 , LFSR} ;
              Valid <= 1'b1 ; 
             end 
           else
             begin
              Valid <=1'b0 ; 
              CRC <= 1'b0 ;
             end                  
     end 
		
    // counter to count the output bits to high Valid flag after finish   
     always@(posedge CLK or negedge RST)
       begin
          if(!RST)
            count <= 5'b1000 ;
          else if (ACTIVE)
            count <= 5'b0 ;				
          else if (!count_max)
            count <= count + 5'b1 ;				  
       end
   

   assign count_max = ( count == 5'b1000 ); 
                

   
endmodule
