`include "fetch.v"
module fetch_tb;
    reg clk;
    reg [63:0] pc;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire signed [63:0] valC;
    wire [63:0] valP;
    wire imem_error;
    wire instr_valid;
    wire halt;

fetch call1(.clk(clk),.pc(pc),.icode(icode),.ifun(ifun),.rA(rA),.rB(rB),.valC(valC), .valP(valP), .imem_error(imem_error), .instr_valid(instr_valid),.halt(halt));

always begin
    #10 clk = ~clk;
end

initial begin
    clk = 0;
    // pc = 64'd0;
    #20
    pc = 64'd0;
    #20

    pc = valP;
    #20

    pc = valP;
    #20

    pc = valP;
    #20
     
    pc = valP;
    #20;
    
    pc = valP;
    #20; 
    // pc = valP;
    // #20;
    // pc = valP;
    // #20;
    // pc = valP;
    // #20;
    // pc = valP;
    // #20
    $finish;
end


always @(*) begin
    if(clk == 1)
    begin
           $monitor("clk= %d time = %d: pc = %d icode =%d ifun = %d rA = %d rB = %d valC = %d valP = %d imem_error = %d instr_valid = %d halt = %d",clk, $time, pc, icode, ifun, rA, rB, valC, valP, imem_error, instr_valid, halt);
 
    end
  end

endmodule