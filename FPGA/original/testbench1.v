// ----------------------------------------------
// Testbench 1 Tetrapak
// Test the generation of signals X, Y, Z
// ----------------------------------------------

module testbench1(
    input clk50,
    output sigX, sigY, sigZ );

    wire clkz;

    clockDivider1 m_clk1( .clki(clk50), .clko(clkz) );
    genXY m_sigXY( .clkTz(clkz), .X(sigX), .Y(sigY) );
    genZ  m_sigZ ( .clkTz(clkz), .Z(sigZ) );
endmodule

// Type this command to change the directory
// cd "C:/Users/mauri/Documents/QuartusProjects/Tetrapak/"
// To see the current folder, type:
// pwd
// To enable RTL view into Modelsim:
