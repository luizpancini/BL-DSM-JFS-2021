function [f,fprime_n,fprime_m,fprime_c,Sigma2] = sep_points(so_state,f0,fb,alpha,alpha1_n,alpha_ss,S1,S2,R,q,theta,RD,alpha1_m,alpha1_c,theta_max,theta_min,RD_tv0,R_dot,P,T,df0_c,fSig_1n,fSig2_n,fS2_n,fS2_c_up,fS2_c_down)

%%%%%%%%%%
if abs(theta_max) > 1
    Sigma1 = P^3*(1-T); % Factor defining the flattening of f_prime for light stall, (1-T) to not apply on static conditions
    fb_ext = fb;
else
    Sigma1 = 0;
    fb_ext = f0;
end
if sign(theta_min*theta) 
    Sigma2 = abs(theta_min)^2.5; % Factor defining how close to stalling angle has been at beginning of upstroke
    if Sigma2 > 0.5
        Sigma2 = 0.5; 
    end
else
    Sigma2 = 0;
end
%%%%%%%%%%%%%%%%%%%%
% Quasi-steady condition separation point based on angle of incidence 
if abs(alpha) <= alpha_ss
    f = 1-(1-fb)*exp((abs(alpha)-alpha_ss)/S1);
else
    f = f0+(fb-f0)*exp((alpha_ss-abs(alpha))/S2);
end
% Static stall S2 modifiers:
% These variables modify the S2 constant in order to account for faster
% drop and slow growth of the coefficients at stall in almost static
% conditions. The exponential terms garantee that only
% almost static conditions are affected (exp(-20*RD)), e.g. frames 
% 9210, 9221, but not when stall happens close to ends of movement, i.e.
% relatively high accelerations (exp(-30*abs(R_dot))), e.g. frames 10202 and 10203.
% For the moment and chordwise force, the term D2_S2mc is used in the 
% downstroke to compensate the reattachment rate due to the increased delay
% on dalpha_1m and dalpha_1c.
D_S2n = exp(-20*RD)*exp(-30*abs(R_dot)); 
D_S2mc = T^2/2;
% Normal force - Unsteady lagged separation point based on lagged AoA
if abs(so_state) <= alpha1_n
    if theta*q > 0
        S1_prime = S1; 
    else
        S1_prime = S1*(1+R^2); % +R^2 to delay reattachment at end of downstroke at high pitch rates
    end
    fprime_n = 1-(1-fb)*exp((abs(so_state)-alpha1_n)/S1_prime);
else
    f0_n = f0+Sigma2/4*((1-cos(2*pi*RD_tv0))/2)+Sigma2/20*(1-RD_tv0^2); % Sigma2/4*((1-cos(2*pi*RD_tv0))/2)+Sigma2/20*(1-RD_tv0^2) is to match the lower c_n drop of oscillations around stall
    if theta*q > 0 % Upstroke
        f1_n = fb-f0_n;
        S2_prime = S2*(1+fS2_n*(1-RD^(1/2))-D_S2n+fSig2_n*Sigma2*RD*(1-RD)); % fS2_n*(1-RD^(1/2)) to delay the dettachment at low pitch rates, so as +fSig2_n*Sigma2*RD*(1-RD) [RD*(1-RD) to have greater effect on medium pitch rates, e.g. frames 10117 and 10118], -D_S2n to match rapid c_n drop and slow growth at stall in almost static conditions
        fprime_n = f0_n+f1_n*exp((alpha1_n-abs(so_state))/S2_prime);
    else           % Downstroke
        % If did not stall, do not allow f_prime to enter in stalled conditions
        % in the downstroke - extend fb down, check results on e.g. frame 9106 
        S1_prime = 2*S1; % Set increased S1 - flatten the reattachment
        S2_prime = S2*(1+fS2_n*(1-RD^(1/2))-D_S2n+fSig_1n*Sigma1+fSig2_n*Sigma2*RD*(1-RD)); % fS2_n*(1-RD^(1/2)) to accelerate the reattachment at low pitch rates, +fSig_1n*Sigma1 is to greatly flatten the reattachment on light stall
        f_prime_n_ext = 1-(1-fb)*exp((abs(so_state)-alpha1_n)/S1_prime);
        if f_prime_n_ext > fb_ext       
            fprime_n = f_prime_n_ext;
        else
            w = S1_prime*log((fb_ext - 1)/(fb - 1));
            f1_n = fb_ext-f0_n;
            alpha1_n = alpha1_n+w;
            fprime_n = f0_n+f1_n*exp((alpha1_n-abs(so_state))/S2_prime);
        end
    end
end

% Moment
if abs(so_state) <= alpha1_m
    S1_prime = S1*(1-1/2*RD^2); % Sharpen the detachment/reattachment at high pitch rates
    fprime_m = 1-(1-fb)*exp((abs(so_state)-alpha1_m)/S1_prime);
else
    f0_m = f0+Sigma2/4*((1-cos(2*pi*RD_tv0))/2)+Sigma2/4*(1-RD_tv0^2);
    if theta*q > 0 % Upstroke
        f1_m = fb-f0_m;
        S2_prime = S2*(1+1*RD); % +1*RD to delay the dettachment
        fprime_m = f0_m+f1_m*exp((alpha1_m-abs(so_state))/S2_prime);
    else           % Downstroke
        S1_prime = 2*S1; % Set increased S1 - flatten the reattachment
        S2_prime = S2*(1+2*RD+D_S2mc); % 2*RD and T to accelerate reattachment, +D2_S2mc to delay reattachment in static condition
        f_prime_m_ext = 1-(1-fb)*exp((abs(so_state)-alpha1_m)/S1_prime);
        if f_prime_m_ext > fb_ext       
            fprime_m = f_prime_m_ext;
        else
            f0_m = f0+Sigma2/4*((1-cos(2*pi*RD_tv0))/2)+Sigma2/4*(1-RD_tv0^2); 
            w = S1_prime*log((fb_ext - 1)/(fb - 1));
            f1_m = fb_ext-f0_m;
            alpha1_m = alpha1_m+w;
            fprime_m = f0_m+f1_m*exp((alpha1_m-abs(so_state))/S2_prime);
        end
    end
end

% Chordwise force
if abs(so_state) <= alpha1_c
    if theta*q > 0 % Upstroke
        S1_prime = S1*(1-3/4*RD); % Sharpen the dettachment proportional to pitch rate (RD instead of R to follow the peak at high pitch rates in light stall)
    else           % Downstroke
        S1_prime = S1*(1+RD);     % Flatten reattachment at higher pitch rates
    end
     fprime_c = 1-(1-fb)*exp((abs(so_state)-alpha1_c)/S1_prime);
else
     f0_c = f0+Sigma2/2*((1-cos(2*pi*RD_tv0))/2)+Sigma2/4*(1-RD_tv0^2)+df0_c*(1-RD_tv0)^(1/4); 
     if f0_c > 0.2
         f0_c = 0.2;
     end
    if theta*q > 0 % Upstroke
        f1_c = fb-f0_c;
        S2_prime = S2*(1+fS2_c_up*R^2-D_S2mc); % fS2_c_up*R^2 to delay the dettachment in high pitch rates (R instead of RD to match the fast drop in light stall, squared to match behavior at medium pitch rates)
        fprime_c = f0_c+f1_c*exp((alpha1_c-abs(so_state))/S2_prime);
    else           % Downstroke
        S1_prime = 2*S1; % Set increased S1 - flatten the reattachment
        S2_prime = S2*(1+2*R^2+fS2_c_down*Sigma1*RD^(1/4)-D_S2mc); % 2*R^2 to accelerate reattachment, +2*Sigma1 is to flatten the reattachment on light stall, D_S2mc to delay reattachment in static condition
        f_prime_c_ext = 1-(1-fb)*exp((abs(so_state)-alpha1_c)/S1_prime);
        if f_prime_c_ext > fb_ext       
            fprime_c = f_prime_c_ext;
        else
            w = S1_prime*log((fb_ext - 1)/(fb - 1));
            f1_c = fb_ext-f0_c;
            alpha1_c = alpha1_c+w;
            fprime_c = f0_c+f1_c*exp((alpha1_c-abs(so_state))/S2_prime);
        end
    end
end
 
    
end