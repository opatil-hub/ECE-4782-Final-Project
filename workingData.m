
%excel file and tab that contain the data 
tabTitle = 'x001';
excelFilename = 'biosystemsFinal.xlsx'; 

%reads excel file into a table called "data"
%column names are {'ppg', 'xAdapt','yAdapt', 'zAdapt', 'xPhase', 'xAmp','yPhase', 'yAmp', 'zPhase', 'zAmp'} 
data = readtable(excelFilename, 'Sheet', tabTitle);

numFilter = 3;

phi = cos(data.xPhase./3).*cos(data.yPhase./3).*cos(data.zPhase./3);
r = ((data.xAmp.*data.yAmp.*data.zAmp).^numFilter).*phi;


%coproduct and normalization of phase
% combinedPhase = cosxphasedivn + cosyphasedivn + coszphasedivn;  
% range = max(combinedPhase(:)) - min(combinedPhase(:));
% adjustedPhase = (combinedPhase - min(combinedPhase(:))) / range;
% normPhase = 2 * adjustedPhase - 1;
% 
% combinedAmp = data.xAmp + data.yAmp + data.zAmp; 
% adjustedAmp = combinedAmp.^(1/3);
% 
% cleanedSig = normPhase .* combinedAmp;

tiledlayout(2,1);
nexttile
plot(data.ppg([10000:20000])); 
nexttile
plot(r([10000:20000])); 


