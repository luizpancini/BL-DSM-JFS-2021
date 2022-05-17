function call_plotter(INPUT,model,frame,GUD,authors,data,params,t,alpha,c_l,c_m,c_d,c_n,c_c,alpha_interp,cn_interp,cm_interp,cc_interp,time_interp,t_cycle,x,y,iti,itt,ittf)

% Unpack parameters
M = params.M;
a_0 = params.a_0;
a_1 = params.a_1;
k = params.k;

% Set legend for current model
switch model
    case "BL"
        model_name = "Present model";
    case "BLS"
        model_name = "Sheng et al. model";
end

% Create figure and initialize plot options
[axes_size,lw,ms,xlim_vec,figure1,tabgp] = init_plotter(authors,INPUT,params);

% Coefficients x alpha
alpha_plotter(alpha,c_l,alpha_interp,nan,data{1,1},data{2,1},data{17,1},data{18,1},'Lift coefficient','c_l',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,xlim_vec,iti)
alpha_plotter(alpha,c_m,alpha_interp,nan,data{3,1},data{4,1},data{19,1},data{20,1},'Moment coefficient','c_m',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,xlim_vec,iti)
alpha_plotter(alpha,c_d,alpha_interp,nan,data{5,1},data{6,1},data{21,1},data{22,1},'Drag coefficient','c_d',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,xlim_vec,iti)
alpha_plotter(alpha,c_n,alpha_interp,cn_interp,data{13,1},data{14,1},data{23,1},data{24,1},'Normal coefficient','c_n',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,xlim_vec,iti)
alpha_plotter(alpha,c_c,alpha_interp,cc_interp,data{15,1},data{16,1},data{25,1},data{26,1},'Chordwise coefficient','c_c',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,xlim_vec,iti)

% Coefficients x time
time_plotter(t,c_l,time_interp,nan,data{7,1},data{8,1},'Lift coefficient','c_l x t',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,t_cycle,itt,ittf)
time_plotter(t,c_m,time_interp,nan,data{9,1},data{10,1},'Moment coefficient','c_m x t',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,t_cycle,itt,ittf)
time_plotter(t,c_d,time_interp,nan,data{11,1},data{12,1},'Drag coefficient','c_d x t',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,t_cycle,itt,ittf)
time_plotter(t,c_n,time_interp,cn_interp,data{27,1},data{28,1},'Normal coefficient','c_n x t',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,t_cycle,itt,ittf)
time_plotter(t,c_c,time_interp,cc_interp,data{29,1},data{30,1},'Chordwise coefficient','c_c x t',tabgp,model_name,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,t_cycle,itt,ittf)

% Separation points, angle offsets and time delay constants
if model == "BL" 
    if ~isnan(alpha_interp)
        f_da_Tf_plotter(alpha_interp,cn_interp,cc_interp,cm_interp,x,y,tabgp,axes_size,lw,xlim_vec,iti,itt,ittf,params);
    end
end

end