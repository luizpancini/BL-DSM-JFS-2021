function [time, alpha, cn_interp, cm_interp, cc_interp] = interp_coefs(data,alpha_0,delta_alpha,N)

time_cl_exp = data{7,1};
cl_exp = data{8,1};
time_cm_exp = data{9,1};
cm_exp = data{10,1};
time_cd_exp = data{11,1};
cd_exp = data{12,1};

time = linspace(-90,270,N);
alpha = alpha_0 + delta_alpha*sind(time);

cl_interp = spline(time_cl_exp,cl_exp,time);
cm_interp = spline(time_cm_exp,cm_exp,time);
cd_interp = spline(time_cd_exp,cd_exp,time);
cn_interp = zeros(1,N);
cc_interp = zeros(1,N);
for i=1:N
    % c_n and c_c
    A = [cos(alpha(i)) sin(alpha(i));
         sin(alpha(i)) -cos(alpha(i))];
    b = [cl_interp(i); cd_interp(i)];
    x = A*b;
    cn_interp(i) = x(1);
    cc_interp(i) = x(2);
end


