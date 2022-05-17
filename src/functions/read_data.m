function [authors,data,params] = read_data(input,model)

%% Handle input
if length(input) == 1
    if input > 1e6
        GUD = input;
    elseif input > 1000
        frame = input; 
    else
        other = input;
    end
else
    test = input;
end

%% Load data from frame, run or desired test condition
if exist('frame','var')
    [b,a_inf,airfoil,M,a_0,a_1,k,alpha_exp_cl,cl_exp,alpha_exp_cm,cm_exp,alpha_exp_cd,cd_exp,alpha_exp_cn,cn_exp,alpha_exp_cc,cc_exp,time_exp_cl,clt_exp,time_exp_cm,cmt_exp,time_exp_cd,cdt_exp,authors] = load_frame(frame);
    time_exp_cn = nan; cnt_exp = nan; time_exp_cc = nan; cct_exp = nan;
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
elseif exist('GUD','var')
    [b,a_inf,airfoil,M,a_0,a_1,k,alpha_exp_cl,cl_exp,alpha_exp_cm,cm_exp,alpha_exp_cd,cd_exp,alpha_exp_cn,cn_exp,alpha_exp_cc,cc_exp,time_exp_cl,clt_exp,time_exp_cm,cmt_exp,time_exp_cd,cdt_exp,authors,time_exp_cn,cnt_exp,time_exp_cc,cct_exp] = load_GUD(GUD);
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
elseif exist('other','var')
    [b,a_inf,airfoil,M,a_0,a_1,k,alpha_exp_cl,cl_exp,alpha_exp_cn,cn_exp,alpha_exp_cm,cm_exp,alpha_exp_cd,cd_exp,alpha_exp_cc,cc_exp,alpha_mod_cl,cl_mod,alpha_mod_cn,cn_mod,alpha_mod_cm,cm_mod,alpha_mod_cd,cd_mod,alpha_mod_cc,cc_mod,authors] = load_other(other);
    time_exp_cl = nan; clt_exp = nan; time_exp_cm = nan; cmt_exp = nan; time_exp_cd = nan; cdt_exp = nan; time_exp_cn = nan; cnt_exp = nan; time_exp_cc = nan; cct_exp = nan;
elseif exist('test','var')
    % Standard values for b and a_inf if not input
    if length(test) == 5
        b = 0.61/2;     % Same as NASA's experiment (see McAlister et al. (1982) - page 14)
        a_inf = 340;    % Assumed MSL conditions
    elseif length(test) == 6
        b = test{6};
        a_inf = 340;
    elseif length(test) == 7
        b = test{6};
        a_inf = test{7};   
    else
        error('Set test as a cell with at least 5 and at most 7 entries')
    end
    % Set remaining test conditions
    M = test{1}; k = test{2}; a_0 = test{3}; a_1 = test{4}; airfoil = test{5}; 
    authors{1} = nan;
    alpha_exp_cl = nan; cl_exp = nan; alpha_exp_cm = nan; cm_exp = nan; alpha_exp_cd = nan; cd_exp = nan; alpha_exp_cn = nan; cn_exp = nan; alpha_exp_cc = nan; cc_exp = nan;
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    time_exp_cl = nan; clt_exp = nan; time_exp_cm = nan; cmt_exp = nan; time_exp_cd = nan; cdt_exp = nan; time_exp_cn = nan; cnt_exp = nan; time_exp_cc = nan; cct_exp = nan;
end

%% Gather data
data = {alpha_exp_cl; cl_exp; alpha_exp_cm; cm_exp; alpha_exp_cd; cd_exp; time_exp_cl; clt_exp; time_exp_cm; cmt_exp; time_exp_cd; cdt_exp; alpha_exp_cn; cn_exp; alpha_exp_cc; cc_exp; alpha_mod_cl; cl_mod; alpha_mod_cm; cm_mod; alpha_mod_cd; cd_mod; alpha_mod_cn; cn_mod; alpha_mod_cc; cc_mod; time_exp_cn; cnt_exp; time_exp_cc; cct_exp};

%% Flow properties
U = M*a_inf;        % Airspeed
beta = sqrt(1-M^2); % Prandtl-Glauert compressibility factor

%% Airfoil parameters
switch model
    case "BL"
        params = airfoil_parameters(airfoil,M,U,b);
    case "BLS"
        params = airfoil_parameters_BLS(airfoil,M,U,b);
end

%% Set all flow and test condition variables into the params struct
params.M = M;
params.U = U;
params.b = b;
params.a_inf = a_inf;
params.beta = beta;
params.a_0 = a_0;
params.a_1 = a_1;
params.k = k;
params.airfoil = airfoil;

end