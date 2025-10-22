`include "encoder.v"
`timescale 1ns/1ps

module encoder_tb;
    reg CLOCK_50 = 0;
    wire X, Y, Z;

    // Instancia o módulo top
    vincador_top uut (
        .CLOCK_50(CLOCK_50),
        .X(X),
        .Y(Y),
        .Z(Z)
    );

    // Gera clock de 50 MHz (período de 20 ns)
    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin
        $dumpfile("encoder.vcd");
        $dumpvars(0, encoder_tb);
        #200000;  // tempo total de simulação (ajuste se quiser mais)
        $finish;
    end
endmodule
