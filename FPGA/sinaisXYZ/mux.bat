@echo off
echo ========================================
echo  Compilando e simulando Encoder Verilog
echo ========================================

:: Etapa 1: Compila tudo com Icarus Verilog
echo [1/3] Compilando...
iverilog -o encoder_mux.vvp encoder_mux_tb.v

if %errorlevel% neq 0 (
    echo  Erro na compilacao!
    pause
    exit /b %errorlevel%
)

:: Etapa 2: Executa a simulação
echo [2/3] Executando simulacao...
vvp encoder_mux.vvp

if not exist encoder_mux.vcd (
    echo Arquivo encoder_mux.vcd nao gerado!
    pause
    exit /b 1
)

:: Etapa 3: Abre GTKWave
echo [3/3] Abrindo GTKWave...
start gtkwave encoder.vcd

echo Simulacao concluida com sucesso!
pause
