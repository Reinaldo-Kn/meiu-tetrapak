// ========================================================
// Gerador dos sinais do encoder (canais X, Y e Z)
// ========================================================

// --------------------------------------------------------
// Divisor de clock - base de tempo para os sinais X, Y, Z
// --------------------------------------------------------
module clockDivider1(
    input clki,
    output clko
);
    // Ajuste conforme a velocidade simulada
    // 450 m/min: DIV=3141 | 600 m/min: DIV=2356 | teste rápido: DIV=100
    parameter DIV = 100;

    reg [11:0] count = 0;
    reg out = 0;

    always @(posedge clki) begin
        if (count == DIV) begin
            count <= 0;
            out <= ~out;
        end else begin
            count <= count + 1;
        end
    end

    assign clko = out;
endmodule

// --------------------------------------------------------
// Gerador dos canais X e Y (quadratura)
// --------------------------------------------------------
module genXY(
    input clkTz,
    output X, Y
);
    reg outX = 0, outY = 0;
    reg [1:0] count = 0;

    always @(posedge clkTz)
        count <= count + 1;

    always @(count) begin
        case (count)
            0: begin outX <= 1'b1; outY <= 1'b0; end
            1: begin outX <= 1'b1; outY <= 1'b1; end
            2: begin outX <= 1'b0; outY <= 1'b1; end
            3: begin outX <= 1'b0; outY <= 1'b0; end
        endcase
    end

    assign X = outX;
    assign Y = outY;
endmodule

// --------------------------------------------------------
// Gerador do canal Z (pulso de sincronismo)
// --------------------------------------------------------
module genZ(
    input clkTz,
    output Z
);
    reg [10:0] i = 0;
    reg outZ = 0;

    always @(posedge clkTz) begin
        if (i >= 1999)
            i <= 0;
        else
            i <= i + 1;

        // Pulso largo (5 ciclos de clkTz)
        if (i < 5)
            outZ <= 1'b1;
        else
            outZ <= 1'b0;
    end

    assign Z = outZ;
endmodule




// --------------------------------------------------------
// Top-level
// --------------------------------------------------------
module vincador_top(
    input CLOCK_50,   // clock de entrada (50 MHz simulado)
    output X, Y, Z
);
    wire clkTz;

    // Clock base
    clockDivider1 #(.DIV(100)) div1 (
        .clki(CLOCK_50),
        .clko(clkTz)
    );

    // Geração dos sinais X e Y
    genXY xygen (
        .clkTz(clkTz),
        .X(X),
        .Y(Y)
    );

    // Geração do pulso Z
    genZ zgen (
        .clkTz(clkTz),
        .Z(Z)
    );
endmodule
