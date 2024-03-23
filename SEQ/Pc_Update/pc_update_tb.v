`include "pc_update.v"
module pc_update_tb;
reg clk;
reg [63:0] pc;
reg [3:0] icode;
reg Cnd;
reg [63:0] valP;
reg signed [63:0] valM;
reg signed [63:0] valC;
wire [63:0] pc_updated;

pc_update call1(.clk(clk),.pc(pc),.icode(icode),.Cnd(Cnd),.valP(valP),.valM(valM),.valC(valC),.pc_updated(pc_updated));

always begin
    #10 clk = ~clk;
end

initial begin
    clk = 1'b1;
    pc = 64'd0;
    icode = 4'd0;
    Cnd = 1'b0;
    valP = 64'd0;
    valM = 64'd0;
    valC = 64'd0;
    #20
    pc = 64'd2;
    icode = 4'b0111;
    Cnd = 1'b1;
    valP = 64'd32;
    valM = 64'd64;
    valC = 64'd56;
    #20
    pc = 64'd2;
    icode = 4'b0111;
    Cnd = 1'b0;
    valP = 64'd32;
    valM = 64'd64;
    valC = 64'd56;
    #20
    pc = 64'd2;
    icode = 4'b1000;
    Cnd = 1'b0;
    valP = 64'd32;
    valM = 64'd64;
    valC = 64'd56;
    #20
    pc = 64'd2;
    icode = 4'b1001;
    Cnd = 1'b0;
    valP = 64'd32;
    valM = 64'd64;
    valC = 64'd56;
    #20
    pc = 64'd2;
    icode = 4'b0110;
    Cnd = 1'b0;
    valP = 64'd32;
    valM = 64'd64;
    valC = 64'd56;
    #20;
    $finish;

end

initial begin
    $dumpfile("pc_update_tb.vcd");
    $dumpvars(0,pc_update_tb);
end

always @(*) begin
    if(clk == 0)
    begin
           $monitor("clk=%d Time=%d: pc=%d, icode=%d, Cnd=%d, valP=%d , valM=%d, valC = %d, pc_updated = %d ", clk, $time, pc,icode, Cnd, valP, valM, valC, pc_updated);
 
    end
  end

endmodule