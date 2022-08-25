%% Constants definition
global Tau;
global Tau_H;
global m;
global g;
global X0;
global Ts;

global a;
global eps;


Tau = 0.015;
Tau_H = 1;
m = 1;
g = 3;
X0 = [0 ; 0 ; 0 ; 0];
Ts = 0.001;

R = 0.92;
L = 1;
a = 3.4;
eps = 0;

%% Time evolution of the neuronal activities

a  = sim('simulation');
x=a.get('x');
data = x.Data;
E_L= data(:,1);
H_L= data(:,2);
E_R= data(:,3);
H_R= data(:,4);
Time = x.time;

figure('Name','Premier plot')
plot(Time, E_L, "DisplayName", 'E_L')
hold on
plot(Time, E_R, "DisplayName", 'E_R')
xlabel('Simulation time')
legend show
title('Time evolution of the neuronal activities E_L and E_R')


%% Bifurcation diagram

npoints = 5;
liste_a = linspace(0, 3.5, npoints);
minmaxEL = zeros(npoints,2);
minmaxER = zeros(npoints,2);
for i = 1:npoints
    i
    a = liste_a(i);
    y = sim('simulation');
    x= y.get('x');
    data = x.Data;
    E_L= data(:,1);
    E_R= data(:,3);
    E_Lmax = max(E_L(floor(length(E_L)/3):length(E_L)));
    E_Lmin = min(E_L(floor(length(E_L)/3):length(E_L)));
    minmaxEL(i,:)= [E_Lmin E_Lmax];
    E_Rmax = max(E_R(floor(length(E_R)/3):length(E_R)));
    E_Rmin = min(E_R(floor(length(E_R)/3):length(E_R)));
    minmaxER(i,:)= [E_Rmin E_Rmax];
end
figure('Name', 'Bifurcation Diagram')
plot(liste_a, minmaxEL(:,1),'DisplayName', 'Minimum Values of E_L')
hold on
plot(liste_a, minmaxEL(:,2),'DisplayName', 'Maximum Values of E_L')
hold on
plot(liste_a, minmaxER(:,1),'DisplayName', 'Minimum Values of E_R')
hold on
plot(liste_a, minmaxER(:,2),'DisplayName', 'Maximum Values of E_R')
legend show
title('Bifurcation diagram of the system with the parameter a')
xlabel('Bifurcation parameter a')



%% Steady-state duration of perception

% a =3.4;
% npoints = 10;
% list_R = linspace(0.86, 0.99, npoints);
% Rpduration = zeros(npoints, 1);
% Lpduration = zeros(npoints,1);
% 
% for i = 1:npoints
%     i
%     R = list_R(i);
%     y = sim('simulation');
%     x= y.get('x');
%     data = x.Data;
%     E_L= data(:,1);
%     len = length(E_L)
%     E_L = E_L(floor(length(E_L)/3):length(E_L));
%     E_R= data(:,3);
%     E_R = E_R(floor(length(E_R)/3):length(E_R));
%     Time = x.time;
%     Time= Time(floor(len/3):len);
%     [pks, locsL] = findpeaks(E_L, Time);
%     [pks, locsR] = findpeaks(E_R, Time);
%     E_L = E_L(locs(length(locsL)-1):locs(length(locsL)))
%     E_L = E_L(E_L >0.1)
%     mean = length(E_L)*Ts;
%     Lpduration(i) = mean;
%     
%     E_R = E_R(locs(length(locsR)-1):locs(length(locsR)))
%     E_R = E_R(E_R >0.1)
%     mean = length(E_R)*Ts;
%     Rpduration(i) = mean;
%     
% end
% 
% figure('Name', 'Perception duration')
% plot(list_R, Lpduration)
% hold on 
% plot(list_R, Rpduration)
    

%% Steady state perception with Simulink

npoints = 10;
list_R = linspace(0.86, 0.99, npoints);
Rpduration = zeros(npoints, 1);
Lpduration = zeros(npoints,1);

for i = 1:npoints
    R = list_R(i)
    % Computation of the perception duration for the left eye
    z = sim('simulation');
    EL_ON= z.get('EL_ON');
    d_EL = max(EL_ON.signals.values);
    Lpduration(i) = d_EL;
    
    % Computation of the perception duration for the right eye
    z = sim('simulation');
    ER_ON= z.get('ER_ON');
    d_ER = max(ER_ON.signals.values);
    Rpduration(i) = d_ER;
end

figure('Name', 'Perception duration')
plot(list_R, Lpduration, 'DisplayName', 'Left eye perception duration')
hold on 
plot(list_R, Rpduration, 'DisplayName', 'Right eye perception duration')
xlabel('Right stimulus intensity R')
ylabel('Perception duration (s)')
legend show
title('Steady-state duration of perception of the left and right stimuli')

%We can see that the left stimuli decreases as the right stimulus intensity R increases.
%This validates the Levelt's second law.
    

%% Alternation period

%We consider that the alternation period is the sum of perceptual durations
%of each eye. 
% We use the perceptions durations computed before.

Alt_period = zeros(npoints, 1);
Alt_rate = zeros(npoints, 1);

for i = 1:npoints
    d = Rpduration(i) + Lpduration(i);
    Alt_Period(i) = d;
    Alt_rate(i) = 1/d;
end

figure('Name', 'Alternation rate')
plot(list_R, Alt_rate)
xlabel('Right stimulus intensity R')
ylabel('Alternation rate (Hz)')
title('Perceptual alternation rate as a function of the right stimulus intensity')

%We can see that the perceptual alternation rate increases with the right stimulus intensity.
%This confirms Levelt's third law.
