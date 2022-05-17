function [c_m,c_mC,c_mf,c_mI,c_mv,dCP] = cm_coeff_BLS(x,c_nf,c_nv,M,alpha,q,T_I,K0,K1,K2,kappa,tau_v,TvL,c_m0,U,b,beta,T_M,B2,f_prime)

% Circulatory
c_mC = pi/(4*beta)*U/(b*T_M)*x(5); % Not actually used...

% Impulsive
c_mI = -4/M*(alpha/2+7*q/24-U/(b*T_I)*x(6));

% Circulatory unsteady
if f_prime >= x(9) 
    fM = f_prime; 
else
    fM = x(9);
end
dCP = K0 + K1*(1-fM) + K2*sin(pi*fM^kappa);
c_mf = dCP*c_nf; 

% Vortex-induced
c_mv = -B2*(1-cos(pi*tau_v/TvL))*c_nv;

% Total
c_m = c_mf+c_mv+c_mI+c_m0;

