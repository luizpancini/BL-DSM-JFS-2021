function alpha_plotter(alpha,coef,alpha_interp,coef_interp,alpha_exp,coef_exp,alpha_mod,coef_mod,coef_name,coef_short_name,tabgp,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,xlim_vec,iti)

tab = uitab('Parent',tabgp,'Title',coef_short_name,'BackgroundColor',[1 1 1]);
ax = axes('Parent',tab,'FontSize',axes_size,'FontName','times new roman');
ax.XLim = xlim_vec;
hold(ax,'on'); 
if length(authors) == 1 
    if ~isnan(coef_interp(1)) && strcmp(authors{1},'McAlister et al. (1982)')
        plot(alpha(iti:end)*180/pi,coef(iti:end),'k-',alpha_interp*180/pi,coef_interp,'b-','LineWidth',lw,'Parent',ax);
        legend('Present model',[authors{1}]);
    elseif ~isnan(coef_interp(1)) && strcmp(authors{1},'GU')
        plot(alpha(iti:end)*180/pi,coef(iti:end),'k-',alpha_exp,coef_exp,'ko','LineWidth',lw,'Parent',ax);
        legend('Present model',authors{1});    
    elseif isnan(alpha_exp(1)) || isnan(authors{1}(1))
        plot(alpha(iti:end)*180/pi,coef(iti:end),'k-','LineWidth',lw,'Parent',ax);
        legend('Present model');
    else
        plot(alpha(iti:end)*180/pi,coef(iti:end),'k-',alpha_exp,coef_exp,'ko','LineWidth',lw,'MarkerSize',ms,'Parent',ax);
        legend('Present model',authors{1});
    end
else
    plot(alpha(iti:end)*180/pi,coef(iti:end),'k-',alpha_exp,coef_exp,'ko',alpha_mod,coef_mod,'k--','LineWidth',lw,'MarkerSize',ms,'Parent',ax);
    if isnan(alpha_exp(1))
        legend('Present model');
    else
        legend('Present model',authors{1},authors{2});
    end
end
xlabel('\alpha [deg]','FontWeight','normal','FontSize',axes_size);
ylabel(coef_name,'FontWeight','normal','FontSize',axes_size);
if strcmp(authors{1},'McAlister et al. (1982)') && length(authors) == 1
    title(['Frame ' num2str(frame) ': M = ' num2str(M) ', k = ' num2str(k) ', A0 = ' num2str(a_0*180/pi,'%.1f') '^{\circ}, A1 = ' num2str(a_1*180/pi,'%.1f') '^{\circ}'],'FontWeight','normal','FontSize',axes_size*0.6);
elseif strcmp(authors{1},'GU') && length(authors) == 1
    title(['GUD ' num2str(GUD) ': M = ' num2str(M,'%.3f') ', k = ' num2str(k,'%.2f') ', A0 = ' num2str(a_0*180/pi,'%.1f') '^{\circ}, A1 = ' num2str(a_1*180/pi,'%.1f') '^{\circ}'],'FontWeight','normal','FontSize',axes_size*0.6);
end
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on
