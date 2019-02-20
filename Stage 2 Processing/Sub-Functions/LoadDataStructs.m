function [animal, hem, ROIs, Thresholds, EventData, RestData, RestingBaselines,...
    SleepData, ComparisonData] = LoadDataStructs()
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% Ph.D. Candidate, Department of Bioengineering
% The Pennsylvania State University
%________________________________________________________________________________________________________________________
%
%   Purpose: This function serves to load the various data structs for analysis
%________________________________________________________________________________________________________________________
%
%   Inputs: none
%
%   Outputs: various .mat structures
%
%   Last Revised: August 8th, 2018
%________________________________________________________________________________________________________________________

rawDataFiles = dir('*_RawData.mat');
rawDataFileIDs = {rawDataFiles.name}';
rawDataFileID = rawDataFileIDs{1,1};
[animal, hem, ~, ~] = GetFileInfo(rawDataFileID);

ROIsFile = dir('*_ROIs.mat');
if ~isempty(ROIsFile)
    load(ROIsFile.name);
else
    ROIs = [];
end

ThresholdsFile = dir('*_Thresholds.mat');
if ~isempty(ThresholdsFile)
    load(ThresholdsFile.name);
else
    Thresholds = [];
end

RestDataFile = dir('*_RestData.mat');
if ~isempty(RestDataFile)
    load(RestDataFile.name);
else
    RestData = [];
end

EventDataFile = dir('*_EventData.mat');
if ~isempty(EventDataFile)
    load(EventDataFile.name);
else
    EventData = [];
end

RestingBaselinesFile = dir('*_RestingBaselines.mat');
if ~isempty(RestingBaselinesFile)
    load(RestingBaselinesFile.name);
else
    RestingBaselines = [];
end

SleepDataFile = dir('*_SleepData.mat');
if ~isempty(SleepDataFile)
    load(SleepDataFile.name);
else
    SleepData = [];
end

ComparisonDataFile = dir('*_ComparisonData.mat');
if ~isempty(ComparisonDataFile)
    load(ComparisonDataFile.name);
else
    ComparisonData = [];
end

end

