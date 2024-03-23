module write_back(
    input clk,
    input [3:0] icode,
    input Cnd,
    input [3:0] rA,
    input [3:0] rB,
    input signed [63:0] valE,
    input signed [63:0] valM
);

    reg [63:0] register_file [0:15];

   always@(*) begin
    if (clk == 1)
    begin
      $readmemh("reg_file.txt", register_file);
    end 
        
    end

    always @(*)begin
      if (clk == 0)
      begin
        $writememh("reg_file.txt", register_file);
      end
      
    end
 


always @(negedge clk) begin
  //  if(clk==0)
    // begin
        if(icode == 4'b0010) //cmovxx
    begin
        if(Cnd == 1'b1)
        begin
          register_file[rB] <= valE;
        end
    end

    else if(icode == 4'b0011) //irmovq
    begin
      register_file[rB] <= valE;
    end
    // else if(icode == 4'b0100) //rmmovq 
    // begin
    //   valA = register_file[rA];
    //   valB = register_file[rB];
    // end
    
    else if(icode == 4'b0101) //mrmovq
    begin
      register_file[rA] <= valM;
    end
   
    else if(icode == 4'b0110) // opq
    begin
      register_file[rB] <= valE;
    end
    
    else if(icode == 4'b1010) // pushq
    begin
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1011) // popq
    begin
      register_file[rA] <= valM;
      register_file[4] <= valE;
    end
    
    else if(icode == 4'b1000) // call
    begin
    //   valA = register_file[rA];
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1001) // ret
    begin
      register_file[4] <= valE;
    end
    
  
end
endmodule


