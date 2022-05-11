clc
clear
close all

%% Select files
GUD_init = 11011962;
GUD_final = 11014461;

for GUD = GUD_init:1:GUD_final
    filename = sprintf('%d.dat', GUD); 
    filename_coeffs = sprintf('%d_coeffs.dat', GUD);   
    if isfile(filename_coeffs) && isfile(filename)
        % Get test conditions data
        fid = fopen(filename);
        RIB = fscanf(fid,'%g',32); % read in first 32 elements of RIB
        fclose('all');
        M = RIB(21);
        k = RIB(22);
        % Nominal alpha_0 and delta_alpha are RIB(8) and RIB(9), but we
        % shall use the ones gotten from the coefficients data
        % Get coefficients data
        GUD_data = importdata(filename_coeffs);    
        time = GUD_data.data(:,1);      % cycle angle (0 -- 2*pi)
        time = time/(2*pi)*360-90;      % transform to deg (-90 -- 270)
        alpha = GUD_data.data(:,2);
        cn = GUD_data.data(:,3);
        cc = GUD_data.data(:,4);
        cm = GUD_data.data(:,5);
        alpha_0 = (max(alpha)+min(alpha))/2*pi/180;
        delta_alpha = (max(alpha)-min(alpha))/2*pi/180;
        % Save data
        filename_save = sprintf('GUD_%d.mat', GUD); 
        save(filename_save,'M','k','alpha_0','delta_alpha','time','alpha','cn','cc','cm');
%         pause(0.5)
    end
end