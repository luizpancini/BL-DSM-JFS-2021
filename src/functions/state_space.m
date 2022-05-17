function xdot = state_space(x,xdot,alpha,q,R,RD,A,B,Tf_n,Tf_m,Tf_c,Ta,fprime_n,fprime_m,fprime_c,fSS)

% Potential flow states 
xdot(1) = A(1)*x(1)+B(1,1)*alpha+B(1,2)*q; 
xdot(2) = A(2)*x(2)+B(2,1)*alpha+B(2,2)*q; 
xdot(3) = A(3)*x(3)+B(3,1)*alpha+B(3,2)*q;
xdot(4) = A(4)*x(4)+B(4,1)*alpha+B(4,2)*q;
xdot(5) = A(5)*x(5)+B(5,1)*alpha+B(5,2)*q; 
xdot(6) = A(6)*x(6)+B(6,1)*alpha+B(6,2)*q; 
xdot(7) = A(7)*x(7)+B(7,1)*alpha+B(7,2)*q; 
xdot(8) = A(8)*x(8)+B(8,1)*alpha+B(8,2)*q; 

% Nonlinear states
xdot(9) = (alpha-x(9))/Ta;                % Delayed AoA 
xdot(10) = (fprime_n-x(10))/Tf_n;         % Delayed separation point - normal force
xdot(11) = (fprime_m-x(11))/Tf_m;         % Delayed separation point - pitch moment
xdot(12) = (fprime_c-x(12))/Tf_c;         % Delayed separation point - chordwise force
xdot(13) = (R-x(13))/(Ta*3);              % Delayed reduced pitch rate
xdot(14) = (R-x(14))/(Ta/(4-fSS*RD^2));   % Slightly delayed reduced pitch rate for the delayed AoA - /(4-fSS*RD^2) to increase the lag on very high pitch rates

end