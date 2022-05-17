function xdot = state_space_BLS(x,xdot,alpha,q,A,B,f_prime,Tf,Ta,f,Tf0)

% Potential flow linear states
xdot(1) = A(1)*x(1)+B(1,1)*alpha+B(1,2)*q; 
xdot(2) = A(2)*x(2)+B(2,1)*alpha+B(2,2)*q; 
xdot(3) = A(3)*x(3)+B(3,1)*alpha+B(3,2)*q;
xdot(4) = A(4)*x(4)+B(4,1)*alpha+B(4,2)*q;
xdot(5) = A(5)*x(5)+B(5,1)*alpha+B(5,2)*q; 
xdot(6) = A(6)*x(6)+B(6,1)*alpha+B(6,2)*q; 
% Nonlinear states
xdot(7) = (alpha-x(7))/Ta;                % Delayed effective AoA
xdot(8) = (f_prime-x(8))/Tf;              % f'', the further delayed separation point
xdot(9) = (f-x(9))/(Tf0/2);               % fM