// ========================================================
// Demultiplexador síncrono (Receptor)
// Reconstrói os sinais X, Y, Z, CTE a partir de Ths e sel
// ========================================================

module demux4_decoder(
    input clk50,
    input [1:0] sel,
    input Ths,
    output reg X_rec = 0,
    output reg Y_rec = 0,
    output reg Z_rec = 0,
    output reg CTE_rec = 0
);

    // Registrador para atrasar o seletor em 1 ciclo de clock
    reg [1:0] sel_d = 0;

    always @(posedge clk50) begin
        // Atraso do seletor para compensar a atualização simultânea no transmissor
        sel_d <= sel;

        // Atualiza apenas o canal correspondente ao seletor atrasado
        case (sel_d)
            2'b00: X_rec  <= Ths;    // Canal X
            2'b01: Y_rec  <= Ths;    // Canal Y
            2'b10: Z_rec  <= Ths;    // Canal Z
            2'b11: CTE_rec <= Ths;   // Canal Constante
        endcase
    end

endmodule
