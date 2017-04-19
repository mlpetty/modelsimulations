%ATTENTION SWITCHING MODEL
%delta = 4 results in accuracy equal to switch probability

clear all;

nrun = 20;           	% number of separate runs to estimate precision
nt = 1000000;         	% number of trials, more than 10,000,000 is slow
d = 6;                  % "delta", target-distractor differentce (d' units)
w = 1;                % weight for cued loc; other loc is weighted 1-w
v = .8;               	% validity of cue (used to calculate mean pc)

probswitch = .8;

nvalid = nt*probswitch;
ninvalid = nt*(1-probswitch);

VR1 = zeros(nt, 1);
VR2 = zeros(nt, 1);
DV = zeros(nt, 1); %Decision variable when weight is one at cued location
DI = zeros(nt, 1); %Decision variable when weight is one at uncued location
Dtotal = zeros((nt*2),1);

vec = [1:nt];
swtch = 1:nt;
Shuffle(vec);
Shuffle(swtch);

% swtch = randi(80, 100);

for i = 1:nt


if vec(i) <= nvalid
VR1(i) = randn(1)+d/2;                 	% stim R at cued
VR2(i) = randn(1);                       % nothing at uncued
else
VR1(i) = randn(1);                 	% nothing at cued
VR2(i) = randn(1)+d/2;                       % stim R at uncued
end

if swtch(i) <= nvalid
 DV(i) = w*VR1(i)+(1-w)*VR2(i);% weighting cued 1
 DI(i) = randn(1);
else
  DI(i) = (1-w)*VR1(i)+ w*VR2(i);                      % weighting uncued 1
  DV(i) = randn(1);   
end
end
rV = zeros(size(DV));                     % create vector of zeros
rV(DV>0) = 1;                             % make 1 if correct
pcv = mean(rV);   

rI = zeros(size(DI));
rI(DI>0)= 1;
pci = mean(rI);

pcv
pci

Dtotal(1:(length(Dtotal)/2))= DV;
Dtotal((length(Dtotal)/2)+1:length(Dtotal))=DI;
rT(Dtotal>0) = 1;
pctotal = mean(rT)

%%

% 
% Hv = [0.55, 0.67, 0.7466, 0.7817, 0.7950, 0.7989]; %the obtained Hv for SNR 0-5
% Hi = [0.14, 0.16, 0.1866, 0.1955, 0.1987, 0.1997]; %the obtained Hi for SNR 0-5
% 
% x = [1 2 3 4 5 6]; %x-axis
% 
% plot(x, Hv, '-o', x, Hi, '-s'); %plot of all three lines
% 
% %'-o' means each point is marked with a circle
% %'-s' means each point is marked with a square
% % %'-d' means each point is marked with a diamond
% 
% print(1, '-r600', '-djpeg', 'allornonemodel') %saves the figure to my directory
% %600 resolution, jpeg file, titled 'linearmodel'
