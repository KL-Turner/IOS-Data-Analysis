%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%________________________________________________________________________________________________________________________
%
%   Purpose: Calculate the average correlation coefficient of the different behavioral states
%________________________________________________________________________________________________________________________
%
%   Inputs: none
%
%   Outputs: Generates summary figures saved to C: drive Documents folder
%
%   Last Revised: Oct 1st, 2019
%________________________________________________________________________________________________________________________
clear
clc

animalIDs = {'T99','T101','T102','T103','T105','T108','T109','T110','T111'};
driveLetters = {'E','E','E','F','F','F','D','D','D'};
behavFields = {'Whisk','Rest','NREM','REM','Unstim','AllData'};
baselineTypes = {'manualSelection','setDuration','entireDuration'};
CBV_dataTypes = {'CBV','CBV_HbT'};
hemDataTypes = {'LH','RH'};
neuralDataTypes = {'deltaBandPower','thetaBandPower','alphaBandPower','betaBandPower','gammaBandPower','muaPower'};
fileSets = {'fileSetA','fileSetB'};
colorbrewer_setA_colorA = [0.520000 0.520000 0.510000];
colorbrewer_setA_colorB = [(31/256) (120/256) (180/256)];
colorbrewer_setA_colorC = [(255/256) (0/256) (115/256)];
colorbrewer_setA_colorD = [(51/256) (160/256) (44/256)];
colorbrewer_setA_colorE = [(255/256) (140/256) (0/256)];
colorbrewer_setA_colorF = [0.750000 0.000000 1.000000];

%% cd through each animal's directory and extract the appropriate analysis results
for a = 1:length(animalIDs)
    animalID = animalIDs{1,a};
    driveLetter = driveLetters{1,a};
    dataPath = [driveLetter ':\' animalID '\Combined Imaging\'];
    cd(dataPath)
    load([animalID '_AnalysisResults.mat']);
    for b = 1:length(behavFields)
        behavField = behavFields{1,b};
        for c = 1:length(fileSets)
            fileSet = fileSets{1,c};
            for z = 1:length(CBV_dataTypes)
            CBV_dataType = CBV_dataTypes{1,z};
                for y = 1:length(hemDataTypes)
                    hemDataType = hemDataTypes{1,y};
                    for x = 1:length(neuralDataTypes)
                        neuralDataType = neuralDataTypes{1,x};
                        if strcmp(behavField,'Rest') == true || strcmp(behavField,'Whisk') == true
                            for d = 1:length(baselineTypes)
                                baselineType = baselineTypes{1,d};
                                data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R;
                                data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).meanR(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R);
                                data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R2{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R2;
                                data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).meanR2(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R2);
                            end
                        else
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).R{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R;
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).meanR(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R);
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).R2{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R2;
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).meanR2(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R2);
                        end
                    end
                end
            end
        end
    end
end

% take the mean and standard deviation of each set of signals
for b = 1:length(behavFields)
    behavField = behavFields{1,b};
    for c = 1:length(fileSets)
        fileSet = fileSets{1,c};
        for z = 1:length(CBV_dataTypes)
            CBV_dataType = CBV_dataTypes{1,z};
            for y = 1:length(hemDataTypes)
                hemDataType = hemDataTypes{1,y};
                for x = 1:length(neuralDataTypes)
                    neuralDataType = neuralDataTypes{1,x};
                    if strcmp(behavField,'Rest') == true || strcmp(behavField,'Whisk') == true
                        for d = 1:length(baselineTypes)
                            baselineType = baselineTypes{1,d};
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R;
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).meanR(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R);
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R2{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R2;
                            data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).meanR2(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).(baselineType).R2);
                        end
                    else
                        data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).R{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R;
                        data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).meanR(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R);
                        data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).R2{a,1} = AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R2;
                        data.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).meanR2(a,1) = mean(AnalysisResults.HRF_Predictions.(behavField).(fileSet).(CBV_dataType).(hemDataType).(neuralDataType).entireDuration.R2);
                    end
                end
            end
        end
    end
end

%% summary figure(s)
for h = 1:length(baselineTypes)
    baselineType = baselineTypes{1,h};
    xInds = ones(1,length(animalIDs));
    summaryFigure = figure;
    sgtitle({['L/R Pearson''s correlation coefficients for cortical data - ' baselineType],' '})
    %% CBV
    subplot(2,4,1);
    scatter(xInds*1,data.Whisk.CBV.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.CBV.(baselineType).meanR,data.Whisk.CBV.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.CBV.(baselineType).meanR,data.Whisk.CBV.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.CBV.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.CBV.(baselineType).meanR,data.Rest.CBV.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.CBV.(baselineType).meanR,data.Rest.CBV.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.CBV.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.CBV.meanR,data.NREM.CBV.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.CBV.meanR,data.NREM.CBV.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.CBV.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.CBV.meanR,data.REM.CBV.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.CBV.meanR,data.REM.CBV.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.CBV.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.CBV.meanR,data.Unstim.CBV.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.CBV.meanR,data.Unstim.CBV.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.CBV.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.CBV.meanR,data.AllData.CBV.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.CBV.meanR,data.AllData.CBV.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('CBV Reflectance')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    legend([e1,e3,e5,e7,e9,e11],'Whisk','Rest','NREM','REM','Unstim','AllData')
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% CBV HbT
    subplot(2,4,2);
    scatter(xInds*1,data.Whisk.CBV_HbT.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.CBV_HbT.(baselineType).meanR,data.Whisk.CBV_HbT.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.CBV_HbT.(baselineType).meanR,data.Whisk.CBV_HbT.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.CBV_HbT.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.CBV_HbT.(baselineType).meanR,data.Rest.CBV_HbT.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.CBV_HbT.(baselineType).meanR,data.Rest.CBV_HbT.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.CBV_HbT.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.CBV_HbT.meanR,data.NREM.CBV_HbT.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.CBV_HbT.meanR,data.NREM.CBV_HbT.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.CBV_HbT.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.CBV_HbT.meanR,data.REM.CBV_HbT.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.CBV_HbT.meanR,data.REM.CBV_HbT.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.CBV_HbT.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.CBV_HbT.meanR,data.Unstim.CBV_HbT.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.CBV_HbT.meanR,data.Unstim.CBV_HbT.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.CBV_HbT.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.CBV_HbT.meanR,data.AllData.CBV_HbT.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.CBV_HbT.meanR,data.AllData.CBV_HbT.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('CBV HbT')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% Delta-band power
    subplot(2,4,3);
    scatter(xInds*1,data.Whisk.deltaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.deltaBandPower.(baselineType).meanR,data.Whisk.deltaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.deltaBandPower.(baselineType).meanR,data.Whisk.deltaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.deltaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.deltaBandPower.(baselineType).meanR,data.Rest.deltaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.deltaBandPower.(baselineType).meanR,data.Rest.deltaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.deltaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.deltaBandPower.meanR,data.NREM.deltaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.deltaBandPower.meanR,data.NREM.deltaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.deltaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.deltaBandPower.meanR,data.REM.deltaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.deltaBandPower.meanR,data.REM.deltaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.deltaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.deltaBandPower.meanR,data.Unstim.deltaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.deltaBandPower.meanR,data.Unstim.deltaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.deltaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.deltaBandPower.meanR,data.AllData.deltaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.deltaBandPower.meanR,data.AllData.deltaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('Delta-band power')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% Theta-band power
    subplot(2,4,4);
    scatter(xInds*1,data.Whisk.thetaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.thetaBandPower.(baselineType).meanR,data.Whisk.thetaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.thetaBandPower.(baselineType).meanR,data.Whisk.thetaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.thetaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.thetaBandPower.(baselineType).meanR,data.Rest.thetaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.thetaBandPower.(baselineType).meanR,data.Rest.thetaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.thetaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.thetaBandPower.meanR,data.NREM.thetaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.thetaBandPower.meanR,data.NREM.thetaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.thetaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.thetaBandPower.meanR,data.REM.thetaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.thetaBandPower.meanR,data.REM.thetaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.thetaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.thetaBandPower.meanR,data.Unstim.thetaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.thetaBandPower.meanR,data.Unstim.thetaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.thetaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.thetaBandPower.meanR,data.AllData.thetaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.thetaBandPower.meanR,data.AllData.thetaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('Theta-band power')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% Alpha-band power
    subplot(2,4,5);
    scatter(xInds*1,data.Whisk.alphaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.alphaBandPower.(baselineType).meanR,data.Whisk.alphaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.alphaBandPower.(baselineType).meanR,data.Whisk.alphaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.alphaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.alphaBandPower.(baselineType).meanR,data.Rest.alphaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.alphaBandPower.(baselineType).meanR,data.Rest.alphaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.alphaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.alphaBandPower.meanR,data.NREM.alphaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.alphaBandPower.meanR,data.NREM.alphaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.alphaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.alphaBandPower.meanR,data.REM.alphaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.alphaBandPower.meanR,data.REM.alphaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.alphaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.alphaBandPower.meanR,data.Unstim.alphaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.alphaBandPower.meanR,data.Unstim.alphaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.alphaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.alphaBandPower.meanR,data.AllData.alphaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.alphaBandPower.meanR,data.AllData.alphaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('Alpha-band power')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% Beta-band power
    subplot(2,4,6);
    scatter(xInds*1,data.Whisk.betaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.betaBandPower.(baselineType).meanR,data.Whisk.betaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.betaBandPower.(baselineType).meanR,data.Whisk.betaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.betaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.betaBandPower.(baselineType).meanR,data.Rest.betaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.betaBandPower.(baselineType).meanR,data.Rest.betaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.betaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.betaBandPower.meanR,data.NREM.betaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.betaBandPower.meanR,data.NREM.betaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.betaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.betaBandPower.meanR,data.REM.betaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.betaBandPower.meanR,data.REM.betaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.betaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.betaBandPower.meanR,data.Unstim.betaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.betaBandPower.meanR,data.Unstim.betaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.betaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.betaBandPower.meanR,data.AllData.betaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.betaBandPower.meanR,data.AllData.betaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('Beta-band power')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% Gamma-band power
    subplot(2,4,7);
    scatter(xInds*1,data.Whisk.gammaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.gammaBandPower.(baselineType).meanR,data.Whisk.gammaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.gammaBandPower.(baselineType).meanR,data.Whisk.gammaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.gammaBandPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.gammaBandPower.(baselineType).meanR,data.Rest.gammaBandPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.gammaBandPower.(baselineType).meanR,data.Rest.gammaBandPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.gammaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.gammaBandPower.meanR,data.NREM.gammaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.gammaBandPower.meanR,data.NREM.gammaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.gammaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.gammaBandPower.meanR,data.REM.gammaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.gammaBandPower.meanR,data.REM.gammaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.gammaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.gammaBandPower.meanR,data.Unstim.gammaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.gammaBandPower.meanR,data.Unstim.gammaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.gammaBandPower.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.gammaBandPower.meanR,data.AllData.gammaBandPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.gammaBandPower.meanR,data.AllData.gammaBandPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('Gamma-band power')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %% MUA power
    subplot(2,4,8);
    scatter(xInds*1,data.Whisk.muaPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorF,'jitter','on', 'jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Whisk.muaPower.(baselineType).meanR,data.Whisk.muaPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e1.Color = 'black';
    e2 = errorbar(1,data.Whisk.muaPower.(baselineType).meanR,data.Whisk.muaPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorF);
    e2.Color = colorbrewer_setA_colorF;
    
    scatter(xInds*2,data.Rest.muaPower.(baselineType).R,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on', 'jitterAmount',0.25);
    e3 = errorbar(2,data.Rest.muaPower.(baselineType).meanR,data.Rest.muaPower.(baselineType).stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e3.Color = 'black';
    e4 = errorbar(2,data.Rest.muaPower.(baselineType).meanR,data.Rest.muaPower.(baselineType).meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e4.Color = colorbrewer_setA_colorA;
    
    scatter(xInds*3,data.NREM.muaPower.R,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on', 'jitterAmount',0.25);
    e5 = errorbar(3,data.NREM.muaPower.meanR,data.NREM.muaPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e5.Color = 'black';
    e6 = errorbar(3,data.NREM.muaPower.meanR,data.NREM.muaPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e6.Color = colorbrewer_setA_colorB;
    
    scatter(xInds*4,data.REM.muaPower.R,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on', 'jitterAmount',0.25);
    e7 = errorbar(4,data.REM.muaPower.meanR,data.REM.muaPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e7.Color = 'black';
    e8 = errorbar(4,data.REM.muaPower.meanR,data.REM.muaPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = colorbrewer_setA_colorC;
    
    scatter(xInds*5,data.Unstim.muaPower.R,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on', 'jitterAmount',0.25);
    e9 = errorbar(5,data.Unstim.muaPower.meanR,data.Unstim.muaPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    e10 = errorbar(5,data.Unstim.muaPower.meanR,data.Unstim.muaPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e10.Color = colorbrewer_setA_colorD;
    
    scatter(xInds*6,data.AllData.muaPower.R,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on', 'jitterAmount',0.25);
    e11 = errorbar(6,data.AllData.muaPower.meanR,data.AllData.muaPower.stdMeanR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e11.Color = 'black';
    e12 = errorbar(6,data.AllData.muaPower.meanR,data.AllData.muaPower.meanStdR,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e12.Color = colorbrewer_setA_colorE;
    
    title('MUA power')
    ylabel('Correlation')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    ylim([0 1])
    xlim([0 length(behavFields)+1])
    
    %%
    summaryHistFigure = figure;
    sgtitle({['L/R Pearson''s correlation coefficients for cortical data - ' baselineType],' '})
    % CBV
    subplot(2,4,1);
    edges = -0.5:0.05:1.5;
    h1 = histogram(data.Whisk.CBV.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p1 = plot(conv(h1.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h1.BinCounts/sum(h1.BinCounts)),2,5));
    h2 = histogram(data.Rest.CBV.(baselineType).allComb,edges,'Normalization','probability');
    p2 = plot(conv(h2.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h2.BinCounts/sum(h2.BinCounts)),2,5));
    h3 = histogram(data.NREM.CBV.allComb,edges,'Normalization','probability');
    p3 = plot(conv(h3.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h3.BinCounts/sum(h3.BinCounts)),2,17));
    h4 = histogram(data.REM.CBV.allComb,edges,'Normalization','probability');
    p4 = plot(conv(h4.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h4.BinCounts/sum(h4.BinCounts)),2,17));
    legend([p1,p2,p3,p4],'Whisk','Rest','NREM','REM')
    axis square
    ylim([0 0.2])
    
    % CBV HbT
    subplot(2,4,2);
    h5 = histogram(data.Whisk.CBV_HbT.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p5 = plot(conv(h5.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h5.BinCounts/sum(h5.BinCounts)),2,3));
    h6 = histogram(data.Whisk.CBV_HbT.(baselineType).allComb,edges,'Normalization','probability');
    p6 = plot(conv(h6.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h6.BinCounts/sum(h6.BinCounts)),2,3));
    h7 = histogram(data.NREM.CBV_HbT.allComb,edges,'Normalization','probability');
    p7 = plot(conv(h7.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h7.BinCounts/sum(h7.BinCounts)),2,17));
    h8 = histogram(data.REM.CBV_HbT.allComb,edges,'Normalization','probability');
    p8 = plot(conv(h8.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h8.BinCounts/sum(h8.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % Delta-band power
    subplot(2,4,3);
    h9 = histogram(data.Whisk.deltaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p9 = plot(conv(h9.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h9.BinCounts/sum(h9.BinCounts)),2,3));
    h10 = histogram(data.Whisk.deltaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    p10 = plot(conv(h10.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h10.BinCounts/sum(h10.BinCounts)),2,3));
    h11 = histogram(data.NREM.deltaBandPower.allComb,edges,'Normalization','probability');
    p11 = plot(conv(h11.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h11.BinCounts/sum(h11.BinCounts)),2,17));
    h12 = histogram(data.REM.deltaBandPower.allComb,edges,'Normalization','probability');
    p12 = plot(conv(h12.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h12.BinCounts/sum(h12.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % Theta-band power
    subplot(2,4,4);
    h13 = histogram(data.Whisk.thetaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p13 = plot(conv(h13.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h13.BinCounts/sum(h13.BinCounts)),2,3));
    h14 = histogram(data.Whisk.thetaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    p14 = plot(conv(h14.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h14.BinCounts/sum(h14.BinCounts)),2,3));
    h15 = histogram(data.NREM.thetaBandPower.allComb,edges,'Normalization','probability');
    p15 = plot(conv(h15.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h15.BinCounts/sum(h15.BinCounts)),2,17));
    h16 = histogram(data.REM.thetaBandPower.allComb,edges,'Normalization','probability');
    p16 = plot(conv(h16.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h16.BinCounts/sum(h16.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % Alpha-band power
    subplot(2,4,5);
    h17 = histogram(data.Whisk.alphaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p17 = plot(conv(h17.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h17.BinCounts/sum(h17.BinCounts)),2,3));
    h18 = histogram(data.Whisk.alphaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    p18 = plot(conv(h18.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h18.BinCounts/sum(h18.BinCounts)),2,3));
    h19 = histogram(data.NREM.alphaBandPower.allComb,edges,'Normalization','probability');
    p19 = plot(conv(h19.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h19.BinCounts/sum(h19.BinCounts)),2,17));
    h20 = histogram(data.REM.alphaBandPower.allComb,edges,'Normalization','probability');
    p20 = plot(conv(h20.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h20.BinCounts/sum(h20.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % Beta-band power
    subplot(2,4,6);
    h21 = histogram(data.Whisk.betaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p21 = plot(conv(h21.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h21.BinCounts/sum(h21.BinCounts)),2,3));
    h22 = histogram(data.Whisk.betaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    p22 = plot(conv(h22.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h22.BinCounts/sum(h22.BinCounts)),2,3));
    h23 = histogram(data.NREM.betaBandPower.allComb,edges,'Normalization','probability');
    p23 = plot(conv(h23.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h23.BinCounts/sum(h23.BinCounts)),2,17));
    h24 = histogram(data.REM.betaBandPower.allComb,edges,'Normalization','probability');
    p24 = plot(conv(h24.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h24.BinCounts/sum(h24.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % Gamma-band power
    subplot(2,4,7);
    h25 = histogram(data.Whisk.gammaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p25 = plot(conv(h25.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h25.BinCounts/sum(h25.BinCounts)),2,3));
    h26 = histogram(data.Whisk.gammaBandPower.(baselineType).allComb,edges,'Normalization','probability');
    p26 = plot(conv(h26.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h26.BinCounts/sum(h26.BinCounts)),2,3));
    h27 = histogram(data.NREM.gammaBandPower.allComb,edges,'Normalization','probability');
    p27 = plot(conv(h27.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h27.BinCounts/sum(h27.BinCounts)),2,17));
    h28 = histogram(data.REM.gammaBandPower.allComb,edges,'Normalization','probability');
    p28 = plot(conv(h28.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h28.BinCounts/sum(h28.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % MUA power
    subplot(2,4,8);
    h29 = histogram(data.Whisk.muaPower.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p29 = plot(conv(h29.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h29.BinCounts/sum(h29.BinCounts)),2,3));
    h30 = histogram(data.Whisk.muaPower.(baselineType).allComb,edges,'Normalization','probability');
    p30 = plot(conv(h30.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h30.BinCounts/sum(h30.BinCounts)),2,3));
    h31 = histogram(data.NREM.muaPower.allComb,edges,'Normalization','probability');
    p31 = plot(conv(h31.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h31.BinCounts/sum(h31.BinCounts)),2,17));
    h32 = histogram(data.REM.muaPower.allComb,edges,'Normalization','probability');
    p32 = plot(conv(h32.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h32.BinCounts/sum(h32.BinCounts)),2,17));
    axis square
    ylim([0 0.5])
    
    % save figure(s)
    dirpath = 'C:\Users\klt8\Documents\Analysis Average Figures\Pearson''s Correlation Coefficients\';
    if ~exist(dirpath, 'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure, [dirpath baselineType '_AverageCorrCoeff']);
    savefig(summaryHistFigure, [dirpath baselineType '_AverageCorrCoeffHist']);
end
