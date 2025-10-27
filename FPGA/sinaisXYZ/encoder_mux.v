

// --------------------------------------------------------
// Divisor de clock - base de tempo dos sinais X, Y, Z
// --------------------------------------------------------
module clockDivider1(
    input clki,
    output clko
);
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
// Gerador dos canais X e Y (sinais em quadratura)
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

        // Pulso de 5 ciclos
        if (i < 5)
            outZ <= 1'b1;
        else
            outZ <= 1'b0;
    end

    assign Z = outZ;
endmodule

// --------------------------------------------------------
// Concentrador MUX
// --------------------------------------------------------
module mux4_encoder(
    input clk50,
    input encX,
    input encY,
    input pulse,
    input cte,
    output reg Ths = 0,
    output reg [1:0] sel = 0
);
    always @(posedge clk50) begin
        

        case (sel)
            2'b00: Ths <= encX;
            2'b01: Ths <= encY;
            2'b10: Ths <= pulse;
            2'b11: Ths <= cte;
            default: Ths <= 1'b0;
        endcase
        sel <= sel + 1;  // Contador 0–3 
    end
endmodule


// --------------------------------------------------------
// Top-level do sistema 
// --------------------------------------------------------
module vincador_top(
    input CLOCK_50,
    output X, Y, Z,
    output Ths,
    output [1:0] sel
);
    wire clkTz;
    wire cte = 1'b1; // constante

    // Clock base
    clockDivider1 #(.DIV(2)) div1 (
        .clki(CLOCK_50),
        .clko(clkTz)
    );

    // Geração dos sinais do encoder
    genXY xygen (.clkTz(clkTz), .X(X), .Y(Y));
    genZ zgen   (.clkTz(clkTz), .Z(Z));

    // MUX síncrono
    mux4_encoder mux (
        .clk50(CLOCK_50),
        .encX(X),
        .encY(Y),
        .pulse(Z),
        .cte(cte),
        .Ths(Ths),
        .sel(sel)
    );
endmodule
