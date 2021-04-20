function [AnalysisResults] = PearsonsCorr_Saporin(rootFolder,saveFigs,delim,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%
% Purpose:
%________________________________________________________________________________________________________________________

% colorBlack = [(0/256),(0/256),(0/256)];
% colorGrey = [(209/256),(211/256),(212/256)];
% colorRfcAwake = [(0/256),(64/256),(64/256)];
% colorRfcNREM = [(0/256),(174/256),(239/256)];
% colorRfcREM = [(190/256),(30/256),(45/256)];
colorRest = [(0/256),(166/256),(81/256)];
colorWhisk = [(31/256),(120/256),(179/256)];
% colorStim = [(255/256),(28/256),(206/256)];
colorNREM = [(191/256),(0/256),(255/256)];
colorREM = [(254/256),(139/256),(0/256)];
colorAlert = [(255/256),(191/256),(0/256)];
colorAsleep = [(0/256),(128/256),(255/256)];
colorAll = [(183/256),(115/256),(51/256)];
% colorIso = [(0/256),(256/256),(256/256)];
%% set-up and process data
animalIDs = {'T141','T155','T156','T157','T142','T144','T159','T172','T150','T165','T166','T177','T179','T186','T187','T188','T189'};
C57BL6J_IDs = {'T141','T155','T156','T157','T186','T187','T188','T189'};
SSP_SAP_IDs = {'T142','T144','T159','T172'};
Blank_SAP_IDs = {'T150','T165','T166','T177','T179'};
treatments = {'C57BL6J','SSP_SAP','Blank_SAP'};
behavFields = {'Rest','Whisk','NREM','REM','Awake','Sleep','All'};
dataTypes = {'CBV_HbT','gammaBandPower'};
%% Pearson's correlations during different behaviors
% cd through each animal's directory and extract the appropriate analysis results
data.C57BL6J.CorrCoef = []; data.SSP_SAP.CorrCoef = []; data.Blank_SAP.CorrCoef = [];
for aa = 1:length(animalIDs)
    animalID = animalIDs{1,aa};
    % recognize treatment based on animal group
    if ismember(animalID,C57BL6J_IDs) == true
        treatment = 'C57BL6J';
    elseif ismember(animalIDs{1,aa},SSP_SAP_IDs) == true
        treatment = 'SSP_SAP';
    elseif ismember(animalIDs{1,aa},Blank_SAP_IDs) == true
        treatment = 'Blank_SAP';
    end
    for bb = 1:length(behavFields)
        behavField = behavFields{1,bb};
        % create the behavior folder for the first iteration of the loop
        if isfield(data.(treatment).CorrCoef,behavField) == false
            data.(treatment).CorrCoef.(behavField) = [];
        end
        for cc = 1:length(dataTypes)
            dataType = dataTypes{1,cc};
            % don't concatenate empty arrays where there was no data for this behavior
            if isempty(AnalysisResults.(animalID).CorrCoeff.(behavField).(dataType).meanR) == false
                % create the data type folder for the first iteration of the loop
                if isfield(data.(treatment).CorrCoef.(behavField),dataType) == false
                    data.(treatment).CorrCoef.(behavField).(dataType).meanRs = [];
                    data.(treatment).CorrCoef.(behavField).(dataType).animalID = {};
                    data.(treatment).CorrCoef.(behavField).(dataType).behavior = {};
                end
                % concatenate mean R and the animalID/behavior 
                data.(treatment).CorrCoef.(behavField).(dataType).meanRs = cat(1,data.(treatment).CorrCoef.(behavField).(dataType).meanRs,AnalysisResults.(animalID).CorrCoeff.(behavField).(dataType).meanR);
                data.(treatment).CorrCoef.(behavField).(dataType).animalID = cat(1,data.(treatment).CorrCoef.(behavField).(dataType).animalID,animalID);
                data.(treatment).CorrCoef.(behavField).(dataType).behavior = cat(1,data.(treatment).CorrCoef.(behavField).(dataType).behavior,behavField);
            end
        end
    end
end
%% take mean/STD of R
for qq = 1:length(treatments)
    treatment = treatments{1,qq};
    for ee = 1:length(behavFields)
        behavField = behavFields{1,ee};
        for ff = 1:length(dataTypes)
            dataType = dataTypes{1,ff};
            data.(treatment).CorrCoef.(behavField).(dataType).meanR = mean(data.(treatment).CorrCoef.(behavField).(dataType).meanRs,1);
            data.(treatment).CorrCoef.(behavField).(dataType).stdR = std(data.(treatment).CorrCoef.(behavField).(dataType).meanRs,0,1);
        end
    end
end
%% average correlation coefficient figure
summaryFigure1 = figure;
CC_xInds1A = ones(1,length(data.C57BL6J.CorrCoef.Rest.CBV_HbT.meanRs));
CC_xInds1B = ones(1,length(data.SSP_SAP.CorrCoef.Rest.CBV_HbT.meanRs));
CC_xInds1C = ones(1,length(data.Blank_SAP.CorrCoef.Rest.CBV_HbT.meanRs));
CC_xInds2A = ones(1,length(data.C57BL6J.CorrCoef.Awake.CBV_HbT.animalID));
CC_xInds2B = ones(1,length(data.SSP_SAP.CorrCoef.Awake.CBV_HbT.animalID));
CC_xInds2C = ones(1,length(data.Blank_SAP.CorrCoef.Awake.CBV_HbT.animalID));
CC_xInds3A = ones(1,length(data.C57BL6J.CorrCoef.Sleep.CBV_HbT.animalID));
CC_xInds3B = ones(1,length(data.SSP_SAP.CorrCoef.Sleep.CBV_HbT.animalID));
CC_xInds3C = ones(1,length(data.Blank_SAP.CorrCoef.Sleep.CBV_HbT.animalID));
%% Pearson's correlations between bilateral HbT during different Rest
b1 = bar(1,data.C57BL6J.CorrCoef.Rest.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
hold on
scatter(CC_xInds1A*1,data.C57BL6J.CorrCoef.Rest.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorRest,'jitter','on', 'jitterAmount',0.25);
b2 = bar(2,data.SSP_SAP.CorrCoef.Rest.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*2,data.SSP_SAP.CorrCoef.Rest.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorRest,'jitter','on', 'jitterAmount',0.25);
b3 = bar(3,data.Blank_SAP.CorrCoef.Rest.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*3,data.Blank_SAP.CorrCoef.Rest.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorRest,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral HbT during different Whisk
bar(5,data.C57BL6J.CorrCoef.Whisk.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*5,data.C57BL6J.CorrCoef.Whisk.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorWhisk,'jitter','on', 'jitterAmount',0.25);
bar(6,data.SSP_SAP.CorrCoef.Whisk.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*6,data.SSP_SAP.CorrCoef.Whisk.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorWhisk,'jitter','on', 'jitterAmount',0.25);
bar(7,data.Blank_SAP.CorrCoef.Whisk.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*7,data.Blank_SAP.CorrCoef.Whisk.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorWhisk,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral HbT during different Rest
bar(9,data.C57BL6J.CorrCoef.NREM.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*9,data.C57BL6J.CorrCoef.NREM.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorNREM,'jitter','on', 'jitterAmount',0.25);
bar(10,data.SSP_SAP.CorrCoef.NREM.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*10,data.SSP_SAP.CorrCoef.NREM.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorNREM,'jitter','on', 'jitterAmount',0.25);
bar(11,data.Blank_SAP.CorrCoef.NREM.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*11,data.Blank_SAP.CorrCoef.NREM.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorNREM,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral HbT during different Rest
bar(13,data.C57BL6J.CorrCoef.REM.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*13,data.C57BL6J.CorrCoef.REM.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorREM,'jitter','on', 'jitterAmount',0.25);
bar(14,data.SSP_SAP.CorrCoef.REM.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*14,data.SSP_SAP.CorrCoef.REM.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorREM,'jitter','on', 'jitterAmount',0.25);
bar(15,data.Blank_SAP.CorrCoef.REM.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*15,data.Blank_SAP.CorrCoef.REM.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorREM,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral HbT during different Rest
bar(17,data.C57BL6J.CorrCoef.Awake.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds2A*17,data.C57BL6J.CorrCoef.Awake.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAlert,'jitter','on', 'jitterAmount',0.25);
bar(18,data.SSP_SAP.CorrCoef.Awake.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds2B*18,data.SSP_SAP.CorrCoef.Awake.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAlert,'jitter','on', 'jitterAmount',0.25);
bar(19,data.Blank_SAP.CorrCoef.Awake.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds2C*19,data.Blank_SAP.CorrCoef.Awake.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAlert,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral HbT during different Rest
bar(21,data.C57BL6J.CorrCoef.Sleep.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds3A*21,data.C57BL6J.CorrCoef.Sleep.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAsleep,'jitter','on', 'jitterAmount',0.25);
bar(22,data.SSP_SAP.CorrCoef.Sleep.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds3B*22,data.SSP_SAP.CorrCoef.Sleep.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAsleep,'jitter','on', 'jitterAmount',0.25);
bar(23,data.Blank_SAP.CorrCoef.Sleep.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds3C*23,data.Blank_SAP.CorrCoef.Sleep.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAsleep,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral HbT during different Rest
bar(25,data.C57BL6J.CorrCoef.All.CBV_HbT.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*25,data.C57BL6J.CorrCoef.All.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAll,'jitter','on', 'jitterAmount',0.25);
bar(26,data.SSP_SAP.CorrCoef.All.CBV_HbT.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*26,data.SSP_SAP.CorrCoef.All.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAll,'jitter','on', 'jitterAmount',0.25);
bar(27,data.Blank_SAP.CorrCoef.All.CBV_HbT.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*27,data.Blank_SAP.CorrCoef.All.CBV_HbT.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAll,'jitter','on', 'jitterAmount',0.25);
%% figure characteristics
title({'Cortical Pearson''s corr. coef','\DeltaHbT \muM (%)'})
ylabel('Corr. coefficient')
set(gca,'xtick',[2,6,10,14,18,22,26])
set(gca,'xticklabel',{'Rest','Whisk','NREM','REM','Alert','Asleep','All'})
xtickangle(45)
axis square
xlim([0,28])
% ylim([0,1])
set(gca,'box','off')
legend([b1,b2,b3],'C57BL6J','SSP-SAP','Blank-SAP','Location','NorthWest')
axis square
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder delim 'Summary Figures and Structures' delim 'MATLAB Analysis Figures' delim];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure1,[dirpath 'Pearsons_Correlation_HbT']);
    set(summaryFigure1,'PaperPositionMode','auto');
    print('-painters','-dpdf','-fillpage',[dirpath 'Pearsons_Correlation_HbT'])
end
%% average correlation coefficient figure gammma-band
summaryFigure2 = figure;
%% Pearson's correlations between bilateral gamma-band during different Rest
b1 = bar(1,data.C57BL6J.CorrCoef.Rest.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
hold on
scatter(CC_xInds1A*1,data.C57BL6J.CorrCoef.Rest.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorRest,'jitter','on', 'jitterAmount',0.25);
b2 = bar(2,data.SSP_SAP.CorrCoef.Rest.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*2,data.SSP_SAP.CorrCoef.Rest.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorRest,'jitter','on', 'jitterAmount',0.25);
b3 = bar(3,data.Blank_SAP.CorrCoef.Rest.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*3,data.Blank_SAP.CorrCoef.Rest.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorRest,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral gamma-band during different Whisk
bar(5,data.C57BL6J.CorrCoef.Whisk.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*5,data.C57BL6J.CorrCoef.Whisk.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorWhisk,'jitter','on', 'jitterAmount',0.25);
bar(6,data.SSP_SAP.CorrCoef.Whisk.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*6,data.SSP_SAP.CorrCoef.Whisk.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorWhisk,'jitter','on', 'jitterAmount',0.25);
bar(7,data.Blank_SAP.CorrCoef.Whisk.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*7,data.Blank_SAP.CorrCoef.Whisk.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorWhisk,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral gamma-band during different Rest
bar(9,data.C57BL6J.CorrCoef.NREM.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*9,data.C57BL6J.CorrCoef.NREM.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorNREM,'jitter','on', 'jitterAmount',0.25);
bar(10,data.SSP_SAP.CorrCoef.NREM.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*10,data.SSP_SAP.CorrCoef.NREM.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorNREM,'jitter','on', 'jitterAmount',0.25);
bar(11,data.Blank_SAP.CorrCoef.NREM.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*11,data.Blank_SAP.CorrCoef.NREM.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorNREM,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral gamma-band during different Rest
bar(13,data.C57BL6J.CorrCoef.REM.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*13,data.C57BL6J.CorrCoef.REM.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorREM,'jitter','on', 'jitterAmount',0.25);
bar(14,data.SSP_SAP.CorrCoef.REM.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*14,data.SSP_SAP.CorrCoef.REM.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorREM,'jitter','on', 'jitterAmount',0.25);
bar(15,data.Blank_SAP.CorrCoef.REM.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*15,data.Blank_SAP.CorrCoef.REM.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorREM,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral gamma-band during different Rest
bar(17,data.C57BL6J.CorrCoef.Awake.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds2A*17,data.C57BL6J.CorrCoef.Awake.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAlert,'jitter','on', 'jitterAmount',0.25);
bar(18,data.SSP_SAP.CorrCoef.Awake.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds2B*18,data.SSP_SAP.CorrCoef.Awake.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAlert,'jitter','on', 'jitterAmount',0.25);
bar(19,data.Blank_SAP.CorrCoef.Awake.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds2C*19,data.Blank_SAP.CorrCoef.Awake.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAlert,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral gamma-band during different Rest
bar(21,data.C57BL6J.CorrCoef.Sleep.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds3A*21,data.C57BL6J.CorrCoef.Sleep.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAsleep,'jitter','on', 'jitterAmount',0.25);
bar(22,data.SSP_SAP.CorrCoef.Sleep.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds3B*22,data.SSP_SAP.CorrCoef.Sleep.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAsleep,'jitter','on', 'jitterAmount',0.25);
bar(23,data.Blank_SAP.CorrCoef.Sleep.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds3C*23,data.Blank_SAP.CorrCoef.Sleep.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAsleep,'jitter','on', 'jitterAmount',0.25);
%% Pearson's correlations between bilateral gamma-band during different Rest
bar(25,data.C57BL6J.CorrCoef.All.gammaBandPower.meanR,'FaceColor',colors('sapphire'));
scatter(CC_xInds1A*25,data.C57BL6J.CorrCoef.All.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAll,'jitter','on', 'jitterAmount',0.25);
bar(26,data.SSP_SAP.CorrCoef.All.gammaBandPower.meanR,'FaceColor',colors('electric purple'));
scatter(CC_xInds1B*26,data.SSP_SAP.CorrCoef.All.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAll,'jitter','on', 'jitterAmount',0.25);
bar(27,data.Blank_SAP.CorrCoef.All.gammaBandPower.meanR,'FaceColor',colors('north texas green'));
scatter(CC_xInds1C*27,data.Blank_SAP.CorrCoef.All.gammaBandPower.meanRs,75,'MarkerEdgeColor','k','MarkerFaceColor',colorAll,'jitter','on', 'jitterAmount',0.25);
%% figure characteristics
title({'Cortical Pearson''s corr. coef','Gamma-band [30-100] Hz'})
ylabel('Corr. coefficient')
set(gca,'xtick',[2,6,10,14,18,22,26])
set(gca,'xticklabel',{'Rest','Whisk','NREM','REM','Alert','Asleep','All'})
xtickangle(45)
axis square
xlim([0,28])
% ylim([0,1])
set(gca,'box','off')
legend([b1,b2,b3],'C57BL6J','SSP-SAP','Blank-SAP','Location','NorthWest')
axis square
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder delim 'Summary Figures and Structures' delim 'MATLAB Analysis Figures' delim];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure2,[dirpath 'Pearsons_Correlation_gamma']);
    set(summaryFigure2,'PaperPositionMode','auto');
    print('-painters','-dpdf','-fillpage',[dirpath 'Pearsons_Correlation_gamma'])
end

end
