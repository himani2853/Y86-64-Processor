`include "alu.v"
module execute(
    input clk,
    input [1:0] E_stat,
    input [3:0] E_icode,
    input [3:0] E_ifun,
    input signed [63:0] E_valC,
    input signed [63:0] E_valA,
    input signed [63:0] E_valB,
    input [3:0] E_dstE,
    input [3:0] E_dstM,
    // input [3:0] E_srcA,
    // input [3:0] E_srcB,
    input [1:0] W_stat,
    input [1:0] m_stat,
    input set_cc,
    input M_bubble,
    output reg [1:0] M_stat,
    output reg [3:0] M_icode,
    output reg M_Cnd,
    output reg signed [63:0] M_valE,
    output reg signed [63:0] M_valA,
    output reg [3:0] M_dstE,
    output reg [3:0] M_dstM,
    output reg e_Cnd,
    output reg signed [63:0] e_valE,
    output reg [3:0] e_dstE
);

reg [3:0] icode;
reg [3:0] ifun;
reg signed [63:0] valA;
reg signed [63:0] valB;
reg signed [63:0] valC;
reg signed [63:0] valE;
reg Cnd;
reg signed [63:0] alu_A;
reg signed [63:0] alu_B;
// condition codes 
// cc[2:0]
reg zero_flag_in;
reg overflow_flag_in;
reg sign_flag_in;

reg zero_flag_out;
reg overflow_flag_out;
reg sign_flag_out;

reg [1:0] control;
reg signed [63:0]A;
reg signed [63:0]B;
wire signed [63:0] S;
wire overflow;
wire signed [63:0] ans;

alu call1(
  .control(control),
  .A(A),
  .B(B),
  .S(S),
  .overflow(overflow),
  .ans(ans)
);


initial begin
  A = 64'd0;
  B = 64'd0;
  control = 2'b00;
  zero_flag_in = 1'b0;
  overflow_flag_in = 1'b0;
  sign_flag_in = 1'b0;
  zero_flag_out = 1'b0;
  overflow_flag_out = 1'b0;
  sign_flag_out = 1'b0;
  valE = 64'd0;
  valA = 64'd0;
  valB = 64'd0;
  valC = 64'd0;
end

reg signed xor1;
reg signed xor2;
wire signed xor_out;
xor(xor_out,xor1,xor2);

reg signed or1;
reg signed or2;
wire signed or_out;
or(or_out,or1,or2);

reg signed not1;
wire signed not_out;
not(not_out,not1);

reg signed and1;
reg signed and2;
wire signed and_out;
and(and_out,and1,and2);

reg signed [63:0] out;

always @(*) begin
        valA <= E_valA;
        valB <= E_valB;
        valC <= E_valC;
        icode <= E_icode;
        ifun <= E_ifun;
        e_dstE <= E_dstE;
        e_valE <= valE;
        e_Cnd <= Cnd;

end

always @(*) begin
  if(icode == 4'b0110 && set_cc == 1'b1)
  begin
    if(ifun == 4'b0000 || ifun == 4'b0001)
    begin
      zero_flag_out = (S==64'd0);
      sign_flag_out = (S[63]==1);
      overflow_flag_out = (A<64'd0==B<64'd0)&&((S<64'd0)!=(A<64'd0));
    end
    else if(ifun == 4'b0010 || ifun == 4'b0011)
    begin
      zero_flag_out = (ans==64'd0);
      sign_flag_out= (ans[63]==1);
      overflow_flag_out = (A<64'd0==B<64'd0)&&((ans<64'd0)!=(A<64'd0));
    end
  end
end


always @(*) begin
    zero_flag_in = zero_flag_out;
    overflow_flag_in = overflow_flag_out;
    sign_flag_in = sign_flag_out;
end

always @(*) begin
       if(icode == 4'b0010)//cmovxx
    begin
        control = 2'b00;
        Cnd = 1'b0;
        A = 64'd0;
        B = valA;
        valE <= S;

        if(ifun == 4'b0000) // rrmovq
        begin
          Cnd = 1'b1;
          // control = 2'b00;
          // valE <= S;
        end

        else if(ifun == 4'b0001) // cmmovle
        begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          if(xor_out | zero_flag_in)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end

        else if(ifun == 4'b0010) // cmovl
        begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          if(xor_out)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end

        else if(ifun == 4'b0011) // cmove
        begin
          if(zero_flag_in)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end

        else if(ifun == 4'b0100)// cmovne
        begin
          not1 = zero_flag_in;
          if(not_out)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end

        else if(ifun == 4'b0101)// cmovge
        begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          not1 = xor_out;
          if(not_out)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end

        else if(ifun == 4'b0110)// cmovg
        begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          not1 = xor_out;
          if(not_out)
          begin
            not1 = zero_flag_in;
            if(not_out)
            begin
              Cnd = 1'b1;
              // control= 2'b00;
              // valE <= S;
            end
          end
        end
        
        
        if(e_Cnd == 1'b1)
        begin
            e_dstE = E_dstE;
        end
        else
        begin
            e_dstE = 4'hf;
        end
    
    
    end


    else if(icode == 4'b0011)//irmovq
    begin
        A = valC;
        B = 64'd0;
        control = 2'b00;
        valE <= S;
    end

    else if(icode == 4'b0100)//rmmovq
    begin
        A = valC;
        B = valB;
        control = 2'b00;
        valE <= S;
    end



    else if(icode == 4'b0101)//mrmovq
    begin
        A = valB;
        B = valC;
        control = 2'b00;
        valE <= S;

    end


    else if(icode == 4'b0110)//opq
    begin
        
        if(ifun == 4'b0000)//add
        begin
          A= valA;
          B = valB;
          control = 2'b00;
          valE <= S;
        end
        else if(ifun == 4'b0001)//sub
        begin
          A= valB;
          B = valA;
          control = 2'b01;         
          valE <= S;
        end
        else if(ifun== 4'b0010)//and
        begin
          A= valA;
          B = valB;
          control = 2'b10;
          valE <= ans;
        end
        else if(ifun == 4'b0011)//xor
        begin
          A= valB;
          B = valA;
          control = 2'b11;
          valE <= ans;
        end
        // set_cc command up


    end


    else if(icode == 4'b0111)//jxx
    begin
        Cnd = 1'b0;
        // valE <= valE;
        if(ifun == 4'b0000)//jmp
        begin
          Cnd = 1'b1;
        end
        else if(ifun == 4'b0001)// jle
        begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          if(xor_out | zero_flag_in)
          begin
            Cnd = 1'b1;
          end
            // (sf^of)|zf
        end
        else if(ifun== 4'b0010)// jl
        begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          if(xor_out)
          begin
            Cnd = 1'b1;
          end
            // (sf^of)
        end
        else if(ifun == 4'b0011)// je
        begin
            // (zf)
            if(zero_flag_in)
            begin
              Cnd = 1'b1;
            end
        end
        else if(ifun == 4'b0100)// jne
        begin
          // (~zf)
          not1 = zero_flag_in;
          if(not_out)
          begin
            Cnd = 1'b1;
          end
        end
        else if(ifun == 4'b0101)// jge
        begin
          // ~(sf^of)
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          not1 = xor_out;
          if(not_out)
          begin
            Cnd = 1'b1;
          end
        end
        else if(ifun == 4'b0110)// jg
       begin
          xor1 = sign_flag_in;
          xor2 = overflow_flag_in;
          not1 = xor_out;
          if(not_out)
          begin
            not1 = zero_flag_in;
            if(not_out)
            begin
              Cnd = 1'b1;
            end
          end
        end


         if(e_Cnd == 1'b1)
        begin
            e_dstE = E_dstE;
        end
        else
        begin
            e_dstE = 4'hf;
        end


      end


    else if(icode == 4'b1000)//call
    begin
        A = valB;
        B = -64'd8;
        control = 2'b00;
        valE <= S;

    end


    else if(icode == 4'b1001)//ret
    begin
        A = valB;
        B = 64'd8;
        control = 2'b00;
        valE <= S;

    end


    else if(icode == 4'b1010)//pushq
    begin
        A = valB;
        B = -64'd8;
        control = 2'b00;
        // out <= S; 
        valE <= S;

    end


    else if(icode == 4'b1011)//popq
    begin
        A = valB;
        B = 64'd8;
        control = 2'b00;
        valE <= S;

    end

 end


always @(posedge clk) begin
  if(M_bubble == 1'b1)
  begin
    M_Cnd <= 1'b0;
    M_dstE <= 4'hf;
    M_dstM <= 4'hf;
    M_icode <= 4'b0001;
    M_stat <= 2'b00;
    M_valE <= 64'd0;
    M_valA <= 64'd0;
  end
    M_Cnd <= e_Cnd;
    M_dstE <= e_dstE;
    M_dstM <= E_dstM;
    M_icode <= E_icode;
    M_stat <= E_stat;
    M_valE <= e_valE;
    M_valA <= E_valA;
end

endmodule