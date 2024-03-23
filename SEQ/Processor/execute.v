`include "alu.v" 
module execute(
    input clk,
    input signed [63:0] valA,
    input signed [63:0] valB,
    input signed [63:0] valC,
    input [3:0] icode,
    input [3:0] ifun,
    input zf_in,
    input of_in,
    input sf_in,
    output reg signed [63:0] valE,
    output reg Cnd,
    output reg zf_out,
    output reg of_out,
    output reg sf_out
);

reg signed [63:0] alu_A;
reg signed [63:0] alu_B;

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
  Cnd = 1'b0;
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
  if(icode == 4'b0110 && clk == 1'b1)
  begin
    if(ifun == 4'b0000 || ifun == 4'b0001)
    begin
      zf_out = (S==64'd0);
      sf_out = (S[63]==1);
      of_out = (A<64'd0==B<64'd0)&&((S<64'd0)!=(A<64'd0));
    end
    else if(ifun == 4'b0010 || ifun == 4'b0011)
    begin
      zf_out = (ans==64'd0);
      sf_out= (ans[63]==1);
      of_out = (A<64'd0==B<64'd0)&&((ans<64'd0)!=(A<64'd0));
    end
  end
end

always @(*) begin
 if(clk == 1)
 begin
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
          xor1 = sf_in;
          xor2 = of_in;
          if(xor_out | zf_in)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end
        else if(ifun == 4'b0010) // cmovl
        begin
          xor1 = sf_in;
          xor2 = of_in;
          if(xor_out)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end
        else if(ifun == 4'b0011) // cmove
        begin
          if(zf_in)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end
        else if(ifun == 4'b0100)// cmovne
        begin
          not1 = zf_in;
          if(not_out)
          begin
            Cnd = 1'b1;
            // control = 2'b00;
            // valE <= S;
          end
        end
        else if(ifun == 4'b0101)// cmovge
        begin
          xor1 = sf_in;
          xor2 = of_in;
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
          xor1 = sf_in;
          xor2 = of_in;
          not1 = xor_out;
          if(not_out)
          begin
            not1 = zf_in;
            if(not_out)
            begin
              Cnd = 1'b1;
              // control= 2'b00;
              // valE <= S;
            end
          end
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
          xor1 = sf_in;
          xor2 = of_in;
          if(xor_out | zf_in)
          begin
            Cnd = 1'b1;
          end
            // (sf^of)|zf
        end
        else if(ifun== 4'b0010)// jl
        begin
          xor1 = sf_in;
          xor2 = of_in;
          if(xor_out)
          begin
            Cnd = 1'b1;
          end
            // (sf^of)
        end
        else if(ifun == 4'b0011)// je
        begin
            // (zf)
            if(zf_in)
            begin
              Cnd = 1'b1;
            end
        end
        else if(ifun == 4'b0100)// jne
        begin
          // (~zf)
          not1 = zf_in;
          if(not_out)
          begin
            Cnd = 1'b1;
          end
        end
        else if(ifun == 4'b0101)// jge
        begin
          // ~(sf^of)
          xor1 = sf_in;
          xor2 = of_in;
          not1 = xor_out;
          if(not_out)
          begin
            Cnd = 1'b1;
          end
        end
        else if(ifun == 4'b0110)// jg
       begin
          xor1 = sf_in;
          xor2 = of_in;
          not1 = xor_out;
          if(not_out)
          begin
            not1 = zf_in;
            if(not_out)
            begin
              Cnd = 1'b1;
            end
          end
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
 end


endmodule

