function [ROIs] = CheckROIDates_IOS(animalID,ROIs,ROInames)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
%   Purpose: Create/Update ROIs.mat structure to verify all ROIs are drawn
%________________________________________________________________________________________________________________________

windowCamFilesDir = dir('*_WindowCam.bin');
windowCamDataFiles = {windowCamFilesDir.name}';
windowCamDataFileIDs = char(windowCamDataFiles);

% establish the number of unique days based on file IDs
[~,fileDates,~] = GetFileInfo_IOS(windowCamDataFileIDs);
[uniqueDays,~,DayID] = GetUniqueDays_IOS(fileDates);
firstsFileOfDay = cell(1,length(uniqueDays));
for a = 1:length(uniqueDays)
    FileInd = DayID == a;
    dayFilenames = windowCamDataFileIDs(FileInd,:);
    firstsFileOfDay(a) = {dayFilenames(1,:)};
end

% load existing ROI structure if it exists
ROIFileDir = dir('*_ROIs.mat');
ROIFileName = {ROIFileDir.name}';
ROIFileID = char(ROIFileName);
if exist(ROIFileID)
    load(ROIFileID);
else
    ROIs = [];
end

% Create the desired window ROI for each day if it doesn't yet exist
for b = 1:length(firstsFileOfDay)
    fileID = firstsFileOfDay{1,b};
    strDay = ConvertDate_IOS(fileID);
    for c = 1:length(ROInames)
        ROIname = [ROInames{1,c} '_' strDay];
        if ~isfield(ROIs,(ROIname))
            [frames] = ReadDalsaBinary_IOS(fileID,256,256);
            [ROIs] = CreateBilateralROIs_IOS(frames{1},ROIname,animalID,ROIs);
            save([animalID '_ROIs.mat'],'ROIs');
        end
    end
end

end
