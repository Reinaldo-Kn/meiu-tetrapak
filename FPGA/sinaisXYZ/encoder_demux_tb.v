`include "encoder_mux.v"
`include "encoder_demux.v"
`timescale 1ns/1ps

module encoder_demux_tb;
    reg CLOCK_50 = 0;
    wire X, Y, Z, clkTz, Ths;
    wire [1:0] sel;

    // Sinais reconstituídos
    wire X_rec, Y_rec, Z_rec, CTE_rec;

    // Instancia o transmissor
    vincador_top uut_tx (
        .CLOCK_50(CLOCK_50),
        .X(X),
        .Y(Y),
        .Z(Z),
        .Ths(Ths),
        .sel(sel)
    );

    demux4_decoder uut_rx (
        .clk50(CLOCK_50),
        .sel(sel),
        .Ths(Ths),
        .X_rec(X_rec),
        .Y_rec(Y_rec),
        .Z_rec(Z_rec),
        .CTE_rec(CTE_rec)
    );

    // Clock 50 MHz
    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin
        $dumpfile("encoder_demux.vcd");
        $dumpvars(0, encoder_demux_tb);
        #10000; // tempo total de simulação
        $finish;
    end
endmodule
