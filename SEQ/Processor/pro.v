`include "fetch.v"
`include "decode_wb.v"
`include "execute.v"
`include "memory.v"
`include "pc_update.v"

module processor;

    reg clk;
    reg [63:0] pc;

    reg stat_AOK;
    reg stat_INS;
    reg stat_HLT;
    reg stat_ADR;

    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB; 
    wire signed [63:0] valC;
    wire [63:0] valP;
    wire imem_error;
    wire instr_valid;
    wire halt;

    wire signed [63:0] valA;
    wire signed [63:0] valB;

    reg zf_in;
    reg of_in;
    reg sf_in;
    wire Cnd;
    wire zf_out;
    wire of_out;
    wire sf_out;
    wire signed [63:0] valE;
    
    wire signed [63:0] valM;
    wire signed [63:0] data_final;
    wire mem_read;
    wire mem_write;
    wire dmem_error;
    // wire [2:0] Stat;

    wire [63:0] pc_updated;

    wire signed [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9,r10,r11,r12,r13,r14,rnone;

    fetch fetch_1(clk,pc,icode,ifun,rA,rB,valC,valP,imem_error,instr_valid,halt);

    // decode decode_1(clk,icode,rA,rB,valA,valB);
    decode_wb dc_wb(clk,Cnd,icode,rA,rB,valA,valB,valE,valM,rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9,r10,r11,r12,r13,r14,rnone);

    execute execute_1(clk,valA,valB,valC,icode,ifun,zf_in,of_in,sf_in,valE,Cnd,zf_out,of_out,sf_out);

     always @(posedge clk) begin
        if(icode == 4'd6)
            begin   
                zf_in <= zf_out;
                of_in <= of_out;
                sf_in <= sf_out;
            end
    end

    memory memory_1(clk,icode,valE,valA,valP,valM,data_final,mem_read,mem_write,dmem_error);

    // write_back write_back_1(clk,icode,Cnd,rA,rB,valE,valM);

    pc_update pc_update_1(clk,pc,icode,Cnd,valP,valM,valC,pc_updated);


    initial begin
        clk = 1;
        pc = 64'd0;
        zf_in=0;
        of_in=0;
        sf_in=0;
        stat_AOK = 1;
        stat_INS = 0;
        stat_HLT = 0;
        stat_ADR = 0;
    end

    always begin
        #10 clk = ~clk;
    end

    
reg signed or_gate_1;
reg signed or_gate_2;
wire signed or_gate_out;
or(or_gate_out,or_gate_1,or_gate_2);

    always@(*)begin
        or_gate_1 = imem_error;
        or_gate_2 = dmem_error;
        if(or_gate_out == 1'b1)begin
            stat_AOK=1'b0;
            stat_INS=1'b0;
            stat_HLT=1'b0;
            stat_ADR=1'b1;
        end
        else if(instr_valid == 1'b0)begin
            stat_AOK=1'b0;
            stat_INS=1'b1;
            stat_HLT=1'b0;
            stat_ADR=1'b0;
        end
        else if(halt == 1'b1)begin
            stat_AOK=1'b0;
            stat_INS=1'b0;
            stat_HLT=1'b1;
            stat_ADR=1'b0;
        end
        else begin
            stat_AOK=1'b1;
            stat_INS=1'b0;
            stat_HLT=1'b0;
            stat_ADR=1'b0;
        end
    end

    always@(*)
    begin
        pc = pc_updated;
    end

    always@(*)
    begin
        if(stat_ADR == 1)
        begin
            $finish;
        end
        if(stat_HLT == 1)
        begin
            $finish;
        end
        if(stat_INS == 1)
        begin
            $finish;
        end
    end

 initial
 begin
  	$monitor($time, "    clk = %d icode = %d ifun = %d rA = %d rB = %d\n\t\t\tvalA = %d valB = %d valC = %d valE = %d valM = %d updated_pc = %d\n\t\t\tdata_final = %d dmem_error = %d instr_valid = %d imem_error = %d Cnd = %d S_HLT = %d S_AOK = %d S_INS = %d S_ADR = %d\n",clk,icode,ifun,rA,rB,valA,valB,valC,valE,valM,pc_updated,data_final,dmem_error,instr_valid,imem_error,Cnd,stat_HLT,stat_AOK,stat_INS,stat_ADR);
    // #50;
    // stat_HLT = 1;
 end

endmodule