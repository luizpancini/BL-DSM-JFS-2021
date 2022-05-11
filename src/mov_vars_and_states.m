function [alpha,alpha_dot,q,qR,R,alpha_2dot,q_dot,qR_dot,R_dot,so_state,f2prime_n,f2prime_m,f2prime_c,RD,RD_theta] = mov_vars_and_states(t,x,U,b,k,a_0,a_1,r0)

%% Movement variables
alpha = a_0 + a_1*sin(k*U/b*t);
alpha_dot = a_1*k*U/b*cos(k*U/b*t);
alpha_2dot = -a_1*(k*U/b)^2*sin(k*U/b*t);
q = 2*alpha_dot*b/U;
qR = abs(q/2)/r0; % Ratio of reduced pitch rate to critical pitch rate
if qR > 1
    R = 1; 
else
    R = qR;    
end
q_dot = 2*alpha_2dot*b/U;
qR_dot = (q_dot/2)/(r0*k*U/b);
if abs(qR_dot) > 1
    R_dot = 1*sign(qR_dot); 
else
    R_dot = qR_dot;    
end

%% States
so_state = x(9);
f2prime_n = x(10);
f2prime_m = x(11);
f2prime_c = x(12);
RD = x(13);
RD_theta = x(14);