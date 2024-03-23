module memory(
    input clk,
    input [3:0] M_icode,
    input [1:0] M_stat,
    input M_Cnd,
    input signed [63:0] M_valE,
    input signed [63:0] M_valA,
    input [3:0] M_dstE,
    input [3:0] M_dstM,
    input W_stall,
    output reg [1:0] W_stat,
    output reg [3:0] W_icode,
    output reg signed [63:0] W_valE,
    output reg signed [63:0] W_valM,
    output reg [3:0] W_dstE,
    output reg [3:0] W_dstM,
    output reg signed [63:0] m_valM,
    output reg [1:0] m_stat,
    output reg dmem_error,
    output reg mem_read,
    output reg mem_write
);


reg [63:0] data_memory[0:1023];
reg [63:0] data_final;
reg [3:0] icode;
reg signed [63:0] valE;
reg signed [63:0] valM;
reg signed [63:0] valA;
reg signed [63:0] valP;


initial begin
  data_final = 64'd0;
  valE = 4'd0;
  valM = 4'd0;
  valA = 4'd0;
  valP = 4'd0;
end


// initial
//   begin
//       data_memory[0] = 64'd0;
//       data_memory[1] = 64'd1;
//       data_memory[2] = 64'd4;
//       data_memory[3] = 64'd9;
//       data_memory[4] = 64'd16;
//       data_memory[5] = 64'd25;
//       data_memory[6] = 64'd36;
//       data_memory[7] = 64'd49;
//       data_memory[8] = 64'd64;
//       data_memory[9] = 64'd81;
//       data_memory[10] = 64'd100;
//       data_memory[11] = 64'd121;
//       data_memory[12] = 64'd144;
//       data_memory[13] = 64'd169;
//       data_memory[14] = 64'd196;
//       data_memory[15] = 64'd225;
//       data_memory[16] = 64'd256;
//       data_memory[17] = 64'd289;
//       data_memory[18] = 64'd324;
//       data_memory[19] = 64'd361;
//       data_memory[20] = 64'd400;
//   end


// always @(*) begin
//     valE <= M_valE;
//     valA <= M_valA;
//     icode <= M_icode;
//     valP <= M_valA;
//     m_valM <= valM;
//     // mem_read = 1'b0;
//     // mem_write = 1'b0;
//     // dmem_error = 1'b0;
// end


always @(*) begin
    valE <= M_valE;
    valA <= M_valA;
    icode <= M_icode;
    valP <= M_valA;
    mem_read = 1'b0;
    mem_write = 1'b0;
    dmem_error = 1'b0;

    if(icode == 4'b0100)//rmmovq
    begin
        mem_write = 1'b1;
        mem_read = 1'b0;
        if(valE< 64'd1024 && valE>=64'd0)
        begin
          data_memory[valE] = valA;
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
          m_stat = 2'b10;
        end
        
    end


    else if(icode == 4'b0101)//mrmovq
    begin
        mem_read = 1'b1;
        mem_write = 1'b0;
        if(valE < 64'd1024 && valE>=64'd0)
        begin
          valM = data_memory[valE];
          data_final = data_memory[valE];
          m_valM <= valM;
        end
        else
        begin
          dmem_error = 1'b1;
          m_stat = 2'b10;
        end
    end


    else if(icode == 4'b1000)//call
    begin
        mem_write = 1'b1;
        mem_read = 1'b0;
        if(valE < 64'd1024 && valE>=64'd0)
        begin
          data_memory[valE] = valP;
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
          m_stat = 2'b10;
        end
    end


    else if(icode == 4'b1001)//ret
    begin
        mem_read = 1'b1;
        mem_write = 1'b0;
        if(valA < 64'd1024 && valA>=64'd0)
        begin
          valM = data_memory[valA];
          data_final = data_memory[valE];
          m_valM <= valM;
        end
        else
        begin
          dmem_error = 1'b1;
          m_stat = 2'b10;
        end
    end


    else if(icode == 4'b1010)//pushq
    begin
        mem_write = 1'b1;
        mem_read = 1'b0;
        if(valE < 64'd1024 && valE>=64'd0)
        begin
          data_memory[valE] = valA;
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
          m_stat = 2'b10;
        end
    end


    else if(icode == 4'b1011)//popq
    begin
        mem_read = 1'b1;
        mem_write = 1'b0;
        if(valA < 64'd1024 && valA>=64'd0)
        begin
          valM = data_memory[valA];
          data_final = data_memory[valE];
          m_valM <= valM;
        end
        else
        begin
          dmem_error = 1'b1;
          m_stat = 2'b10;
        end

        m_valM <= valM;
        // $display($time,"valE =%d vala =%d m_stat =%d",valE,valA,m_stat);
    end
    // $display($time," valE =%d valA =%d icode =%d valP =%d dmem_error =%d m_stat =%d",valE, valA,icode,valP,dmem_error,m_stat);

  // $display($time," icode =%d valA =%d valE= %d valP =%d valM =%d datafinal =%d m_valM =%d", M_icode,M_valA,M_valE,M_valA,valM,data_final,m_valM);

end

always @(*) begin
    if(dmem_error == 1'b1)
    begin
        m_stat = 2'b10;
    end
    else
    begin
        m_stat = M_stat;
    end
end

always @(posedge clk) begin
    W_dstE <= M_dstE;
    W_dstM <= M_dstM;
    W_icode <= M_icode;
    W_stat <= m_stat;
    W_valE <= M_valE; //
    W_valM <= m_valM;
end

endmodule
