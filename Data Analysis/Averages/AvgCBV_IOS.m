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

animalIDs = {'T99','T101','T102','T103','T105','T108','T109','T110'};
driveLetters = {'E','E','E','F','F','F','D','D'};
behavFields = {'Rest','NREM','REM','Unstim','All'};
baselineTypes = {'manualSelection','setDuration','entireDuration'};
cbv_dataTypes = {'CBV','CBV_HbT'};
colorbrewer_setA_colorA = [0.520000 0.520000 0.510000];
colorbrewer_setA_colorB = [(31/256) (120/256) (180/256)];
colorbrewer_setA_colorC = [(255/256) (0/256) (115/256)];
colorbrewer_setA_colorD = [(51/256) (160/256) (44/256)];
colorbrewer_setA_colorE = [(255/256) (140/256) (0/256)];

%% cd through each animal's directory and extract the appropriate analysis results
for a = 1:length(animalIDs)
    animalID = animalIDs{1,a};
    driveLetter = driveLetters{1,a};
    dataPath = [driveLetter ':\' animalID '\Combined Imaging\'];
    cd(dataPath)
    load([animalID '_AnalysisResults.mat']);
    for b = 1:length(behavFields)
        behavField = behavFields{1,b};
        for c = 1:length(cbv_dataTypes)
            cbv_dataType = cbv_dataTypes{1,c};
            if strcmp(behavField,'Rest') == true
                for d = 1:length(baselineTypes)
                    baselineType = baselineTypes{1,d};
                    if strcmp(cbv_dataType,'CBV') == true
                        data.(behavField).(cbv_dataType).(baselineType).meanLH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).LH)*100;
                        data.(behavField).(cbv_dataType).(baselineType).meanRH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).RH)*100;
                        data.(behavField).(cbv_dataType).(baselineType).allLH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).LH.*100;
                        data.(behavField).(cbv_dataType).(baselineType).allRH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).RH.*100;
                    elseif strcmp(cbv_dataType,'CBV_HbT') == true
                        data.(behavField).(cbv_dataType).(baselineType).meanLH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).LH);
                        data.(behavField).(cbv_dataType).(baselineType).meanRH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).RH);
                        data.(behavField).(cbv_dataType).(baselineType).allLH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).LH;
                        data.(behavField).(cbv_dataType).(baselineType).allRH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).(baselineType).RH;
                    end
                end
            else
                if strcmp(cbv_dataType,'CBV') == true
                    data.(behavField).(cbv_dataType).meanLH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).LH)*100;
                    data.(behavField).(cbv_dataType).meanRH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).RH)*100;
                    data.(behavField).(cbv_dataType).allLH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).LH.*100;
                    data.(behavField).(cbv_dataType).allRH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).RH.*100;
                elseif strcmp(cbv_dataType,'CBV_HbT') == true
                    data.(behavField).(cbv_dataType).meanLH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).LH);
                    data.(behavField).(cbv_dataType).meanRH(a,1) = mean(AnalysisResults.MeanCBV.(behavField).(cbv_dataType).RH);
                    data.(behavField).(cbv_dataType).allLH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).LH;
                    data.(behavField).(cbv_dataType).allRH{a,1} = AnalysisResults.MeanCBV.(behavField).(cbv_dataType).RH;
                end
            end
        end
    end
end

% take the mean and standard deviation of each set of signals
for e = 1:length(behavFields)
    behavField = behavFields{1,e};
    for f = 1:length(cbv_dataTypes)
        cbv_dataType = cbv_dataTypes{1,f};
        if strcmp(behavField,'Rest')
            for g = 1:length(baselineTypes)
                baselineType = baselineTypes{1,g};
                data.(behavField).(cbv_dataType).(baselineType).Comb = cat(1,data.(behavField).(cbv_dataType).(baselineType).meanLH,data.(behavField).(cbv_dataType).(baselineType).meanRH);
                data.(behavField).(cbv_dataType).(baselineType).catAllLH = [];
                data.(behavField).(cbv_dataType).(baselineType).catAllRH = [];
                for h = 1:length(data.(behavField).(cbv_dataType).(baselineType).allLH)
                    data.(behavField).(cbv_dataType).(baselineType).catAllLH = cat(1,data.(behavField).(cbv_dataType).(baselineType).catAllLH,data.(behavField).(cbv_dataType).(baselineType).allLH{h,1}); 
                    data.(behavField).(cbv_dataType).(baselineType).catAllRH = cat(1,data.(behavField).(cbv_dataType).(baselineType).catAllRH,data.(behavField).(cbv_dataType).(baselineType).allRH{h,1});
                end
                data.(behavField).(cbv_dataType).(baselineType).allComb = cat(1,data.(behavField).(cbv_dataType).(baselineType).catAllLH,data.(behavField).(cbv_dataType).(baselineType).catAllRH);
            end
        else
            data.(behavField).(cbv_dataType).Comb = cat(1,data.(behavField).(cbv_dataType).meanLH,data.(behavField).(cbv_dataType).meanRH);
            data.(behavField).(cbv_dataType).catAllLH = [];
            data.(behavField).(cbv_dataType).catAllRH = [];
            for h = 1:length(data.(behavField).(cbv_dataType).allLH)
                data.(behavField).(cbv_dataType).catAllLH = cat(1,data.(behavField).(cbv_dataType).catAllLH,data.(behavField).(cbv_dataType).allLH{h,1});
                data.(behavField).(cbv_dataType).catAllRH = cat(1,data.(behavField).(cbv_dataType).catAllRH,data.(behavField).(cbv_dataType).allRH{h,1});
            end
            data.(behavField).(cbv_dataType).allComb = cat(1,data.(behavField).(cbv_dataType).catAllLH,data.(behavField).(cbv_dataType).catAllRH);
        end
    end
end

% take the mean and standard deviation of each set of signals
for e = 1:length(behavFields)
    behavField = behavFields{1,e};
    for f = 1:length(cbv_dataTypes)
        cbv_dataType = cbv_dataTypes{1,f};
        if strcmp(behavField,'Rest')
            for g = 1:length(baselineTypes)
                baselineType = baselineTypes{1,g};
                data.(behavField).(cbv_dataType).(baselineType).meanCBV = mean(data.(behavField).(cbv_dataType).(baselineType).Comb);
                data.(behavField).(cbv_dataType).(baselineType).stdCBV = std(data.(behavField).(cbv_dataType).(baselineType).Comb,0,1);
            end
        else
            data.(behavField).(cbv_dataType).meanCBV = mean(data.(behavField).(cbv_dataType).Comb);
            data.(behavField).(cbv_dataType).stdCBV = std(data.(behavField).(cbv_dataType).Comb,0,1);
        end
    end
end

%% summary figure(s)
for h = 1:length(baselineTypes)
    baselineType = baselineTypes{1,h};
    xInds = ones(1,length(animalIDs)*2);
    summaryFigure = figure;
    sgtitle({['Mean hemodynamics - ' baselineType],' '})
    %% CBV
    subplot(2,2,1);
    scatter(xInds*1,data.Rest.CBV.(baselineType).Comb,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on','jitterAmount',0.25);
    hold on
    e1 = errorbar(1,data.Rest.CBV.(baselineType).meanCBV,data.Rest.CBV.(baselineType).stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e1.Color = 'black';
    
    scatter(xInds*2,data.NREM.CBV.Comb,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on','jitterAmount',0.25);
    hold on
    e2 = errorbar(2,data.NREM.CBV.meanCBV,data.NREM.CBV.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e2.Color = 'black';
    
    scatter(xInds*3,data.REM.CBV.Comb,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on','jitterAmount',0.25);
    hold on
    e3 = errorbar(3,data.REM.CBV.meanCBV,data.REM.CBV.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e3.Color = 'black';
    
    scatter(xInds*4,data.Unstim.CBV.Comb,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on','jitterAmount',0.25);
    hold on
    e4 = errorbar(4,data.Unstim.CBV.meanCBV,data.Unstim.CBV.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e4.Color = 'black';
    
    scatter(xInds*5,data.All.CBV.Comb,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on','jitterAmount',0.25);
    hold on
    e5 = errorbar(5,data.All.CBV.meanCBV,data.All.CBV.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e5.Color = 'black';
    
    title('Reflectance')
    ylabel('\DeltaR/R (%)')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    legend([e1 e2 e3 e4 e5],'Rest','NREM','REM','Unstim','All')
    axis square
    xlim([0 length(behavFields)+1])
    
    %% CBV HbT
    subplot(2,2,2);
    scatter(xInds*1,data.Rest.CBV_HbT.(baselineType).Comb,'MarkerEdgeColor',colorbrewer_setA_colorA,'jitter','on','jitterAmount',0.25);
    hold on
    e6 = errorbar(1,data.Rest.CBV_HbT.(baselineType).meanCBV,data.Rest.CBV_HbT.(baselineType).stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorA);
    e6.Color = 'black';
    
    scatter(xInds*2,data.NREM.CBV_HbT.Comb,'MarkerEdgeColor',colorbrewer_setA_colorB,'jitter','on','jitterAmount',0.25);
    hold on
    e7 = errorbar(2,data.NREM.CBV_HbT.meanCBV,data.NREM.CBV_HbT.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorB);
    e7.Color = 'black';
    
    scatter(xInds*3,data.REM.CBV_HbT.Comb,'MarkerEdgeColor',colorbrewer_setA_colorC,'jitter','on','jitterAmount',0.25);
    hold on
    e8 = errorbar(3,data.REM.CBV_HbT.meanCBV,data.REM.CBV_HbT.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorC);
    e8.Color = 'black';
    
    scatter(xInds*4,data.Unstim.CBV_HbT.Comb,'MarkerEdgeColor',colorbrewer_setA_colorD,'jitter','on','jitterAmount',0.25);
    hold on
    e9 = errorbar(4,data.Unstim.CBV_HbT.meanCBV,data.Unstim.CBV_HbT.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorD);
    e9.Color = 'black';
    
    scatter(xInds*5,data.All.CBV_HbT.Comb,'MarkerEdgeColor',colorbrewer_setA_colorE,'jitter','on','jitterAmount',0.25);
    hold on
    e10 = errorbar(5,data.All.CBV_HbT.meanCBV,data.All.CBV_HbT.stdCBV,'o','MarkerEdgeColor','k','MarkerFaceColor',colorbrewer_setA_colorE);
    e10.Color = 'black';
    
    title('Total Hemoglobin')
    ylabel('\DeltaHbT (\muM)')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    axis square
    xlim([0 length(behavFields)+1])
    
    subplot(2,2,3);
    edges = -15:0.5:7;
    h1 = histogram(data.Rest.CBV.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p1 = plot(conv(h1.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h1.BinCounts/sum(h1.BinCounts)),2,5));
    h2 = histogram(data.NREM.CBV.allComb,edges,'Normalization','probability');
    p2 = plot(conv(h2.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h2.BinCounts/sum(h2.BinCounts)),2,17));
    h3 = histogram(data.REM.CBV.allComb,edges,'Normalization','probability');
    p3 = plot(conv(h3.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h3.BinCounts/sum(h3.BinCounts)),2,17));
    axis square
    ylim([0 0.2])
    
    subplot(2,2,4);
    edges = -30:2.5:110;
    h4 = histogram(data.Rest.CBV_HbT.(baselineType).allComb,edges,'Normalization','probability');
    hold on
    p4 = plot(conv(h4.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h4.BinCounts/sum(h4.BinCounts)),2,3));
    h5 = histogram(data.NREM.CBV_HbT.allComb,edges,'Normalization','probability');
    p5 = plot(conv(h5.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h5.BinCounts/sum(h5.BinCounts)),2,17));
    h6 = histogram(data.REM.CBV_HbT.allComb,edges,'Normalization','probability');
    p6 = plot(conv(h6.BinEdges,[0.5 0.5],'valid'),sgolayfilt((h6.BinCounts/sum(h6.BinCounts)),2,17));
    axis square
    ylim([0 0.5])

    % save figure(s)
    dirpath = 'C:\Users\klt8\Documents\Analysis Average Figures\CBV\';
    if ~exist(dirpath, 'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure, [dirpath baselineType '_AverageCBV']);
end