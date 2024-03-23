module pipeline_logic(
    input [3:0] D_icode,
    input [3:0] d_srcA,//E_srcA
    input [3:0] d_srcB,//E_srcB
    input [3:0] E_icode,
    input [3:0] E_dstM,
    input e_Cnd,
    input [3:0] M_icode,
    input [1:0] m_stat,
    input [1:0] W_stat,
    output reg set_cc,
    output reg F_stall,
    output reg D_stall,
    output reg D_bubble,
    output reg E_bubble,
    output reg M_bubble,
    output reg W_stall
);

initial begin
     set_cc = 1'b0;
    F_stall = 1'b0;
    D_stall = 1'b0; 
    D_bubble = 1'b0;
    E_bubble = 1'b0;
    M_bubble = 1'b0;
    W_stall = 1'b0;
end

always @(*) begin
    set_cc = 1'b0;
    F_stall = 1'b0;
    D_stall = 1'b0; 
    D_bubble = 1'b0;
    E_bubble = 1'b0;
    M_bubble = 1'b0;
    W_stall = 1'b0;

    if(((E_icode == 4'b0101 | E_icode == 4'b1011) && (E_dstM == d_srcA | E_dstM == d_srcB)) || (D_icode == 4'b1001 | E_icode == 4'b1001 | M_icode == 4'b1001))
    begin
        F_stall = 1'b1;
    end

    if((E_icode == 4'b0101 | E_icode == 4'b1011) && (E_dstM == d_srcA | E_dstM == d_srcB))
    begin
        D_stall = 1'b1;
    end 

    if((E_icode == 4'b0111 && !e_Cnd) || (D_icode == 4'b1001 | E_icode == 4'b1001 | M_icode == 4'b1001) && !((E_icode == 4'b0101 | E_icode == 4'b1011) && (E_dstM == d_srcA | E_dstM == d_srcB)))
    begin
        D_bubble = 1'b1;
    end 

    if((E_icode == 4'b0111 && !e_Cnd) || ((E_icode == 4'b0101 | E_icode == 4'b1011) && (E_dstM == d_srcA | E_dstM == d_srcB)))
    begin
        E_bubble = 1'b1;
    end

    if(m_stat!= 2'b00 || W_stat != 2'b00)
    begin
        M_bubble = 1'b1;
    end

    if(W_stat!=2'b00)
    begin
        W_stall = 1'b1;
    end

    if(E_icode == 4'b0110 && !(m_stat == 2'b01 | m_stat == 2'b10 | m_stat == 2'b11) && !(W_stat == 2'b01 | W_stat == 2'b10 | W_stat == 2'b11))
    begin
        set_cc = 1'b1;
    end

    end

endmodule