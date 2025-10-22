%% Parâmetros de simulação do vincador
% Deve ser executado antes de rodar o modelo do Simulink.

pulsosPorVolta = 500;
velocidadeMetrosMinuto = 450;
diametroCm = 30;   % diâmetro 30 cm (suposição)
diametroM = diametroCm/100;

rpm = velocidadeMetrosMinuto/(pi*diametroM);   % Rotações por minuto
rps = rpm/60;   % Rotações por segundo
Trotacao = 1/rps;   % Período de uma rotação completa
Tencoder = Trotacao/pulsosPorVolta;   % período de um ciclo do encoder (500 ciclos por volta)

% largura do pulso do sincronismo em relação ao período do pulso do encoder
% a largura do pulso de sincronismo é 0.25 da largura de um ciclo do encoder
TpulseFraction = 0.25;

delay1 = Tencoder*(TpulseFraction);   % deslocamento do pulso de sincronismo
delay2 = Tencoder*(TpulseFraction/2); % deslocamento do pulso do encoder em quadratura (canal Y)

%% Parâmetros do simulador sem sampler

Tsimul = Tencoder*1100;   % tempo total da simulação (1100 engloba mais de 2 voltas)
maxstep = Tencoder/50;   % limitador do passo máximo de simulação (necessário)

%% Parâmetros do simulador com sampler 50 MHz

Tsimul = Tencoder*550;   % tempo total da simulação. Tem que ser menor pois a simulação fica muito demorada
fSampler = 50e6;  % Frequência de clock do amostrador do concentrador (50 MHz)
TSampler = 1/fSampler;  % período
maxstep = TSampler/10;   % limitador do passo máximo de simulação (necessário)

% 450m/min, Tencoder=2.5133e-4, maxstep=2.5133e-6
% fSampler=50e6, TSampler=2e-8, maxstep=2e-10

%%
Tsimul = 5000*TSampler;
%% Calcula o número total de amostras dos sinais do encoder

velocidadeMetrosMinuto
Tencoder
fSampler
numAmostrasEncoder = Tencoder/TSampler
numAmostrasPulse = Tencoder/TSampler*0.25

%% Estimativas do grupo dia 9-dez

erro = 0.00001 % erro em m
perimetro = pi*0.3
distanciaPulso = perimetro/500
pulsosErro = distanciaPulso/erro
fosc=50e6
Tosc=4/fosc
Tpulso = 260e-6 % 450 m/min
Terro = pulsosErro*Tpulso
