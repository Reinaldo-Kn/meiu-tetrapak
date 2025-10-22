// ========================================================
// Modulos do gerador dos sinais X Y Z
// Eles são instanciados dentro do módulo DE0 ou DE10 Lite
// ========================================================

// --------------------------------------------------------
// clock divider geração da base de tempo dos sinais X Y Z
// --------------------------------------------------------

module clockDivider1(
    input clki,
    output clko );

    // Clock para o parâmetro Tz. Lembrando que Tx=4.Tz
    // 450m/min: DIV=3141
    // 600m/min: DIV=2356
    parameter DIV = 1178;

    reg [11:0] count;
    reg out;

    // ------ Count up to 5e6 (100 ms)
    always@(posedge clki) begin
        if( count == DIV ) begin 
            count <= 0;
            out = !out;
            end
        else count <= count+1;
    end

    assign clko = out;
endmodule

// --------------------------------------------------------
// Gerador dos sinais
// --------------------------------------------------------

module genXY(input clkTz, output X, Y );
    reg outX, outY;
    reg [1:0] count;

    always@(posedge clkTz) count <= count+1;

    always@(count) begin
        case(count)
            0: begin outX <= 1'b1; outY <=1 'b0; end
            1: begin outX <= 1'b1; outY <=1 'b1; end
            2: begin outX <= 1'b0; outY <=1 'b1; end
            3: begin outX <= 1'b0; outY <=1 'b0; end
        endcase
    end

    assign X = outX;
    assign Y = outY;
endmodule

// --------------------------------------------------------

module genZ(input clkTz, output Z);
    reg outZ;
    reg [10:0] i;

    always@(posedge clkTz) begin
        if(i==1999) begin
            i<=0;
            outZ<=1'b1; end
        else begin
            i<=i+1;
            outZ<=1'b0; end
    end

    assign Z = outZ;
endmodule
