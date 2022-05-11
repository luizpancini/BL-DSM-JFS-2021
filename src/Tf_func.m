function [Tf_n,Tf_m,Tf_c] = Tf_func(Tf0,theta,R,q,P,RD_theta,S)

if theta*q >= 0 % Upstroke
    Tf_n = Tf0;
    Tf_m = Tf0;
    if abs(theta) < 1
        Tf_c = Tf0/2; % /2 is due to faster dynamics
    else
        Tf_c = Tf0/2*abs(theta)^2; % abs(theta)^2 to increase the lag after stall, in deep stall
    end
else            % Downstroke
    Tf_n = Tf0*(1+S*(RD_theta^(-1/4)-R^(1/4))); % S to apply only if stall occurred, RD_theta^(-1/4)-R^(1/4) to sharply increase Tf at returns
    if Tf_n < Tf0/2
        Tf_n = Tf0/2;
    end
    Tf_m = (Tf_n+Tf0*(S/RD_theta*(RD_theta^(-1/8)-R^(1/8))))/(4-2*P); % -2*P to increase delay at light stall
    if abs(theta) < 1
        Tf_c = Tf0*(1/2+R*1); % R*(1-P^(1/2)) to increase lag at high pitch rates, but only in deep stall
    else
        Tf_c = Tf0*(abs(theta)^2/2+R*1); 
    end
end