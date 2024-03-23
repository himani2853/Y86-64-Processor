`include "execute.v"
module execute_tb;
reg clk;
reg signed [63:0] valA;
reg signed [63:0] valB;
reg signed [63:0] valC;
reg [3:0] icode;
reg [3:0] ifun;
reg zf_in;
reg of_in;
reg sf_in;
wire signed [63:0] valE;
wire Cnd;
wire zf_out;
wire of_out;
wire sf_out;

execute call1(.clk(clk),.valA(valA),.valB(valB),.valC(valC),.icode(icode),.ifun(ifun),.zf_in(zf_in),.of_in(of_in),.sf_in(sf_in),.valE(valE),.Cnd(Cnd),.zf_out(zf_out),.of_out(of_out),.sf_out(sf_out));

always begin
    #10 clk = ~clk;
end

initial begin
    clk = 0;
    valA = 64'd0;
    valB = 64'd0;
    valC = 64'd0;
    icode = 4'd0;
    ifun = 4'd0;
    zf_in = 1'b0;
    of_in = 1'b0;
    sf_in = 1'b0;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd0;
    // zf_in = 1'b0;
    // of_in = 1'b0;
    // sf_in = 1'b1;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd1;
    // zf_in = 1'b0;
    // of_in = 1'b1;
    // sf_in = 1'b0;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd2;
    // zf_in = 1'b0;
    // of_in = 1'b1;
    // sf_in = 1'b1;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd3;
    // zf_in = 1'b1;
    // of_in = 1'b0;
    // sf_in = 1'b0;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd4;
    // zf_in = 1'b1;
    // of_in = 1'b0;
    // sf_in = 1'b1;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd5;
    // zf_in = 1'b1;
    // of_in = 1'b1;
    // sf_in = 1'b0;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd2;
    // ifun = 4'd6;
    // zf_in = 1'b1;
    // of_in = 1'b1;
    // sf_in = 1'b1;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd3;
    // ifun = 4'd0;
    // zf_in = 1'b0;
    // of_in = 1'b0;
    // sf_in = 1'b0;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd4;
    // ifun = 4'd0;
    // zf_in = 1'b0;
    // of_in = 1'b0;
    // sf_in = 1'b1;
    // #20
    // valA = 64'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd5;
    // ifun = 4'd0;
    // zf_in = 1'b0;
    // of_in = 1'b1;
    // sf_in = 1'b0;
    // #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd6;
    ifun = 4'd0;
    zf_in = 1'b0;
    of_in = 1'b1;
    sf_in = 1'b1;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd6;
    ifun = 4'd1;
    zf_in = 1'b1;
    of_in = 1'b0;
    sf_in = 1'b0;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd6;
    ifun = 4'd2;
    zf_in = 1'b1;
    of_in = 1'b0;
    sf_in = 1'b1;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd6;
    ifun = 4'd3;
    zf_in = 1'b1;
    of_in = 1'b1;
    sf_in = 1'b0;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd0;
    zf_in = 1'b1;
    of_in = 1'b1;
    sf_in = 1'b1;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd1;
    zf_in = 1'b0;
    of_in = 1'b0;
    sf_in = 1'b0;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd2;
    zf_in = 1'b0;
    of_in = 1'b0;
    sf_in = 1'b1;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd3;
    zf_in = 1'b0;
    of_in = 1'b1;
    sf_in = 1'b0;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd4;
    zf_in = 1'b0;
    of_in = 1'b1;
    sf_in = 1'b1;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd5;
    zf_in = 1'b1;
    of_in = 1'b0;
    sf_in = 1'b0;
    #20
    valA = 64'd5;
    valB = 64'd10;
    valC = 64'd25;
    icode = 4'd7;
    ifun = 4'd6;
    zf_in = 1'b1;
    of_in = 1'b0;
    sf_in = 1'b1;
    // #20
    // valA = 54'd5;
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd8;
    // ifun = 4'd0;
    // zf_in = 1'b1;
    // of_in = 1'b1;
    // sf_in = 1'b0;
    // #20
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd9;
    // ifun = 4'd0;
    // zf_in = 1'b1;
    // of_in = 1'b1;
    // sf_in = 1'b1;
    // #20
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd10;
    // ifun = 4'd0;
    // zf_in = 1'b0;
    // of_in = 1'b0;
    // sf_in = 1'b0;
    // #20
    // valB = 64'd10;
    // valC = 64'd25;
    // icode = 4'd11;
    // ifun = 4'd0;
    // zf_in = 1'b0;
    // of_in = 1'b0;
    // sf_in = 1'b1;
    #20;
    $finish;

end


// initial begin
//     $dumpfile("execute_tb.vcd");
//     $dumpvars(0,execute_tb);
// end

always @(posedge clk) begin
    $display("clk=%d Time=%d: valA =%d, valB=%d, valC=%d, icode =%d ,ifun =%d, zf_in=%d, of_in=%d, sf_in=%d, valE = %d Cnd = %d, zf_out = %d, of_out = %d , sf_out= %d", clk, $time, valA, valB, valC, icode, ifun, zf_in, of_in, sf_in, valE, Cnd, zf_out, of_out, sf_out);
  end


endmodule