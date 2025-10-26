`include "encoder_mux.v"
`timescale 1ns/100ps

module encoder_mux_tb;
    reg CLOCK_50 = 0;
    wire X, Y, Z, Ths;
    wire [1:0] sel;

    // Instancia o módulo principal
    vincador_top uut (
        .CLOCK_50(CLOCK_50),
        .X(X),
        .Y(Y),
        .Z(Z),
        .Ths(Ths),
        .sel(sel)
    );

    // Clock de 50 MHz → período 20 ns
    always #500 CLOCK_50 = ~CLOCK_50;

    // Simulação
    initial begin
        $dumpfile("encoder_mux.vcd");
        $dumpvars(0, encoder_mux_tb);
        #50000;  // tempo total de simulação (ajuste conforme o zoom desejado)
        $finish;
    end
endmodule
