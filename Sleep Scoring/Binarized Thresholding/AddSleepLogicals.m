function [ProcData] = AddSleepLogicals(animal, hem, fileID, ProcData, electrodeInput)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% Ph.D. Candidate, Department of Bioengineering
% The Pennsylvania State University
%________________________________________________________________________________________________________________________
%
%   Purpose: This function uses the sleep parameter bins (Delta power, whisker acceleration, and heart rate) to classify
%            each 5 second bin as either sleeping (1) or not (0). The Delta power is classified as a one if the max point
%            in a bin is greater than 5 (500% whisking baseline). The signal osccialates, so we take the peak anywhere in
%            the five seconds. The whisker acceleration is classified as a one if the max whisker acceleration in a bin is
%            less than 5 degrees/sec^2. The heart rate is classified as a one if the max is less than 9 beats per second.
%            These three logicals are then multiplied together to give a total "sleep logical."
%________________________________________________________________________________________________________________________
%
%   Inputs: ProcData file from a 5 minute imaging session.
%
%   Outputs: Save logicals to the ProcData file.
%________________________________________________________________________________________________________________________

%% BLOCK PURPOSE:  Create logicals to compare sleep parameters
% Create logical for the left and right electrode
if strcmp(electrodeInput,'L')   % If the left electrode is selected...
    for bins = 1:length(ProcData.Sleep.Parameters.DeltaBand_Power.LH)    % Loop through the total number of bins
        if max(ProcData.Sleep.Parameters.DeltaBand_Power.LH{bins}) >= 5  % If the max Power in the 5 second interval
            electrodeLogical(bins, 1) = 1; %#ok<*SAGROW>            % is >= 5, put a 1
        else
            electrodeLogical(bins, 1) = 0;                          % else, put a 0
        end
    end
end

if electrodeInput == 'R'    % If the right electrode is selected...
    for bins = 1:length(ProcData.Sleep.Parameters.DeltaBand_Power.RH)   % Loop through the total number of bins
        if max(ProcData.Sleep.Parameters.DeltaBand_Power.RH{bins}) >= 5   % If the max Power in the 5 second interval
            electrodeLogical(bins, 1) = 1; %#ok<*SAGROW>            % is >= 5, put a 1
        else
            electrodeLogical(bins, 1) = 0;                          % else, put a 0
        end
    end
end

if electrodeInput == 'B'    % If both electrodes are selected...
    for bins = 1:length(ProcData.Sleep.Parameters.DeltaBand_Power.LH)    % Loop through the total number of bins
        if max(ProcData.Sleep.Parameters.DeltaBand_Power.LH{bins}) >= 5   % If the max Power in the 5 second interval
            LH_electrodeLogical(bins, 1) = 1; %#ok<*SAGROW>          % is >= 5, put a 1
        else
            LH_electrodeLogical(bins, 1) = 0;                        % else, put a 0
        end
    end
    
    for bins = 1:length(ProcData.Sleep.Parameters.DeltaBand_Power.RH)   % Loop through the total number of bins
        if max(ProcData.Sleep.Parameters.DeltaBand_Power.RH{bins}) >= 5   % If the max Power in the 5 second interval
            RH_electrodeLogical(bins, 1) = 1; %#ok<*SAGROW>          % is >= 5, put a 1
        else
            RH_electrodeLogical(bins, 1) = 0;                        % else, put a 0
        end
    end
    
    electrodeLogical = arrayfun(@(LH_electrodeLogical, RH_electrodeLogical) any(LH_electrodeLogical + RH_electrodeLogical), LH_electrodeLogical, RH_electrodeLogical);
end

ProcData.Sleep.Logicals.DeltaBand_Power = electrodeLogical;   % Place the data in the ProcData struct to later be saved

%% BLOCK PURPOSE: Create logical for the whisker angle acceleration
for bins = 1:length(ProcData.Sleep.Parameters.WhiskerAcceleration)  % Loop through the total number of bins
    if max(ProcData.Sleep.Parameters.WhiskerAcceleration{bins}) <= 5  % If the max whisker acceleration in the 5 second interval
        whiskerLogical(bins, 1) = 1; %#ok<*SAGROW>              % is <= 5 degrees/sec sq, put a 1
    else
        whiskerLogical(bins, 1) = 0;                            % else, put a 0
    end
end

if length(whiskerLogical) ~= 60
    whiskerLogical_length = length(whiskerLogical);
    logical_diff = 60 - whiskerLogical_length;
    for x = 1:logical_diff
        whiskerLogical(whiskerLogical_length + x, 1) = 0;
    end
end

ProcData.Sleep.Logicals.WhiskerAccelerationLogical = whiskerLogical;       % Place the data in the ProcData struct to later be saved

%% BLOCK PURPOSE: Create logical for the heart rate
for bins = 1:length(ProcData.Sleep.Parameters.HeartRate)         % Loop through the total number of bins
    if max(ProcData.Sleep.Parameters.HeartRate{bins}) <= 9       % If the max whisker acceleration in the 5 second interval
        heartRateLogical(bins, 1) = 1; %#ok<*SAGROW>             % is <= 5 degrees/sec sq, put a 1
    else
        heartRateLogical(bins, 1) = 0;                           % else, put a 0
    end
end

ProcData.Sleep.Logicals.HeartRateLogical = heartRateLogical;     % Place the data in the ProcData struct to later be saved

%% BLOCK PURPOSE: Create combined logical for potentially sleeping epochs
sleepLogical = electrodeLogical.*whiskerLogical.*heartRateLogical;
ProcData.Sleep.Logicals.SleepLogical = sleepLogical;

save([animal '_' hem '_' fileID '_', 'ProcData']);

end 
