function [axes_size,lw,ms,xlim_vec,figure1,tabgp] = init_plotter(authors,INPUT,params)

% Unpack
a_0 = params.a_0;
a_1 = params.a_1;

% Default plot options
set(0,'DefaultTextInterpreter','tex')
set(0,'DefaultLegendInterpreter','tex')
axes_size = 20;
lw = 1;
ms = 5;

% Create figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1]); tabgp = uitabgroup(figure1);
if ~isempty(authors) 
    if strcmp(authors{1},'McAlister et al. (1982)')
        figure1.Name = ['Frame ' num2str(INPUT)];
        figure1.NumberTitle = 'off';
    elseif strcmp(authors{1},'GU')
        figure1.Name = ['GUD ' num2str(INPUT)];
        figure1.NumberTitle = 'off';
    end
end

% Set axes limits
if a_0+a_1 > a_0-a_1
    xlim_vec = [(a_0-a_1)*180/pi (a_0+a_1)*180/pi];
else
    xlim_vec = [(a_0+a_1)*180/pi (a_0-a_1)*180/pi];
end