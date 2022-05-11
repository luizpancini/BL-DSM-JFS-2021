function [b,a_inf,airfoil,M,alpha_0,delta_alpha,k,alpha_exp_cl,cl_exp,alpha_exp_cn,cn_exp,alpha_exp_cm,cm_exp,alpha_exp_cd,cd_exp,alpha_exp_cc,cc_exp,alpha_mod_cl,cl_mod,alpha_mod_cn,cn_mod,alpha_mod_cm,cm_mod,alpha_mod_cd,cd_mod,alpha_mod_cc,cc_mod,authors] = load_other(other)

if other == 1
    b = 0.61/2;     % Assumed, since they are comparing with data from McAlister (1982)
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    % McAlister (1982) [taken directly from Leishman and Crouse (1989)]
    file1 = '../Other Data/CN_alpha_LeishmanCrouse1989_A0_10_A1_10_EXP.mat';
    file2 = '../Other Data/CM_alpha_LeishmanCrouse1989_A0_10_A1_10_EXP.mat';
    load(file1)
    load(file2)
    alpha_exp_cn = CN_alpha_LeishmanCrouse1989_A0_10_A1_10_EXP(:,1);
    cn_exp = CN_alpha_LeishmanCrouse1989_A0_10_A1_10_EXP(:,2);
    alpha_exp_cm = CM_alpha_LeishmanCrouse1989_A0_10_A1_10_EXP(:,1);
    cm_exp = CM_alpha_LeishmanCrouse1989_A0_10_A1_10_EXP(:,2);
    alpha_exp_cl = nan; cl_exp = nan; alpha_exp_cd = nan; cd_exp = nan; alpha_exp_cc = nan; cc_exp = nan;
    authors{1} = 'McAlister et al. (1982)';
    % Leishman and Crouse (1989)
    file3 = '../Other Data/CN_alpha_LeishmanCrouse1989_A0_10_A1_10_BL.mat';
    file4 = '../Other Data/CM_alpha_LeishmanCrouse1989_A0_10_A1_10_BL.mat';
    load(file3)
    load(file4)
    alpha_mod_cn = CN_alpha_LeishmanCrouse1989_A0_10_A1_10_BL(:,1);
    cn_mod = CN_alpha_LeishmanCrouse1989_A0_10_A1_10_BL(:,2);
    alpha_mod_cm = CM_alpha_LeishmanCrouse1989_A0_10_A1_10_BL(:,1);
    cm_mod = CM_alpha_LeishmanCrouse1989_A0_10_A1_10_BL(:,2);
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    authors{2} = 'Leishman and Crouse (1989)';
    M = 0.3; 
    alpha_0 = 9.9*pi/180; 
    delta_alpha = 9.9*pi/180; 
    k = 0.1; 
elseif other == 2 % Actually A0 = 15 and A1 = 10 !!!
    b = 0.61/2;     % Assumed, since they are comparing with data from McAlister (1982)
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    % McAllister (1982) [taken directly from Leishman and Crouse (1989)]
    file1 = '../Other Data/CN_alpha_LeishmanCrouse1989_A0_10_A1_15_EXP.mat';
    file2 = '../Other Data/CM_alpha_LeishmanCrouse1989_A0_10_A1_15_EXP.mat';
    load(file1)
    load(file2)
    alpha_exp_cn = CN_alpha_LeishmanCrouse1989_A0_10_A1_15_EXP(:,1);
    cn_exp = CN_alpha_LeishmanCrouse1989_A0_10_A1_15_EXP(:,2);
    alpha_exp_cm = CM_alpha_LeishmanCrouse1989_A0_10_A1_15_EXP(:,1);
    cm_exp = CM_alpha_LeishmanCrouse1989_A0_10_A1_15_EXP(:,2);
    alpha_exp_cl = nan; cl_exp = nan; alpha_exp_cd = nan; cd_exp = nan; alpha_exp_cc = nan; cc_exp = nan;
    authors{1} = 'McAlister et al. (1982)';
    % Leishman and Crouse (1989)
    file3 = '../Other Data/CN_alpha_LeishmanCrouse1989_A0_10_A1_15_BL.mat';
    file4 = '../Other Data/CM_alpha_LeishmanCrouse1989_A0_10_A1_15_BL.mat';
    load(file3)
    load(file4)
    alpha_mod_cn = CN_alpha_LeishmanCrouse1989_A0_10_A1_15_BL(:,1);
    cn_mod = CN_alpha_LeishmanCrouse1989_A0_10_A1_15_BL(:,2);
    alpha_mod_cm = CM_alpha_LeishmanCrouse1989_A0_10_A1_15_BL(:,1);
    cm_mod = CM_alpha_LeishmanCrouse1989_A0_10_A1_15_BL(:,2);
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    authors{2} = 'Leishman and Crouse (1989)';
    M = 0.3; 
    alpha_0 = 15*pi/180; 
    delta_alpha = 10*pi/180; 
    k = 0.1;  
elseif other == 3 % Sheng et al (2008) - A Modified Dynamic Stall Model for Low Mach Numbers - Fig. 9
    b = 0.55/2;     % As displayed in Table 1 of Sheng et al (2006) - A New Stall-Onset Criterion for Low Speed Dynamic-Stall
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    % Experimental data
    file1 = '../Other Data/CN_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP.mat';
    file2 = '../Other Data/CM_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP.mat';
    file3 = '../Other Data/CC_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP.mat';
    file4 = '../Other Data/CD_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP.mat';
    load(file1)
    load(file2)
    load(file3)
    load(file4)
    alpha_exp_cn = CN_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,1);
    cn_exp = CN_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,2);
    alpha_exp_cm = CM_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,1);
    cm_exp = CM_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,2);
    alpha_exp_cd = CD_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,1);
    cd_exp = CD_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,2);
    alpha_exp_cc = CC_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,1);
    cc_exp = CC_alpha_Sheng_A0_15_A1_10_k0124_M0012_EXP(:,2);
    alpha_exp_cl = nan; cl_exp = nan; 
    % Model
    file1 = '../Other Data/CN_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD.mat';
    file2 = '../Other Data/CM_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD.mat';
    file3 = '../Other Data/CC_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD.mat';
    file4 = '../Other Data/CD_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD.mat';
    load(file1)
    load(file2)
    load(file3)
    load(file4)
    alpha_mod_cn = CN_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,1);
    cn_mod = CN_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,2);
    alpha_mod_cm = CM_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,1);
    cm_mod = CM_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,2);
    alpha_mod_cd = CD_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,1);
    cd_mod = CD_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,2);
    alpha_mod_cc = CC_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,1);
    cc_mod = CC_alpha_Sheng_A0_15_A1_10_k0124_M0012_MOD(:,2);
    alpha_mod_cl = nan; cl_mod = nan; 
    % Test conditions
    M = 0.12; 
    alpha_0 = 14.7*pi/180; 
    delta_alpha = 9.9*pi/180; 
    k = 0.124; 
    authors{1} = 'EXP - Sheng et al. (2008)';
    authors{2} = 'MOD - Sheng et al. (2008)';
elseif other == 4 % Sheng et al (2007) - Improved Dynamic-Stall-Onset Criterion at Low Mach Numbers - Fig. 5
    b = 0.55/2;     % As displayed in Table 1 of Sheng et al (2006) - A New Stall-Onset Criterion for Low Speed Dynamic-Stall
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    % Experimental
    file1 = '../Other Data/CN_alpha_Sheng_A0_10_A1_10_k0025_M0012_EXP.mat';
    load(file1)
    alpha_exp_cn = CN_alpha_Sheng_A0_10_A1_10_k0025_M0012_EXP(:,1);
    cn_exp = CN_alpha_Sheng_A0_10_A1_10_k0025_M0012_EXP(:,2);
    alpha_exp_cl = nan; cl_exp = nan; alpha_exp_cm = nan; cm_exp = nan; alpha_exp_cd = nan; cd_exp = nan; alpha_exp_cc = nan; cc_exp = nan;
    % Model
    file2 = '../Other Data/CN_alpha_Sheng_A0_10_A1_10_k0025_M0012_MOD.mat';
    load(file2)
    alpha_mod_cn = CN_alpha_Sheng_A0_10_A1_10_k0025_M0012_MOD(:,1);
    cn_mod = CN_alpha_Sheng_A0_10_A1_10_k0025_M0012_MOD(:,2);
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    M = 0.12; 
    alpha_0 = 9.7*pi/180; 
    delta_alpha = 9.9*pi/180; 
    k = 0.025; 
    authors{1} = 'Sheng et al. (2007) - EXP';
    authors{2} = 'Sheng et al. (2007) - MOD';
elseif other == 5 % By McCroskey and Pucci (1982) - Viscous-Inviscid interaction on Oscillating Airfoils - fig. 9
    b = 0.61/2;     % Assumed
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    file1 = '../Other Data/NACA12_M030_alpha9p5_k020_CL.mat';
    file2 = '../Other Data/NACA12_M030_alpha9p5_k020_CM.mat';
    load(file1)
    load(file2)
    alpha_exp_cl = NACA12_M030_alpha9p5_k020_CL(:,1);
    cl_exp = NACA12_M030_alpha9p5_k020_CL(:,2); 
    alpha_exp_cm = NACA12_M030_alpha9p5_k020_CM(:,1);
    cm_exp = NACA12_M030_alpha9p5_k020_CM(:,2);
    alpha_exp_cd = nan; cd_exp = nan; alpha_exp_cn = nan; cn_exp = nan; alpha_exp_cc = nan; cc_exp = nan;
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    authors{1} = 'McCroskey and Pucci (1982)';
    % Test conditions
    M = 0.3; 
    alpha_0 = 9*pi/180; 
    delta_alpha = 5*pi/180; 
    k = 0.20;
elseif other == 6 % By McAlister et al - Dynamic Stall Experiments on the NACA 0012 Airfoil - (1978)
    b = 1.22/2;     
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    file1 = '../Other Data/CN_alpha_M_0090_k_0150_A0_15_A1_10.mat';
    file2 = '../Other Data/CM_alpha_M_0090_k_0150_A0_15_A1_10.mat';
    file3 = '../Other Data/CC_alpha_M_0090_k_0150_A0_15_A1_10.mat';
    load(file1)
    load(file2)
    load(file3)
    alpha_exp_cn = CN_alpha_M_0090_k_0150_A0_15_A1_10(:,1);
    cn_exp = CN_alpha_M_0090_k_0150_A0_15_A1_10(:,2);
    alpha_exp_cm = CM_alpha_M_0090_k_0150_A0_15_A1_10(:,1);
    cm_exp = CM_alpha_M_0090_k_0150_A0_15_A1_10(:,2);
    alpha_exp_cc = CC_alpha_M_0090_k_0150_A0_15_A1_10(:,1);
    cc_exp = -CC_alpha_M_0090_k_0150_A0_15_A1_10(:,2);
    alpha_exp_cl = nan; cl_exp = nan; alpha_exp_cd = nan; cd_exp = nan; 
    alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    authors{1} = 'McAlister et al. (1978)';
    % Test conditions
    M = 0.09; 
    alpha_0 = 15*pi/180; 
    delta_alpha = 10*pi/180; 
    k = 0.15;   
elseif other == 7 % PARKER - Force and Pressure Measurements on an Airfoil Oscillating Trhough Stall - (1976)
    b = 1.22/2;     % 4-foot chord
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'NACA0012';
    % Experimental data
    file1 = '../Other Data/CN_alpha_Re_2e6_k_0150_A0_16_A1_10_open.mat';
    file2 = '../Other Data/CN_alpha_Re_2e6_k_0150_A0_16_A1_10_closed.mat';
    file3 = '../Other Data/CM_alpha_Re_2e6_k_0150_A0_16_A1_10_open.mat';
    file4 = '../Other Data/CM_alpha_Re_2e6_k_0150_A0_16_A1_10_closed.mat';
    load(file1)
    load(file2)
    load(file3)
    load(file4)
    alpha_exp_cn = CN_alpha_Re_2e6_k_0150_A0_16_A1_10_closed(:,1);
    cn_exp = CN_alpha_Re_2e6_k_0150_A0_16_A1_10_closed(:,2);
    alpha_exp_cm = CM_alpha_Re_2e6_k_0150_A0_16_A1_10_closed(:,1);
    cm_exp = CM_alpha_Re_2e6_k_0150_A0_16_A1_10_closed(:,2);
    alpha_exp_cd = nan; cd_exp = nan; alpha_exp_cc = nan; cc_exp = nan; alpha_exp_cl = nan; cl_exp = nan; 
    alpha_mod_cn = CN_alpha_Re_2e6_k_0150_A0_16_A1_10_open(:,1);
    cn_mod = CN_alpha_Re_2e6_k_0150_A0_16_A1_10_open(:,2);
    alpha_mod_cm = CM_alpha_Re_2e6_k_0150_A0_16_A1_10_open(:,1);
    cm_mod = CM_alpha_Re_2e6_k_0150_A0_16_A1_10_open(:,2);
    alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cc = nan; cc_mod = nan;  alpha_mod_cl = nan; cl_mod = nan; 
    % Test conditions
    M = 0.075; 
    alpha_0 = 15.6*pi/180; 
    delta_alpha = 10.2*pi/180; 
    k = 0.15; 
    authors{1} = 'Parker (1976) - closed';
    authors{2} = 'Parker (1976) - 2% open';
elseif other == 8 % Sheng et al (2008) - A Modified Dynamic Stall Model for Low Mach Numbers - Fig. 10
    b = 0.55/2;     % As displayed in Table 1 of Sheng et al (2006) - A New Stall-Onset Criterion for Low Speed Dynamic-Stall
    a_inf = 340;    % Assumed MSL conditions
    airfoil = 'S809';
    % Experimental data
    file1 = '../Other Data/CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
    file2 = '../Other Data/CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
    file3 = '../Other Data/CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
    file4 = '../Other Data/CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
    load(file1)
    load(file2)
    load(file3)
    load(file4)
    alpha_exp_cn = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
    cn_exp = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
    alpha_exp_cm = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
    cm_exp = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
    alpha_exp_cd = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
    cd_exp = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
    alpha_exp_cc = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
    cc_exp = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
    alpha_exp_cl = nan; cl_exp = nan; 
    % Model
    file1 = '../Other Data/CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
    file2 = '../Other Data/CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
    file3 = '../Other Data/CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
    file4 = '../Other Data/CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
    load(file1)
    load(file2)
    load(file3)
    load(file4)
    alpha_mod_cn = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
    cn_mod = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
    alpha_mod_cm = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
    cm_mod = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
    alpha_mod_cd = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
    cd_mod = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
    alpha_mod_cc = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
    cc_mod = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
    alpha_mod_cl = nan; cl_mod = nan; 
    % Test conditions
    M = 0.12; 
    alpha_0 = 15.3*pi/180; 
    delta_alpha = 9.9*pi/180; 
    k = 0.074; 
    authors{1} = 'EXP - Sheng et al. (2008)';
    authors{2} = 'MOD - Sheng et al. (2008)';    
else
    error('test case not available')
end
    
end
