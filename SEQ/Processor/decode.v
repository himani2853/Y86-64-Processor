module decode(
    input clk,
    input [3:0] icode,
    input [3:0] rA,
    input [3:0] rB,
    output reg signed [63:0] valA,
    output reg signed [63:0] valB
);

  reg [63:0] register_file [0:15];

always@(posedge clk)begin
  if(clk==1)
  begin
    $readmemh("reg_file.txt",register_file);
  end
end

// initial begin
//     register_file[0] = 64'd0;register_file[1] = 64'd1;register_file[2] = 64'd4;register_file[3] = 64'd9;register_file[4] = 64'd16;register_file[5] = 64'd25;register_file[6] = 64'd36;register_file[7] = 64'd49;register_file[8] = 64'd64;register_file[9] = 64'd81;register_file[10] = 64'd100;register_file[11] = 64'd121;register_file[12] = 64'd144;register_file[13] = 64'd169;register_file[14] = 64'd196;register_file[15] = -64'd1; 
// end

// initial begin
//   valA = 64'd0;
//   valB = 64'd0;
// end

always @(*) begin
    if(clk ==1)
    begin
    if(icode == 4'b0010) //cmovxx
    begin
      valA = register_file[rA];
      valB = 64'd0;
    end
    else if(icode == 4'b0011) //irmovq
    begin
      valA = register_file[15];
      valB = 64'd0;
      // valB = Reg_File[rB];
    end
    else if(icode == 4'b0100) //rmmovq 
    begin
      valA = register_file[rA];
      valB = register_file[rB];
    end
    else if(icode == 4'b0101) //mrmovq
    begin
      valA = register_file[15];
      valB = register_file[rB];
    end
    else if(icode == 4'b0110) // opq
    begin
      valA = register_file[rA];
      valB = register_file[rB];
    end
    else if(icode == 4'b1010) // pushq
    begin
      valA = register_file[rA];
      valB = register_file[4];
    end
    else if(icode == 4'b1011) // popq
    begin
      valA = register_file[4];
      valB = register_file[4];
    end
    else if(icode == 4'b1000) // call
    begin
      valA = register_file[15];
      valB = register_file[4];
    end
    else if(icode == 4'b1001) // ret
    begin
      valA = register_file[4];
      valB = register_file[4];
    end
    end
    
    end


endmodule
