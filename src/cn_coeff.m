function [c_n,c_nC,c_nf,c_nI,alpha_E,K_f] = cn_coeff(x,M,U,b,beta,c_n_alpha,A1,A2,b1,b2,K_a,K_q,T_I,alpha,q,f2prime_n,alpha_0L,alpha_dot,alpha_2dot)

% Circulatory
alpha_E = beta^2*U/b*(A1*b1*x(1)+A2*b2*x(2));
c_nC = c_n_alpha*sin(alpha_E-alpha_0L);

% Circulatory unsteady
K_f = ((1+f2prime_n^(1/2))/2)^2;
c_nf = c_nC*K_f;

% Impulsive
c_nI = -4/(M*K_a*T_I)*x(3)-1/(M*K_q*T_I)*x(4)+4/M*alpha+1/M*q;
% c_nI = 2*pi*b/U^2*(U*alpha_dot-b*-0.5*alpha_2dot); % Theodorsen's incompressible flow inertial coefficient (if 2*pi..., then doubled - better correlation)

% Total
c_n = c_nf+c_nI;
