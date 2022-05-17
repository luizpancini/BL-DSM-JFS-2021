% Modified BL model main program
clc
clear 
close all
addpath('./functions')

%% Inputs
% Input options:
frame = 10022;                                     % NASA experiment #
GUD = 11012812;                                    % GU experiment #
other = 8;                                         % Saved experimental case from other sources
test = {0.12; 0.01; 10*pi/180; 20*pi/180; 'S809'}; % Specify test conditions. Set as {M; k; a_0; a_1; airfoil; b; a_inf} (b and a_inf are optional)
% Select input option
INPUT = frame;
% Select model (BL or BLS, for Sheng et al.'s model)
model = "BL";
% For BLS model, choose linearized reattachment or not
lin_reat = 0;

%% Call solver
call_BL_solver;