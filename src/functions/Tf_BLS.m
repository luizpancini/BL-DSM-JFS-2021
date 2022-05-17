function Tf = Tf_BLS(Tf0,theta,tau_v,TvL,alpha,q,f2prime,fb)

if theta >= 1 % Vortex shedding phase
    % Primary vortex
    if tau_v<=TvL && alpha*q>=0
        Tf = Tf0;       % Nominal rate of boundary layer dettachment during the vortex convection
    elseif tau_v>TvL && tau_v<=1.5*TvL && alpha*q>=0
        Tf = Tf0/1;     % Accelerate the rate of dettachment after the vortex reaches the trailing edge 
    elseif tau_v>1.5*TvL && alpha*q>=0
        Tf = Tf0/1;     % Maintain the rate of boundary layer dettachment after the vortex is totally shed
    elseif tau_v<=1.5*TvL && alpha*q<0
        Tf = Tf0/1;     % Maintain the rate of dettachment if the rate of change of AoA changes during the vortex shedding 
    elseif tau_v>1.5*TvL && alpha*q<0
        Tf = 4*Tf0;     % Delay the reattachment of the boundary layer after the vortex is totally shed and the AoA is decreasing
    end
else % Reattachment phase
    Tf =  4*Tf0;     % Delay the reattachment of the boundary layer
    if f2prime>=fb && alpha*q>=0 % Dimitriadis' suggestion 
        Tf = Tf0;   % Set to nominal conditions if the rate of change of AoA is increasing and the flow is lightly separated
    elseif f2prime<fb && alpha*q>=0
        Tf = Tf0; % Accelerate boundary layer reattachment if the rate of change of AoA is already increasing and the flow is still massively separated
    end
end

