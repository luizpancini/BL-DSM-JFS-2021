function y = find_fM(x,c_mf,c_nf,K0,K1,K2,K3,kappa,R,S,P,theta,q)

if theta*q > 0
    d = -R*abs(theta)*(1-x);
else
    d = 0; 
    K2 = K2*(1+2*R^2*S*(1-P)); 
end
y = (K0+K1*(1-x)+K2*sin(pi*x^kappa)+K3*d)*c_nf-c_mf;

end