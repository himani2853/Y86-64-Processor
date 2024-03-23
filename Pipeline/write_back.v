module write_back
(
    input clk,
    input [1:0] W_stat,
    input [3:0] W_icode,
    input [63:0] W_valE,
    input [63:0] W_valM,
    input [3:0] W_dstE,
    input [3:0] W_dstM
);

reg [63:0] register_file[0:15];
reg [3:0] icode;
reg [63:0] valE;
reg [63:0] valM;
// reg [2:0] w_stat;
// reg [3:0] reg_to_writeE;
// reg [3:0] reg_to_writeM;

// always @(posedge clk ) begin
//     $readmemh("reg_file.txt",register_file);
// end

always @(*) begin
    $writememh("reg_file.txt",register_file);
end

always @(*) begin
    icode <= W_icode;
    valE <= W_valE;
    valM <= W_valM;
    // reg_to_writeE <= W_dstE;
    // reg_to_writeM <= W_dstM;
end


always @(*) begin
        if(icode == 4'b0010) //cmovxx
    begin
        register_file[W_dstE] <= valE;
    end

    else if(icode == 4'b0011) //irmovq
    begin
      register_file[W_dstE] <= valE;
    end
    // else if(icode == 4'b0100) //rmmovq 
    // begin
    //   valA = register_file[rA];
    //   valB = register_file[rB];
    // end
    
    else if(icode == 4'b0101) //mrmovq
    begin
      register_file[W_dstM] <= valM;
    end
   
    else if(icode == 4'b0110) // opq
    begin
      register_file[W_dstE] <= valE;
    end
    
    else if(icode == 4'b1010) // pushq
    begin
        // 4 -> W_dstE
      register_file[4] <= valE;
    end
   
    else if(icode == 4'b1011) // popq
    begin
      register_file[W_dstM] <= valM;
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