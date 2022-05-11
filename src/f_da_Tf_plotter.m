function f_da_Tf_plotter(alpha_interp,cn_interp,cc_interp,cm_interp,x,y,tabgp,axes_size,lw,xlim_vec,iti,itt,ittf,p)

%% Output variables
[alpha,~,~,~,~,~,~,c_nI,~,c_mI,c_nv,c_mv,~,~,f,~,~,~,~,qR,~,...
~,c_nC,Tf_n,dalpha1,fprime,fprime_cm,fprime_cc,q,dalpha1_cm,...
dalpha1_cc,R_dot,Tf_m,Tf_c,theta,~,~,P,S,R,~,alpha_E] = BL_output_vars(x,y);

%% Separation points - Lift
c_nf_interp = cn_interp-c_nv(itt:ittf)-c_nI(itt:ittf);
K_f_interp = c_nf_interp./c_nC(itt:ittf);
K_f_interp((K_f_interp>1)) = 1;
K_f_interp((K_f_interp<0)) = 0;
f2prime_interp = (2*real(K_f_interp.^(1/2))-1).^2;
tab1 = uitab('Parent',tabgp,'Title','f_L','BackgroundColor',[1 1 1]);
ax1 = axes('Parent',tab1,'FontSize',axes_size,'FontName','times new roman');
ax1.XLim = xlim_vec;
ax1.YLim = [0 1];
hold(ax1,'on'); 
plot(alpha(iti:end)*180/pi,f(iti:end),'k-',alpha(iti:end)*180/pi,fprime(iti:end),'b-',alpha(iti:end)*180/pi,x(10,iti:end),'r-',alpha_interp*180/pi,f2prime_interp,'m-',alpha(iti:end)*180/pi,qR(iti:end),'c-',alpha(iti:end)*180/pi,x(13,iti:end),'g-',alpha(iti:end)*180/pi,abs(R_dot(iti:end)),'y-','LineWidth',lw,'Parent',ax1);
xlabel('\alpha [deg]','FontWeight','normal','FontSize',axes_size);
ylabel('Delayed separation points','FontWeight','normal','FontSize',axes_size);
legend('f','f^{\prime}_N','f^{\prime\prime}_N','Exp.','qR','R_D','R_{dot}');
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on

%% Separation points - Moment
c_mf_interp = cm_interp-c_mv(itt:ittf)-c_mI(itt:ittf);
fcm_interp = zeros(ittf-itt+1,1);
for i=1:ittf-itt+1
    if i == 1
        f_guess = 0.5;
    else
        f_guess = fcm_interp(i-1);
    end
    delta_f = 1;
    tol = 1e-4;
    iter = 0;
    NR_ok = 1;
    while norm(delta_f)>tol
        iter = iter+1;
        if theta(i)*q(i) > 0
            d = -R(i)*abs(theta(i))*(1-f_guess);
        else
            d = 0;
            p.K2 = p.K2*(1+2*R(i)^2*S(i)*(1-P(i)));
        end
        F = (p.K0+p.K1*(1-f_guess)+p.K2*sin(pi*f_guess^p.kappa)+p.K3*d)*c_nf_interp(i)-c_mf_interp(i);
        J = c_nf_interp(i)*(-p.K1+p.K2*2*pi*f_guess*cos(pi*f_guess^p.kappa)+p.K3*R(i)*abs(theta(i)));
        delta_f = -J\F;
        f_guess = f_guess + delta_f;
        if iter > 50
            NR_ok = 0;
            break
        end
    end
    if NR_ok == 1
        fcm_interp(i) = f_guess;
    else
        fcm_interp(i) = fsolve(@(x) find_fM(x,c_mf_interp(i),c_nf_interp(i),p.K0,p.K1,p.K2,p.K3,p.kappa,R(i),S(i),P(i),theta(i),q(i)),0.5,optimoptions('fsolve','Display','off')); % Solve transcendental equation for f_M
    end
end
tab2 = uitab('Parent',tabgp,'Title','f_M','BackgroundColor',[1 1 1]);
ax2 = axes('Parent',tab2,'FontSize',axes_size,'FontName','times new roman');
ax2.XLim = xlim_vec;
ax2.YLim = [0 1];
hold(ax2,'on'); 
plot(alpha(iti:end)*180/pi,f(iti:end),'k-',alpha(iti:end)*180/pi,fprime_cm(iti:end),'b-',alpha(iti:end)*180/pi,x(11,iti:end),'r-',alpha_interp*180/pi,fcm_interp,'m-',alpha(iti:end)*180/pi,qR(iti:end),'c-',alpha(iti:end)*180/pi,x(13,iti:end),'g-',alpha(iti:end)*180/pi,abs(R_dot(iti:end)),'y-','LineWidth',lw,'Parent',ax2);
xlabel('\alpha [deg]','FontWeight','normal','FontSize',axes_size);
ylabel('Delayed separation points','FontWeight','normal','FontSize',axes_size);
legend('f','f^{\prime}_M','f^{\prime\prime}_M','Exp.','qR','R_D','R_{dot}');
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on

%% Separation points - Chord
RD = x(13,:);
% fcc_interp = ((cc_interp+c_d0*cos(alpha_interp))./(c_n_alpha*sin((alpha_E(itt:ittf)-alpha_0L)).^2)+E0*RD(itt:ittf).*(theta(itt:ittf).^(1/2))).^(1./theta(itt:ittf));
fcc_interp = zeros(ittf-itt+1,1);
for i=1:ittf-itt+1
    if abs(theta(i)) < 1
        fcc_interp(i) = real(((cc_interp(i)+p.c_d0*cos(alpha_interp(i)))/(p.c_n_alpha*sin((alpha_E(i-1+itt)-0))^2)+p.E0*RD(i-1+itt)^2)^(1/abs(theta(i-1+itt))));
    else
        fcc_interp(i) = real(((cc_interp(i)+p.c_d0*cos(alpha_interp(i)))/(p.c_n_alpha*sin((alpha_E(i-1+itt)-0))^2)+p.E0*(RD(i-1+itt)^2+abs(theta(i-1+itt))^(1/2)-1))^(1/abs(theta(i-1+itt))));
    end
end
tab3 = uitab('Parent',tabgp,'Title','f_C','BackgroundColor',[1 1 1]);
ax3 = axes('Parent',tab3,'FontSize',axes_size,'FontName','times new roman');
ax3.XLim = xlim_vec;
ax3.YLim = [0 1];
hold(ax3,'on'); 
plot(alpha(iti:end)*180/pi,f(iti:end),'k-',alpha(iti:end)*180/pi,fprime_cc(iti:end),'b-',alpha(iti:end)*180/pi,x(12,iti:end),'r-',alpha_interp*180/pi,fcc_interp,'m-',alpha(iti:end)*180/pi,qR(iti:end),'c-',alpha(iti:end)*180/pi,x(13,iti:end),'g-',alpha(iti:end)*180/pi,abs(R_dot(iti:end)),'y-','LineWidth',lw,'Parent',ax3);
xlabel('\alpha [deg]','FontWeight','normal','FontSize',axes_size);
ylabel('Delayed separation points','FontWeight','normal','FontSize',axes_size);
legend('f','f^{\prime}_C','f^{\prime\prime}_C','Exp.','qR','R_D','R_{dot}');
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on

%% Angle offsets
tab4 = uitab('Parent',tabgp,'Title','d_a1','BackgroundColor',[1 1 1]);
ax4 = axes('Parent',tab4,'FontSize',axes_size,'FontName','times new roman');
ax4.XLim = xlim_vec;
hold(ax4,'on'); 
plot(alpha(iti:end)*180/pi,dalpha1(iti:end)*180/pi,'k-',alpha(iti:end)*180/pi,dalpha1_cm(iti:end)*180/pi,'b-',alpha(iti:end)*180/pi,dalpha1_cc(iti:end)*180/pi,'g-','LineWidth',lw,'Parent',ax4);
xlabel('\alpha [deg]','FontWeight','normal','FontSize',axes_size);
ylabel('\delta_{\alpha_1} [deg]','FontWeight','normal','FontSize',axes_size);
legend('Normal','Moment','Chordwise');
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on

%% Time constants
tab5 = uitab('Parent',tabgp,'Title','T_f','BackgroundColor',[1 1 1]);
ax5 = axes('Parent',tab5,'FontSize',axes_size,'FontName','times new roman');
ax5.XLim = xlim_vec;
hold(ax5,'on'); 
plot(alpha(iti:end)*180/pi,Tf_n(iti:end)/p.Tf0,'k-',alpha(iti:end)*180/pi,Tf_m(iti:end)/p.Tf0,'b-',alpha(iti:end)*180/pi,Tf_c(iti:end)/p.Tf0,'g-','LineWidth',lw,'Parent',ax5);
xlabel('\alpha [deg]','FontWeight','normal','FontSize',axes_size);
ylabel('T_f/T_{f_0}','FontWeight','normal','FontSize',axes_size);
legend('Normal','Moment','Chordwise');
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on

end