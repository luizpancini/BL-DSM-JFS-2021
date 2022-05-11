function [c_m,c_mC,c_mf,c_mI,dCP] = cm_coeff(x,c_nf,M,alpha,q,A3,b3,A4,b4,K_aM,K_qM,T_I,K0,K1,K2,K3,kappa,c_m0,c_nC,U,b,beta,x_ac,b5,f2prime_m,theta,R,S,P,RD,alpha_dot,alpha_2dot)

% Circulatory unsteady (Not actually used...)
c_mC = c_nC*(0.25-x_ac)-pi/8*b5*beta^2*U/b*x(7); 

% Circulatory unsteady
if theta*q > 0
    d = -R*abs(theta)*(1-f2prime_m); % Additional term on modeling of the movement of the CP on stalled conditions: proportional to (1-f2prime_m), R*abs(theta) to maintain continuity
else
    d = 0; 
    K2 = K2*(1+1*R*RD^3*S*(1-P)*abs(theta)^(1/4)); % 2*R because proportional to pitch rate, S to apply only if stall occured, (1-P) to reduce effect at light stall
end
dCP = K0 + K1*(1-f2prime_m) + K2*sin(pi*f2prime_m^kappa) + K3*d;
c_mf = dCP*c_nf;

% Impulsive
c_mI = A3/(M*b3*K_aM*T_I)*x(5) + A4/(M*b4*K_aM*T_I)*x(6) + 7/(12*M*K_qM*T_I)*x(8) - 1/M*alpha - 7/(12*M)*q;
% c_mI = -1/2*pi*b/(16*U^2)*(8*U*alpha_dot+b*(1-4*-0.5)*alpha_2dot); % Theodorsen's incompressible flow inertial coefficient (if *1/2, then halved - better correlation) 

% Total
c_m = c_mf+c_mI+c_m0;

