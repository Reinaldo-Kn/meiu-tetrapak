# MEI-U Tetra Pak Creasers

## English

### How to run Verilog in VS Code on Windows

1. Install [Icarus Verilog](http://iverilog.icarus.com/) and select all options during installation.
2. Install [GTKWave](http://gtkwave.sourceforge.net/) for waveform visualization if it was not installed in the previous step.
3. In VS Code, install the [Verilog HDL](https://github.com/leafvmaple/vscode-verilog?tab=readme-ov-file) extension.

### During development

Unlike Quartus, Icarus Verilog requires a test file (testbench) to simulate the circuit. Therefore, create a test file for each module you develop.

Use `$dumpfile` and `$dumpvars` in the test file to generate the `.vcd` file that will be opened in GTKWave.

Example:

`somadorcompleto.v`

```verilog
module somador(a,b,ci,s,co);
input a,b,ci;
output s,co;

assign s = a ^ b ^ ci;
assign co = (a & b) | (a & ci) | (b & ci);

endmodule
```

`somadorcompleto_tb.v`

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

### How to compile and simulate

- Syntax and semantic check:

```bash
iverilog somadorcompleto.v
```

Expected output: `\0`

- Full compilation:

```bash
iverilog -o somadorcompleto.vvp somadorcompleto_tb.v
```

Expected output: `\0`

Generated file: `somadorcompleto.vvp`

- Simulation:

```bash
vvp somadorcompleto.vvp
```

Expected output: `finish`

Generated file: `somadorcompleto.vcd`

- Open GTKWave:

```bash
gtkwave somadorcompleto.vcd
```

---

# Rainureuses MEI-U Tetra Pak

## Français

### Comment exécuter Verilog dans VS Code sous Windows

1. Installez [Icarus Verilog](http://iverilog.icarus.com/) et sélectionnez toutes les options pendant l'installation.
2. Installez [GTKWave](http://gtkwave.sourceforge.net/) pour visualiser les formes d'onde s'il n'a pas été installé à l'étape précédente.
3. Dans VS Code, installez l'extension [Verilog HDL](https://github.com/leafvmaple/vscode-verilog?tab=readme-ov-file).

### Pendant le développement

Contrairement à Quartus, Icarus Verilog nécessite un fichier de test (testbench) pour simuler le circuit. Créez donc un fichier de test pour chaque module que vous développez.

Utilisez `$dumpfile` et `$dumpvars` dans le fichier de test afin de générer le fichier `.vcd` qui sera ouvert dans GTKWave.

Exemple :

`somadorcompleto.v`

```verilog
module somador(a,b,ci,s,co);
input a,b,ci;
output s,co;

assign s = a ^ b ^ ci;
assign co = (a & b) | (a & ci) | (b & ci);

endmodule
```

`somadorcompleto_tb.v`

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

### Comment compiler et simuler

- Vérification syntaxique et sémantique :

```bash
iverilog somadorcompleto.v
```

Sortie attendue : `\0`

- Compilation complète :

```bash
iverilog -o somadorcompleto.vvp somadorcompleto_tb.v
```

Sortie attendue : `\0`

Fichier généré : `somadorcompleto.vvp`

- Simulation :

```bash
vvp somadorcompleto.vvp
```

Sortie attendue : `finish`

Fichier généré : `somadorcompleto.vcd`

- Ouvrir GTKWave :

```bash
gtkwave somadorcompleto.vcd
```
