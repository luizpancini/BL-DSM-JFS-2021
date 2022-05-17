function [c_n,c_nC,c_nf,c_nI,c_nv,alpha_E] = cn_coeff_BLS(x,U,b,M,beta,A1,A2,A3,b1,b2,b3,T_I,alpha,q,c_n_alpha,f,f2prime,B1,alpha_0L,tau_v,TvL)

% Circulatory
alpha_E = beta^2*U/b*(A1*b1*x(1)+A2*b2*x(2)+A3*b3*x(3));
c_nC = c_n_alpha*(alpha_E-alpha_0L);

% Circulatory unsteady
K_f = ((1+sqrt(f2prime))/2)^2;
c_nf = c_nC*K_f;

% Impulsive
c_nI = 4/M*(alpha+q/4-U/(b*T_I)*x(4));

% Vortex
if tau_v <= TvL && f2prime >= f
    Vx = (sin(pi/2*tau_v/TvL))^(3/2);
elseif tau_v > TvL && tau_v <= 2.5*TvL && f2prime >= f % If want to restrain c_nv just up to tau = 1.5*Tvl - just one peak
    Vx = (cos(pi*(tau_v-TvL)/TvL))^2;
else
    Vx = 0;
end
c_nv = B1*(f2prime-f)*Vx; 

% Total
c_n = c_nf+c_nI+c_nv;

