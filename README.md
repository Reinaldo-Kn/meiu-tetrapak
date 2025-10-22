# MEI-U Tetrapak Vincadores

## Como rodar verilog no VScode e ambiente windows

1. Instale o [Icarus Verilog](http://iverilog.icarus.com/) e marque todas as opções durante a instalação.
2. Instale o [GTKWave](http://gtkwave.sourceforge.net/) para visualizar, caso não tenha baixado na etapa anterior.
3. No VScode, instale a extensão [Verilog HDL](https://github.com/leafvmaple/vscode-verilog?tab=readme-ov-file).


## Durante o desenvolvimento
Diferente do Quartus, o Icarus Verilog precisa de um arquivo de teste.v (testbench) para simular o circuito. Portanto, crie um arquivo de teste para cada módulo que você criar.
Use $dumpfile e $dumpvars no arquivo de teste para gerar o arquivo .vcd que será aberto no GTKWave.
Exemplo:

somadorcompleto.v
```verilog
module somador(a,b,ci,s,co);
input a,b,ci;
output s,co;

assign s = a ^ b ^ ci;
assign co = (a & b) | (a & ci) | (b & ci);

endmodule
```
somadorcompleto_tb.v
```verilog
`include "somadorcompleto.v"
`timescale 1ns / 100ps
module somadorcompleto_tb;
reg a,b,ci;
wire s,co;
somadorcompleto uut (.a(a), .b(b), .ci(ci), .s(s), .co(co));
initial begin
    $dumpfile("somadorcompleto.vcd");
    $dumpvars(0, somadorcompleto_tb);
    a = 0; b = 0; ci = 0;
    #10 a = 0; b = 0; ci = 1;
    #10 a = 0; b = 1; ci = 0;
    #10 a = 0; b = 1; ci = 1;
    #10 a = 1; b = 0; ci = 0;
    #10 a = 1; b = 0; ci = 1;
    #10 a = 1; b = 1; ci = 0;
    #10 a = 1; b = 1; ci = 1;
    #10 $finish;

end
endmodule
```

## Como compilar e simular
- Compilador semantico:
```bash
iverilog somadorcompleto.v 
```
saida esperada: '\0'

- Compilação completa 
```bash
iverilog -o somadorcompleto.vvp somadorcompleto_tb.v
```
saida esperada: '\0'

arquivo gerado: 'somadorcompleto.vvp'

- Simulação
```bash
vvp somadorcompleto.vvp
```
saida esperada: 'finish'

arquivo gerado: 'somadorcompleto.vcd'
- Abrir o GTKWave
```bash
gtkwave somadorcompleto.vcd
```