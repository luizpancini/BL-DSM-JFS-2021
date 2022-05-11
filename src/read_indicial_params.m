function params = read_indicial_params(params)

% Unpack
M = params.M;
b = params.b;
beta = params.beta;
a_inf = params.a_inf;
airfoil = params.airfoil;

%% Circulatory indicial parameters
% Nominal values 
params.A1 = 0.3;
params.A2 = 0.7;
params.A3 = 1.5;
params.A4 = -0.5;
b1_0 = 0.14;
b2_0 = 0.53;
params.b3 = 0.25;
params.b4 = 0.1;
params.b5 = 0.5;

% Adjustments for each airfoil
if strcmp(airfoil,'NACA0012')
    params.b1 = b1_0*2.5;
    params.b2 = b2_0*0.8;
elseif strcmp(airfoil,'AMES-01')
    params.b1 = b1_0*3.0;
    params.b2 = b2_0*0.6;
elseif strcmp(airfoil,'NLR-7301')
    params.b1 = b1_0*2.5;
    params.b2 = b2_0*0.8;
elseif strcmp(airfoil,'S809')
    params.b1 = b1_0*2.5;
    params.b2 = b2_0*0.8;    
end

%% Impulsive indicial parameters
% Nominal values
params.K_a = 1/(1-M+pi*beta*M^2*(params.A1*b1_0+params.A2*b2_0)); 
params.K_q = 1/(1-M+2*pi*beta*M^2*(params.A1*b1_0+params.A2*b2_0)); 
params.K_aM = (params.A3*params.b4+params.A4*params.b3)/(params.b3*params.b4*(1-M)); 
params.K_qM = 7/(15*(1-M)+3*pi*beta*M^2*params.b5); 
params.T_I = 2*b/a_inf;

% Leishman and Nguyen (1989) say they have reduced the K constants by 25% to
% match experimental data (see Conclusions of their paper). Here we apply
% that only for M > 0.07, and only for c_n related impulsive parameters.
if M > 0.07
    fac = 0.75;
else
    fac = 1-0.25*(M/0.07)^2;
end
params.K_a = params.K_a*fac; 
params.K_q = params.K_q*fac;

% Adjustments for each airfoil
if strcmp(airfoil,'NACA0012')
    params.K_aM = params.K_aM*1.0; 
    params.K_qM = params.K_qM*1.0;
elseif strcmp(airfoil,'AMES-01')
    params.K_aM = params.K_aM*1.25; 
    params.K_qM = params.K_qM*1.25;
elseif strcmp(airfoil,'NLR-7301')
    params.K_aM = params.K_aM*1.0; 
    params.K_qM = params.K_qM*1.0;
elseif strcmp(airfoil,'S809')
    params.K_aM = params.K_aM*1.0; 
    params.K_qM = params.K_qM*1.0;    
end
