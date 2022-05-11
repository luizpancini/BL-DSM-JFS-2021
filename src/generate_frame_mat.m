clc
clear 
close all
% Name grabit's data for Cl x alpha, Cm x alpha, Cd x alpha, Cl x time, Cm x time, Cd x time as 'ACL.mat', 'ACM.mat', 'ACD.mat', 'TCL.mat', 'TCM.mat', 'TCD.mat', respectively

%% Frame summary
frame_number = 24217;
M = 0.184;
k = 0.099;
alpha_0 = 14.9*pi/180;
delta_alpha = 10*pi/180;
authors = {'McAlister et al. (1982)'};

%% Load data
load('ACL.mat'); load('ACM.mat'); load('ACD.mat'); load('TCL.mat'); load('TCM.mat'); load('TCD.mat');

alpha_exp_cl = ACL(:,1);
cl_exp = ACL(:,2);
alpha_exp_cm = ACM(:,1);
cm_exp = ACM(:,2);
alpha_exp_cd = ACD(:,1);
cd_exp = ACD(:,2);

time_exp_cl = TCL(:,1);
clt_exp = TCL(:,2);
time_exp_cm = TCM(:,1);
cmt_exp = TCM(:,2);
time_exp_cd = TCD(:,1);
cdt_exp = TCD(:,2);

%% Save data to frame .mat
filename = ['frame_' num2str(frame_number) '.mat'];
save(filename,'M','k','alpha_0','delta_alpha','authors','alpha_exp_cl','cl_exp','alpha_exp_cm','cm_exp','alpha_exp_cd','cd_exp','time_exp_cl','clt_exp','time_exp_cm','cmt_exp','time_exp_cd','cdt_exp');
