tabTitle = 'x001';
columnNamesExcel = {'ppg', 'xAdapt','yAdapt', 'zAdapt', 'xPhase', 'xAmp','yPhase', 'yAmp', 'zPhase', 'zAmp'};
excelFilename = 'biosystemsFinal.xlsx'; 

[sig,Fs,tm]=rdsamp(tabTitle);

%sets up display of figures
tiledlayout(2,2)
nexttile

%reads data into time, accel, and ppg variables
time = tm; 
ppg = sig(:,12); 
accel_x = sig(:,31); 
accel_y = sig(:,32); 
accel_z = sig(:,33); 

%plots section of ppg (for troubleshooting)
plot(tm([100:8000]), ppg([100:8000])); 

% %nlms filters of ppgs using x, y, and z acceleration
[W,e] = my_nlms(accel_x, ppg, 20, .0005, 1, 500);
[W,f] = my_nlms(accel_y, ppg, 20, .0005, 1, 500);
[W,g] = my_nlms(accel_z, ppg, 20, .0005, 1, 500);

%plots section of filtered PPGs for troubleshooting 
nexttile
plot(tm([100:8000]), e([100:8000]));
nexttile
plot(tm([100:8000]), f([100:8000]));
nexttile
plot(tm([100:8000]), g([100:8000]));

%hilbert transforms of x, y, and z nlms filters
xhilbert = hilbert(e); 
yhilbert = hilbert(f); 
zhilbert = hilbert(g);


%instantaneous amplitude and phase
anglex = angle(xhilbert); 
ampx = abs(xhilbert); 
angley = angle(yhilbert); 
ampy = abs(yhilbert);
anglez = angle(zhilbert); 
ampz = abs(zhilbert);

adaptiveTable = array2table([ppg, e,f,g, anglex, ampx, angley, ampy, anglez, ampz], 'VariableNames',columnNamesExcel);
writetable(adaptiveTable,excelFilename,'Sheet', tabTitle, 'WriteVariableNames', true);



