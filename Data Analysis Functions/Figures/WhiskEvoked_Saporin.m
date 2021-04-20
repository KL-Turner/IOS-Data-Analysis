function [AnalysisResults] = WhiskEvoked_Saporin(rootFolder,saveFigs,delim,AnalysisResults)
%________________________________________________________________________________________________________________________
% Written by Kevin L. Turner
% The Pennsylvania State University, Dept. of Biomedical Engineering
% https://github.com/KL-Turner
%
% Purpose: 
%________________________________________________________________________________________________________________________

%% set-up
animalIDs = {'T141','T155','T156','T157','T142','T144','T159','T172','T150','T165','T166','T177','T179','T186','T187','T188','T189'};
C57BL6J_IDs = {'T141','T155','T156','T157','T186','T187','T188','T189'};
SSP_SAP_IDs = {'T142','T144','T159','T172'};
Blank_SAP_IDs = {'T150','T165','T166','T177','T179'};
whiskDataTypes = {'ShortWhisks','IntermediateWhisks','LongWhisks'};
hemispheres = {'adjLH','adjRH'};
treatments = {'C57BL6J','SSP_SAP','Blank_SAP'};
data = [];
cortVariables = {'HbT','CBV','cortMUA','cortGam','cortS','cortS_Gam','cortT','cortF','timeVector'};
hipVariables = {'hipMUA','hipGam','hipS','hipS_Gam','hipT','hipF','timeVector'};
%% cd through each animal's directory and extract the appropriate analysis results
for aa = 1:length(animalIDs)
    % recognize treatment based on animal group
    if ismember(animalIDs{1,aa},C57BL6J_IDs) == true
        treatment = 'C57BL6J';
    elseif ismember(animalIDs{1,aa},SSP_SAP_IDs) == true
        treatment = 'SSP_SAP';
    elseif ismember(animalIDs{1,aa},Blank_SAP_IDs) == true
        treatment = 'Blank_SAP';
    end
    % short - intermediate - long whisks
    for bb = 1:length(whiskDataTypes)
        % left, right hemishpere hemo & neural data
        for cc = 1:length(hemispheres)
            % pre-allocate necessary variable fields
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).dummCheck = 1;
            for dd = 1:length(cortVariables)
                if isfield(data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}),cortVariables{1,dd}) == false
                    data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).(cortVariables{1,dd}) = [];
                end
            end
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).HbT = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).HbT,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).CBV_HbT.HbT);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).CBV = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).CBV,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).CBV.CBV);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortMUA = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortMUA,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).MUA.corticalData);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortGam = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortGam,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).Gam.corticalData);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortS = cat(3,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortS,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).LFP.corticalS);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortS_Gam = cat(3,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortS_Gam,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).LFP.corticalS(49:end,20:23));
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortT = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortT,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).LFP.T);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortF = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).cortF,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).LFP.F);
            data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).timeVector = cat(1,data.(treatment).(whiskDataTypes{1,bb}).(hemispheres{1,cc}).timeVector,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.(hemispheres{1,cc}).(whiskDataTypes{1,bb}).timeVector);
        end
        % hippocampal neural data - preallocate necessary variable fields
        data.(treatment).(whiskDataTypes{1,bb}).Hip.dummyCheck = 1;
        for ee = 1:length(hipVariables)
            if isfield(data.(treatment).(whiskDataTypes{1,bb}).Hip,hipVariables{1,ee}) == false
                data.(treatment).(whiskDataTypes{1,bb}).Hip.(hipVariables{1,ee}) = [];
            end
        end
        data.(treatment).(whiskDataTypes{1,bb}).Hip.hipMUA = cat(1,data.(treatment).(whiskDataTypes{1,bb}).Hip.hipMUA,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).MUA.hippocampalData);
        data.(treatment).(whiskDataTypes{1,bb}).Hip.hipGam = cat(1,data.(treatment).(whiskDataTypes{1,bb}).Hip.hipGam,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).Gam.hippocampalData);
        data.(treatment).(whiskDataTypes{1,bb}).Hip.hipS = cat(3,data.(treatment).(whiskDataTypes{1,bb}).Hip.hipS,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).LFP.hippocampalS);
        data.(treatment).(whiskDataTypes{1,bb}).Hip.hipS_Gam = cat(3,data.(treatment).(whiskDataTypes{1,bb}).Hip.hipS_Gam,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).LFP.hippocampalS(49:end,20:23));
        data.(treatment).(whiskDataTypes{1,bb}).Hip.hipT = cat(1,data.(treatment).(whiskDataTypes{1,bb}).Hip.hipT,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).LFP.T);
        data.(treatment).(whiskDataTypes{1,bb}).Hip.hipF = cat(1,data.(treatment).(whiskDataTypes{1,bb}).Hip.hipF,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).LFP.F);
        data.(treatment).(whiskDataTypes{1,bb}).Hip.timeVector = cat(1,data.(treatment).(whiskDataTypes{1,bb}).Hip.timeVector,AnalysisResults.(animalIDs{1,aa}).EvokedAvgs.Whisk.adjLH.(whiskDataTypes{1,bb}).timeVector);
    end
end
%% concatenate the data from the contra and ipsi data
for ff = 1:length(treatments)
    for gg = 1:length(whiskDataTypes)
        for hh = 1:length(hemispheres)
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanHbT = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).HbT,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).stdHbT = std(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).HbT,0,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanCBV = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).CBV,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).stdCBV = std(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).CBV,0,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanCortMUA = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortMUA,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).stdCortMUA = std(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortMUA,0,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanCortGam = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortGam,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).stdCortGam = std(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortGam,0,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanCortS = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortS,3).*100;
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).mean_CortS_Gam = mean(mean(mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortS_Gam.*100,1),2),3);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).std_CortS_Gam = std(mean(mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortS_Gam.*100,1),2),0,3);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanCortT = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortT,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanCortF = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).cortF,1);
            data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).meanTimeVector = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).(hemispheres{1,hh}).timeVector,1);
        end
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.meanHipMUA = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipMUA,1);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.stdHipMUA = std(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipMUA,0,1);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.meanHipGam = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipGam,1);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.stdHipGam = std(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipGam,0,1);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.meanHipS = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipS,3).*100;
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.mean_HipS_Gam = mean(mean(mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipS_Gam.*100,1),2),3);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.std_HipS_Gam = std(mean(mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipS_Gam.*100,1),2),0,3);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.meanHipT = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipT,1);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.meanHipF = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.hipF,1);
        data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.meanTimeVector = mean(data.(treatments{1,ff}).(whiskDataTypes{1,gg}).Hip.timeVector,1);
    end
end
%% average whisk-evoked figures
summaryFigure1 = figure;
%% LH short whisks
ax1 = subplot(3,2,1);
% C57BL6Js
p1 = plot(data.C57BL6J.ShortWhisks.adjLH.meanTimeVector,data.C57BL6J.ShortWhisks.adjLH.meanHbT,'color',colors('sapphire'),'LineWidth',2);
hold on
plot(data.C57BL6J.ShortWhisks.adjLH.meanTimeVector,data.C57BL6J.ShortWhisks.adjLH.meanHbT + data.C57BL6J.ShortWhisks.adjLH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
plot(data.C57BL6J.ShortWhisks.adjLH.meanTimeVector,data.C57BL6J.ShortWhisks.adjLH.meanHbT - data.C57BL6J.ShortWhisks.adjLH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
% Blank-SAP
p2 = plot(data.Blank_SAP.ShortWhisks.adjLH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjLH.meanHbT,'color',colors('north texas green'),'LineWidth',2);
plot(data.Blank_SAP.ShortWhisks.adjLH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjLH.meanHbT + data.Blank_SAP.ShortWhisks.adjLH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
plot(data.Blank_SAP.ShortWhisks.adjLH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjLH.meanHbT - data.Blank_SAP.ShortWhisks.adjLH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
% SSP-SAP
p3 = plot(data.SSP_SAP.ShortWhisks.adjLH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjLH.meanHbT,'color',colors('electric purple'),'LineWidth',2);
plot(data.SSP_SAP.ShortWhisks.adjLH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjLH.meanHbT + data.SSP_SAP.ShortWhisks.adjLH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
plot(data.SSP_SAP.ShortWhisks.adjLH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjLH.meanHbT - data.SSP_SAP.ShortWhisks.adjLH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
title('LH (UnRx) \DeltaHbT - Short Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% RH short whisks
ax2 = subplot(3,2,2);
% C57BL6Js
plot(data.C57BL6J.ShortWhisks.adjRH.meanTimeVector,data.C57BL6J.ShortWhisks.adjRH.meanHbT,'color',colors('sapphire'),'LineWidth',2);
hold on
plot(data.C57BL6J.ShortWhisks.adjRH.meanTimeVector,data.C57BL6J.ShortWhisks.adjRH.meanHbT + data.C57BL6J.ShortWhisks.adjRH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
plot(data.C57BL6J.ShortWhisks.adjRH.meanTimeVector,data.C57BL6J.ShortWhisks.adjRH.meanHbT - data.C57BL6J.ShortWhisks.adjRH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
% Blank-SAP
plot(data.Blank_SAP.ShortWhisks.adjRH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjRH.meanHbT,'color',colors('north texas green'),'LineWidth',2);
plot(data.Blank_SAP.ShortWhisks.adjRH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjRH.meanHbT + data.Blank_SAP.ShortWhisks.adjRH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
plot(data.Blank_SAP.ShortWhisks.adjRH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjRH.meanHbT - data.Blank_SAP.ShortWhisks.adjRH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
% SSP-SAP
plot(data.SSP_SAP.ShortWhisks.adjRH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjRH.meanHbT,'color',colors('electric purple'),'LineWidth',2);
plot(data.SSP_SAP.ShortWhisks.adjRH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjRH.meanHbT + data.SSP_SAP.ShortWhisks.adjRH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
plot(data.SSP_SAP.ShortWhisks.adjRH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjRH.meanHbT - data.SSP_SAP.ShortWhisks.adjRH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
title('RH (Rx) \DeltaHbT - Short Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% LH intermediate whisks
ax3 = subplot(3,2,3);
% C57BL6Js
plot(data.C57BL6J.IntermediateWhisks.adjLH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjLH.meanHbT,'color',colors('sapphire'),'LineWidth',2);
hold on
plot(data.C57BL6J.IntermediateWhisks.adjLH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjLH.meanHbT + data.C57BL6J.IntermediateWhisks.adjLH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
plot(data.C57BL6J.IntermediateWhisks.adjLH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjLH.meanHbT - data.C57BL6J.IntermediateWhisks.adjLH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
% Blank-SAP
plot(data.Blank_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjLH.meanHbT,'color',colors('north texas green'),'LineWidth',2);
plot(data.Blank_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjLH.meanHbT + data.Blank_SAP.IntermediateWhisks.adjLH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
plot(data.Blank_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjLH.meanHbT - data.Blank_SAP.IntermediateWhisks.adjLH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
% SSP-SAP
plot(data.SSP_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjLH.meanHbT,'color',colors('electric purple'),'LineWidth',2);
plot(data.SSP_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjLH.meanHbT + data.SSP_SAP.IntermediateWhisks.adjLH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
plot(data.SSP_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjLH.meanHbT - data.SSP_SAP.IntermediateWhisks.adjLH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
title('LH (UnRx) \DeltaHbT - Intermediate Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% RH intermediate whisks
ax4 = subplot(3,2,4);
% C57BL6Js
plot(data.C57BL6J.IntermediateWhisks.adjRH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjRH.meanHbT,'color',colors('sapphire'),'LineWidth',2);
hold on
plot(data.C57BL6J.IntermediateWhisks.adjRH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjRH.meanHbT + data.C57BL6J.IntermediateWhisks.adjRH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
plot(data.C57BL6J.IntermediateWhisks.adjRH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjRH.meanHbT - data.C57BL6J.IntermediateWhisks.adjRH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
% Blank-SAP
plot(data.Blank_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjRH.meanHbT,'color',colors('north texas green'),'LineWidth',2);
plot(data.Blank_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjRH.meanHbT + data.Blank_SAP.IntermediateWhisks.adjRH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
plot(data.Blank_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjRH.meanHbT - data.Blank_SAP.IntermediateWhisks.adjRH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
% SSP-SAP
plot(data.SSP_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjRH.meanHbT,'color',colors('electric purple'),'LineWidth',2);
plot(data.SSP_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjRH.meanHbT + data.SSP_SAP.IntermediateWhisks.adjRH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
plot(data.SSP_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjRH.meanHbT - data.SSP_SAP.IntermediateWhisks.adjRH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
title('RH (Rx) \DeltaHbT - Intermediate Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% LH long whisks
ax5 = subplot(3,2,5);
% C57BL6Js
plot(data.C57BL6J.LongWhisks.adjLH.meanTimeVector,data.C57BL6J.LongWhisks.adjLH.meanHbT,'color',colors('sapphire'),'LineWidth',2);
hold on
plot(data.C57BL6J.LongWhisks.adjLH.meanTimeVector,data.C57BL6J.LongWhisks.adjLH.meanHbT + data.C57BL6J.LongWhisks.adjLH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
plot(data.C57BL6J.LongWhisks.adjLH.meanTimeVector,data.C57BL6J.LongWhisks.adjLH.meanHbT - data.C57BL6J.LongWhisks.adjLH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
% Blank-SAP
plot(data.Blank_SAP.LongWhisks.adjLH.meanTimeVector,data.Blank_SAP.LongWhisks.adjLH.meanHbT,'color',colors('north texas green'),'LineWidth',2);
plot(data.Blank_SAP.LongWhisks.adjLH.meanTimeVector,data.Blank_SAP.LongWhisks.adjLH.meanHbT + data.Blank_SAP.LongWhisks.adjLH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
plot(data.Blank_SAP.LongWhisks.adjLH.meanTimeVector,data.Blank_SAP.LongWhisks.adjLH.meanHbT - data.Blank_SAP.LongWhisks.adjLH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
% SSP-SAP
plot(data.SSP_SAP.LongWhisks.adjLH.meanTimeVector,data.SSP_SAP.LongWhisks.adjLH.meanHbT,'color',colors('electric purple'),'LineWidth',2);
plot(data.SSP_SAP.LongWhisks.adjLH.meanTimeVector,data.SSP_SAP.LongWhisks.adjLH.meanHbT + data.SSP_SAP.LongWhisks.adjLH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
plot(data.SSP_SAP.LongWhisks.adjLH.meanTimeVector,data.SSP_SAP.LongWhisks.adjLH.meanHbT - data.SSP_SAP.LongWhisks.adjLH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
title('LH (UnRx) \DeltaHbT - Long Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% RH long whisks
ax6 = subplot(3,2,6);
% C57BL6Js
plot(data.C57BL6J.LongWhisks.adjRH.meanTimeVector,data.C57BL6J.LongWhisks.adjRH.meanHbT,'color',colors('sapphire'),'LineWidth',2);
hold on
plot(data.C57BL6J.LongWhisks.adjRH.meanTimeVector,data.C57BL6J.LongWhisks.adjRH.meanHbT + data.C57BL6J.LongWhisks.adjRH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
plot(data.C57BL6J.LongWhisks.adjRH.meanTimeVector,data.C57BL6J.LongWhisks.adjRH.meanHbT - data.C57BL6J.LongWhisks.adjRH.stdHbT,'color',colors('sapphire'),'LineWidth',0.5)
% Blank-SAP
plot(data.Blank_SAP.LongWhisks.adjRH.meanTimeVector,data.Blank_SAP.LongWhisks.adjRH.meanHbT,'color',colors('north texas green'),'LineWidth',2);
plot(data.Blank_SAP.LongWhisks.adjRH.meanTimeVector,data.Blank_SAP.LongWhisks.adjRH.meanHbT + data.Blank_SAP.LongWhisks.adjRH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
plot(data.Blank_SAP.LongWhisks.adjRH.meanTimeVector,data.Blank_SAP.LongWhisks.adjRH.meanHbT - data.Blank_SAP.LongWhisks.adjRH.stdHbT,'color',colors('north texas green'),'LineWidth',0.5)
% SSP-SAP
plot(data.SSP_SAP.LongWhisks.adjRH.meanTimeVector,data.SSP_SAP.LongWhisks.adjRH.meanHbT,'color',colors('electric purple'),'LineWidth',2);
plot(data.SSP_SAP.LongWhisks.adjRH.meanTimeVector,data.SSP_SAP.LongWhisks.adjRH.meanHbT + data.SSP_SAP.LongWhisks.adjRH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
plot(data.SSP_SAP.LongWhisks.adjRH.meanTimeVector,data.SSP_SAP.LongWhisks.adjRH.meanHbT - data.SSP_SAP.LongWhisks.adjRH.stdHbT,'color',colors('electric purple'),'LineWidth',0.5)
title('RH (Rx) \DeltaHbT - Long Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% figure characteristics
linkaxes([ax1,ax2],'xy')
linkaxes([ax3,ax4],'xy')
linkaxes([ax5,ax6],'xy')
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder delim 'Summary Figures and Structures' delim 'MATLAB Analysis Figures' delim];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure1,[dirpath 'Whisk_Evoked_HbT']);
    set(summaryFigure1,'PaperPositionMode','auto');
    print('-painters','-dpdf','-fillpage',[dirpath 'Whisk_Evoked_HbT'])
end
%% individual whisk-evoked figures
summaryFigure2 = figure;
%% LH short whisks
ax1 = subplot(3,2,1);
% C57BL6Js
for aa = 1:size(data.C57BL6J.ShortWhisks.adjLH.HbT,1)
    plot(data.C57BL6J.ShortWhisks.adjLH.meanTimeVector,data.C57BL6J.ShortWhisks.adjLH.HbT(aa,:),'color',colors('sapphire'),'LineWidth',0.5);
    hold on
end
% Blank-SAP
for aa = 1:size(data.Blank_SAP.ShortWhisks.adjLH.HbT,1)
    plot(data.Blank_SAP.ShortWhisks.adjLH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjLH.HbT(aa,:),'color',colors('north texas green'),'LineWidth',0.5);
    hold on
end
% SSP-SAP
for aa = 1:size(data.SSP_SAP.ShortWhisks.adjLH.HbT,1)
    plot(data.SSP_SAP.ShortWhisks.adjLH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjLH.HbT(aa,:),'color',colors('electric purple'),'LineWidth',0.5);
    hold on
end
title('LH (UnRx) \DeltaHbT - Short Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
set(gca,'box','off')
xlim([-2,10])
%% RH short whisks
ax2 = subplot(3,2,2);
% C57BL6Js
for aa = 1:size(data.C57BL6J.ShortWhisks.adjRH.HbT,1)
    plot(data.C57BL6J.ShortWhisks.adjRH.meanTimeVector,data.C57BL6J.ShortWhisks.adjRH.HbT(aa,:),'color',colors('sapphire'),'LineWidth',0.5);
    hold on
end
% Blank-SAP
for aa = 1:size(data.Blank_SAP.ShortWhisks.adjRH.HbT,1)
    plot(data.Blank_SAP.ShortWhisks.adjRH.meanTimeVector,data.Blank_SAP.ShortWhisks.adjRH.HbT(aa,:),'color',colors('north texas green'),'LineWidth',0.5);
    hold on
end
% SSP-SAP
for aa = 1:size(data.SSP_SAP.ShortWhisks.adjRH.HbT,1)
    plot(data.SSP_SAP.ShortWhisks.adjRH.meanTimeVector,data.SSP_SAP.ShortWhisks.adjRH.HbT(aa,:),'color',colors('electric purple'),'LineWidth',0.5);
    hold on
end
title('RH (Rx) \DeltaHbT - Short Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% LH intermediate whisks
ax3 = subplot(3,2,3);
% C57BL6Js
for aa = 1:size(data.C57BL6J.IntermediateWhisks.adjLH.HbT,1)
    plot(data.C57BL6J.IntermediateWhisks.adjLH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjLH.HbT(aa,:),'color',colors('sapphire'),'LineWidth',0.5);
    hold on
end
% Blank-SAP
for aa = 1:size(data.Blank_SAP.IntermediateWhisks.adjLH.HbT,1)
    plot(data.Blank_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjLH.HbT(aa,:),'color',colors('north texas green'),'LineWidth',0.5);
    hold on
end
% SSP-SAP
for aa = 1:size(data.SSP_SAP.IntermediateWhisks.adjLH.HbT,1)
    plot(data.SSP_SAP.IntermediateWhisks.adjLH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjLH.HbT(aa,:),'color',colors('electric purple'),'LineWidth',0.5);
    hold on
end
title('LH (UnRx) \DeltaHbT - Intermediate Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% RH intermediate whisks
ax4 = subplot(3,2,4);
% C57BL6Js
for aa = 1:size(data.C57BL6J.IntermediateWhisks.adjRH.HbT,1)
    plot(data.C57BL6J.IntermediateWhisks.adjRH.meanTimeVector,data.C57BL6J.IntermediateWhisks.adjRH.HbT(aa,:),'color',colors('sapphire'),'LineWidth',0.5);
    hold on
end
% Blank-SAP
for aa = 1:size(data.Blank_SAP.IntermediateWhisks.adjRH.HbT,1)
    plot(data.Blank_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.Blank_SAP.IntermediateWhisks.adjRH.HbT(aa,:),'color',colors('north texas green'),'LineWidth',0.5);
    hold on
end
% SSP-SAP
for aa = 1:size(data.SSP_SAP.IntermediateWhisks.adjRH.HbT,1)
    plot(data.SSP_SAP.IntermediateWhisks.adjRH.meanTimeVector,data.SSP_SAP.IntermediateWhisks.adjRH.HbT(aa,:),'color',colors('electric purple'),'LineWidth',0.5);
    hold on
end
title('RH (Rx) \DeltaHbT - Intermediate Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% LH long whisks
ax5 = subplot(3,2,5);
% C57BL6Js
for aa = 1:size(data.C57BL6J.LongWhisks.adjLH.HbT,1)
    plot(data.C57BL6J.LongWhisks.adjLH.meanTimeVector,data.C57BL6J.LongWhisks.adjLH.HbT(aa,:),'color',colors('sapphire'),'LineWidth',0.5);
    hold on
end
% Blank-SAP
for aa = 1:size(data.Blank_SAP.LongWhisks.adjLH.HbT,1)
    plot(data.Blank_SAP.LongWhisks.adjLH.meanTimeVector,data.Blank_SAP.LongWhisks.adjLH.HbT(aa,:),'color',colors('north texas green'),'LineWidth',0.5);
    hold on
end
% SSP-SAP
for aa = 1:size(data.SSP_SAP.LongWhisks.adjLH.HbT,1)
    plot(data.SSP_SAP.LongWhisks.adjLH.meanTimeVector,data.SSP_SAP.LongWhisks.adjLH.HbT(aa,:),'color',colors('electric purple'),'LineWidth',0.5);
    hold on
end
title('LH (UnRx) \DeltaHbT - Long Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% RH long whisks
ax6 = subplot(3,2,6);
% C57BL6Js
for aa = 1:size(data.C57BL6J.LongWhisks.adjRH.HbT,1)
    plot(data.C57BL6J.LongWhisks.adjRH.meanTimeVector,data.C57BL6J.LongWhisks.adjRH.HbT(aa,:),'color',colors('sapphire'),'LineWidth',0.5);
    hold on
end
% Blank-SAP
for aa = 1:size(data.Blank_SAP.LongWhisks.adjRH.HbT,1)
    plot(data.Blank_SAP.LongWhisks.adjRH.meanTimeVector,data.Blank_SAP.LongWhisks.adjRH.HbT(aa,:),'color',colors('north texas green'),'LineWidth',0.5);
    hold on
end
% SSP-SAP
for aa = 1:size(data.SSP_SAP.LongWhisks.adjRH.HbT,1)
    plot(data.SSP_SAP.LongWhisks.adjRH.meanTimeVector,data.SSP_SAP.LongWhisks.adjRH.HbT(aa,:),'color',colors('electric purple'),'LineWidth',0.5);
    hold on
end
title('RH (Rx) \DeltaHbT - Long Whisks')
ylabel('\DeltaHbT (\muM)')
xlabel('Peri-whisk time (s)')
legend([p1,p2,p3],'C57BL6J','Blank-SAP','SSP-SAP')
set(gca,'box','off')
xlim([-2,10])
%% figure characteristics
linkaxes([ax1,ax2],'xy')
linkaxes([ax3,ax4],'xy')
linkaxes([ax5,ax6],'xy')
%% save figure(s)
if strcmp(saveFigs,'y') == true
    dirpath = [rootFolder delim 'Summary Figures and Structures' delim 'MATLAB Analysis Figures' delim];
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
    savefig(summaryFigure2,[dirpath 'indWhisk_Evoked_HbT']);
    set(summaryFigure2,'PaperPositionMode','auto');
    print('-painters','-dpdf','-fillpage',[dirpath 'indWhisk_Evoked_HbT'])
end

end
