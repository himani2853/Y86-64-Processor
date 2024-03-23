`include "memory.v"
module memory_tb;
reg clk;
reg [3:0] icode;
reg [63:0] valE;
reg [63:0] valA;
reg [63:0] valP;
// reg instr_valid;
// reg imem_error;
wire [63:0] valM;
wire [63:0] data_final;
wire mem_read;
wire mem_write;
wire dmem_error;
// wire [2:0]Stat;

memory call1(.clk(clk),.icode(icode),.valE(valE),.valA(valA),.valP(valP),.valM(valM),.data_final(data_final),.mem_read(mem_read),.mem_write(mem_write),.dmem_error(dmem_error));

initial begin
    #10 clk = ~clk;
end


initial begin
    clk = 1'b0;
    icode = 4'd0;
    valE = 64'd0;
    valA = 64'd0;
    valP = 64'd0;
    // instr_valid = 1'b1;
    // imem_error = 1'b0;
    #20
    icode = 64'd4;
    valE = 64'd5;
    valA = 64'd10;
    valP = 64'd15;
    // imem_error = 1'd0;
    #20
    icode = 64'd5;
    valE = 64'd280;
    valA = 64'd10;
    valP = 64'd15;
    // imem_error = 1'd0;
    #20
    icode = 64'd5;
    valE = 64'd5;
    valA = 64'd4;
    valP = 64'd15;
    // imem_error = 1'd1;
    #20
    icode = 64'd8;
    valE = 64'd1;
    valA = 64'd3;
    valP = 64'd13;
    // imem_error = 1'd0;
    #20
    icode = 64'd9;
    valE = 64'd5;
    valA = 64'd8;
    valP = 64'd15;
    // imem_error = 1'd0;
    #20
    icode = 64'd10;
    valE = 64'd5;
    valA = 64'd14;
    valP = 64'd15;
    // imem_error = 1'd1;
    #20
    icode = 64'd11;
    valE = 64'd5;
    valA = 64'd12;
    valP = 64'd15;
    // imem_error = 1'd0;
    #20
    $finish;
end

//  initial begin
//     $dumpfile("memory_tb.vcd");
//     $dumpvars(0,memory_tb);
// end  

always @(posedge clk) begin
    $monitor(" Clk = %d, Time=%d: icode=%d, valE=%d, valA=%d, valP=%d, valM=%d, data_final =%d, mem_read=%d, mem_write=%d, dmem_error =%d", clk, $time, icode, valE, valA, valP, valM, data_final, mem_read, mem_write, dmem_error);
  end

endmodule