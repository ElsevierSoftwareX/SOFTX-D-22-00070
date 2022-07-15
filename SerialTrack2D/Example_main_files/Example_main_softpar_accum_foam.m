%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SerialTrack execute main file
% ===================================================
% Dimension:            2D
% Particle rigidity:    soft 
% Tracking mode:        cumulative
% Syn or Exp:           exp
% Deformation mode:     foam uniaxial compression
%
% ===================================================
% Author: Jin Yang, Ph.D.
% Email: jyang526@wisc.edu -or- aldicdvc@gmail.com 
% Date: 02/2022; 07/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 


%% Initialization
close all; clear all; clc; clearvars -global
disp('************************************************');
disp('*** Welcome to SerialTrack Particle Tracking ***');
disp('************************************************');
addpath( './function/','./src/');  

 
%% User defined parameters %%%%%

%%%%% Problem dimension and units %%%%%
MPTPara.DIM = 2;    % problem dimension
MPTPara.xstep = 1;  % unit: px
MPTPara.tstep = 1;  % unit: 1/frame

%%%%% Code mode %%%%%
MPTPara.mode = 'accum'; % {'inc': incremental mode; 
                        %  'accum': cumulative mode; 
                        %  'dbf': double frame}

MPTPara.parType = 'soft'; % {'hard': hard particle; 
                          %  'soft': soft particle}

disp('************************************************');
disp(['Dimention: ',num2str(MPTPara.DIM)]);
disp(['Tracking mode: ',MPTPara.mode]);
disp(['Particle type: ',MPTPara.parType]);
disp('************************************************'); fprintf('\n');

%%%%% Image binary mask file %%%%%
MaskFileLoadingMode = 0; % {0: No mask file
                         %  1: Load only one mask file for all frames; 
                         %  2: Load one mask file for each single frame;
                         %  3: Load a MATLAB mat file for all frames;

if MaskFileLoadingMode == 3
    im_roi_mask_file_path = '.\img_par2track_lung\im_roi.mat'; % TODO: Path for the loaded MATLAB mat file as the mask file
else
    im_roi_mask_file_path = '';  
end

%%%%% Particle detection and localization parameters %%%%%
%%%%%%%%%% Elastomeric open-cell foam %%%%%%%%%%%%%
%%%%% Bead Parameters %%%%%
BeadPara.thres = 0.3;           % Threshold for detecting particles
BeadPara.beadSize = 0;          % Estimated radius of a single particle [px]
BeadPara.minSize = 3;           % Minimum area of a single particle [px^2]
BeadPara.maxSize = 200;         % Maximum area of a single particle [px^2]
BeadPara.winSize = [5, 5];      % Default [not used in 2D]
BeadPara.dccd = [1,1];          % Default [not used in 2D]
BeadPara.abc = [1,1];           % Default [not used in 2D]
BeadPara.forloop = 1;           % Default [not used in 2D]
BeadPara.randNoise = 1e-7;      % Default [not used in 2D]
BeadPara.PSF = [];              % PSF function; 
                                % Example: PSF = fspecial('disk', ... 
                                % BeadPara.beadSize-1 ); % Disk blur
BeadPara.color = 'black';       % Bead color: 'white' -or- 'black' 

%% SerialTrack particle tracking

%%%%% Multiple particle tracking (MPT) Parameters %%%%%
MPTPara.f_o_s = 30;              % Size of search field: max(|u|,|v|) [px]
MPTPara.n_neighborsMax = 25;     % Max # of neighboring particles
MPTPara.n_neighborsMin = 1;      % Min # of neighboring particles
MPTPara.locSolver = 1;           % Local solver: 1-topology-based feature; 
                                 %               2-histogram-based feature first and then topology-based feature;
MPTPara.gbSolver = 3;            % Global step solver: 1-moving least square fitting; 
                                 %                     2-global regularization; 
                                 %                     3-ADMM iterations
MPTPara.smoothness = 1e-1;       % Coefficient of regularization
MPTPara.outlrThres = 2;          % Threshold for removing outliers in TPT
MPTPara.maxIterNum = 20;         % Max ADMM iteration number
MPTPara.iterStopThres = 1e-3;    % ADMM iteration stopping threshold
MPTPara.strain_n_neighbors = 20; % # of neighboring particles used in strain gauge
MPTPara.strain_f_o_s = 60;       % Size of virtual strain gauge [px]
MPTPara.usePrevResults = 1;      % Whether use previous results or not: 0-no; 1-yes;  
MPTPara.distMissing = 10;        % Distance threshold to check whether 
                                 % particle has a match or not [px]


%%%% Postprocessing: merge trajectory segments %%%%%
distThres = 1; % distance threshold to connect split trajectory segments [px]
extrapMethod = 'pchip';  % extrapolation scheme to connect split trajectory segments
                         % suggestion: 'nearest' for Brownian motion                          
minTrajSegLength = 20;   % the minimum length of trajectory segment that will be extrapolate [px]
maxGapTrajSeqLength = 0; % the max frame# gap between connected trajectory segments


%%%%% Execute SerialTrack particle tracking %%%%%
if strcmp(MPTPara.mode,'inc')==1
    disp('Not implemented yet.');
    % run_Serial_MPT_2D_softpar_inc;
elseif strcmp(MPTPara.mode,'accum')==1
    run_Serial_MPT_2D_softpar_accum;    
elseif strcmp(MPTPara.mode,'dbf')==1
    disp('Not implemented yet.');
    % run_Serial_MPT_2D_hardpar_dbf;
end

 




