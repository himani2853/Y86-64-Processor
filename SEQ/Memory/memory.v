module memory(
    input clk,
    input [3:0] icode,
    input signed [63:0] valE,
    input signed [63:0] valA,
    input [63:0] valP,
    // input instr_valid,
    // input imem_error,
    output reg signed [63:0] valM,
    output reg signed [63:0] data_final,
    output reg mem_read,
    output reg mem_write,
    output reg dmem_error
    // output reg [2:0]Stat
);


reg [63:0] data_memory[0:1023];

always @(*) begin
  mem_read = 1'b0;
  mem_write = 1'b0;
  dmem_error = 1'b0;
    if(clk==1)
    begin
    if(icode == 4'b0100)//rmmovq
    begin
        mem_write = 1'b1;
        mem_read = 1'b0;
        if(valE< 64'd1024)
        begin
          data_memory[valE] = valA;
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
        end
        
    end


    else if(icode == 4'b0101)//mrmovq
    begin
        mem_read = 1'b1;
        mem_write = 1'b0;
        if(valE < 64'd1024)
        begin
          valM = data_memory[valE];
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
        end
    end


    else if(icode == 4'b1000)//call
    begin
        mem_write = 1'b1;
        mem_read = 1'b0;
        if(valE < 64'd1024)
        begin
          data_memory[valE] = valP;
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
        end
    end


    else if(icode == 4'b1001)//ret
    begin
        mem_read = 1'b1;
        mem_write = 1'b0;
        if(valA < 64'd1024)
        begin
          valM = data_memory[valA];
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
        end
    end


    else if(icode == 4'b1010)//pushq
    begin
        mem_write = 1'b1;
        mem_read = 1'b0;
        if(valA < 64'd1024)
        begin
          data_memory[valE] = valA;
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
        end
    end


    else if(icode == 4'b1011)//popq
    begin
        mem_read = 1'b1;
        mem_write = 1'b0;
        if(valA < 64'd1024)
        begin
          valM = data_memory[valA];
          data_final = data_memory[valE];
        end
        else
        begin
          dmem_error = 1'b1;
        end
    end
    // data_final = data_memory[valE];
    end
end

// initial begin
// Stat = 3'd1;
// end

// always @(*) begin
//   if(imem_error | dmem_error)begin
//      Stat = 3'd2;
//   end
//   else if(!instr_valid)begin
//     Stat = 3'd3;
//    end
//   else if(icode == 4'd0)begin
//     Stat = 3'd4;
//   end
//   else begin
//     Stat = 3'd1;
//   end
// end
    
endmodule