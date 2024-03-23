module memory_tb;
reg clk;
reg [3:0] M_icode;
reg [1:0] M_stat;
reg M_Cnd;
reg [63:0] M_valE;
reg [63:0] M_valA;
reg [3:0] M_dstE;
reg [3:0] M_dstM;
wire [1:0] W_stat;
wire [3:0] W_icode;
wire [63:0] W_valE;
wire [63:0] W_valM;
wire [3:0] W_dstE;
wire [3:0] W_dstM;
wire [63:0] m_valM;
wire [1:0] m_stat;
wire dmem_error;
wire mem_read;
wire mem_write;

memory call1(.clk(clk),.M_icode(M_icode),.M_stat(M_stat),.M_Cnd(M_Cnd),.M_valE(M_valE),.M_valA(M_valA),.M_dstE(M_dstE),.M_dstM(M_dstM),.W_stat(W_stat),.W_icode(W_icode),.W_valE(W_valE),.W_valM(W_valM),.W_dstE(W_dstE),.W_dstM(W_dstM),.m_valM(m_valM),.m_stat(m_stat),.dmem_error(dmem_error),.mem_read(mem_read),.mem_write(mem_write));

always begin
    #10 clk = ~clk;
end

initial begin
    $dumpfile("memory_tb.vcd");
    $dumpvars(0,memory_tb);
end

initial begin
    clk = 1'b0;
    M_icode = 4'd0;
    M_stat = 2'b0;
    // M_Cnd = 1'b0;
    M_valE = 64'd0;
    M_valA = 64'd0;
    M_dstE =  4'd0;
    M_dstM = 4'd0;
    #20
    M_icode = 4'd4;
    M_valE = 64'd1024;
    M_valA = 64'd10;
    #20
    M_icode = 4'd5;
    M_valE = 64'd2;
    #20
    M_icode = 4'd8;
    M_valE = 64'd3;
    #20
    M_icode = 4'd9;
    M_valA = 64'd3;
    M_valE = 64'd4;
    #20
    M_icode = 4'd10;
    M_valE = 64'd5; 
    M_valA = 64'd20;
    #20
    M_icode = 4'd11;
    M_valA = 64'd1024;
    M_valE = 64'd1044;
    // #20
    // M_valE = 64'd1025;
    #20
    $finish;
end

initial begin
    $monitor($time,"clk = %d, M_icode = %d, M_stat = %d, M_valE = %d, M_valA = %d, M_dstE = %d, M_dstM =  %d, W_stat = %d, W_icode = %d, W_valE = %d, W_valM = %d, W_dstE = %d, W_dstM = %d, m_valM = %d, m_stat = %d, dmem_error = %d, mem_read = %d, mem_write = %d",clk,M_icode,M_stat,M_valE,M_valA,M_dstE,M_dstM,W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,m_valM,m_stat,dmem_error,mem_read,mem_write);
end
endmodule

