module pc_update(
    input clk,
    input [63:0] pc,//address
    input [3:0] icode,
    input Cnd,
    input [63:0] valP,
    input signed [63:0] valM,
    input signed [63:0] valC,
    output reg [63:0] pc_updated
);

always @(*) begin

   if(icode == 4'b0111)//jxx
    begin
      if(Cnd == 1'b1)
        begin
          pc_updated <= valC;
        end
      else
        begin
          pc_updated <= valP;
        end
    end

    else if(icode == 4'b1000)//call
    begin
      pc_updated <= valC;
    end

    else if(icode == 4'b1001)//ret
    begin
      pc_updated <= valM;
    end

    else
    begin
      pc_updated <= valP;
    end    
end
   
endmodule

