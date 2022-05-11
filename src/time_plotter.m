function time_plotter(t,coef,time_interp,coef_interp,time_exp,coef_exp,coef_name,coef_short_name,tabgp,authors,frame,GUD,M,k,a_0,a_1,axes_size,lw,ms,t_cycle,itt,ittf)

tab = uitab('Parent',tabgp,'Title',coef_short_name,'BackgroundColor',[1 1 1]);
ax = axes('Parent',tab,'FontSize',axes_size,'FontName','times new roman','XTick',[-90 0 90 180 270]);
ax.XLim = [-90 270];
hold(ax,'on'); 
if ~isnan(coef_interp(1)) && strcmp(authors{1},'McAlister et al. (1982)')
    plot((t(itt:ittf)-t(itt))/t_cycle*360-90,coef(itt:ittf),'k-',time_interp,coef_interp,'b-','LineWidth',lw,'Parent',ax);
    legend('Present model',[authors{1}]);
elseif ~isnan(coef_interp(1)) && strcmp(authors{1},'GU')
    plot((t(itt:ittf)-t(itt))/t_cycle*360-90,coef(itt:ittf),'k-',time_exp,coef_exp,'ko','LineWidth',lw,'MarkerSize',ms,'Parent',ax);
    legend('Present model',authors{1});
elseif ~isnan(time_exp(1)) && (strcmp(authors{1},'McAlister et al. (1982)') || strcmp(authors{1},'GU'))
    plot((t(itt:ittf)-t(itt))/t_cycle*360-90,coef(itt:ittf),'k-',time_exp,coef_exp,'ko','LineWidth',lw,'MarkerSize',ms,'Parent',ax);
    legend('Present model',authors{1});     
else
    plot((t(itt:ittf)-t(itt))/t_cycle*360-90,coef(itt:ittf),'k-','LineWidth',lw,'Parent',ax);
    legend('Present model');
end
xlabel('\omega t [deg]','FontWeight','normal','FontSize',axes_size);
ylabel(coef_name,'FontWeight','normal','FontSize',axes_size);
if strcmp(authors{1},'McAlister et al. (1982)') && length(authors) == 1
    title(['Frame ' num2str(frame) ': M = ' num2str(M) ', k = ' num2str(k) ', A0 = ' num2str(a_0*180/pi,'%.1f') '^{\circ}, A1 = ' num2str(a_1*180/pi,'%.1f') '^{\circ}'],'FontWeight','normal','FontSize',axes_size*0.6);
elseif strcmp(authors{1},'GU') && length(authors) == 1
    title(['GUD ' num2str(GUD) ': M = ' num2str(M,'%.3f') ', k = ' num2str(k,'%.2f') ', A0 = ' num2str(a_0*180/pi,'%.1f') '^{\circ}, A1 = ' num2str(a_1*180/pi,'%.1f') '^{\circ}'],'FontWeight','normal','FontSize',axes_size*0.6);
end
set(legend,'Location','best','FontSize',axes_size*0.6);
grid on
