% John Lawler
% ECE 8540 Lab 4 - Kalman Filter
clc;
clear all;

%% Read in data
file = fopen('1D-data.txt', 'r');
format = '%f';
Data = fscanf(file, format);
fclose(file);

%% Initalize our state matricies
R = 10;
M = [1 0];
X_tt = [1; 0];
Q = [0 0; 0 0.0005];
I = [1 0; 0 1];
phi = [1 1; 0 1];
yvals = [X_tt(1)];
S_t1t1 = [1 0; 0 1];
time = 1:size(Data);



%% perform looping process 

for t = 1:size(Data)

    % 1: Predict next state
    X_tt1 = phi * X_tt;
    
    % 2: Predict next covariant
    S_tt1 = phi * S_t1t1 * transpose(phi) + Q;
    
    % 3: obtain next measurement Yt
    Yt = Data(t);
    
    % 4: find K gain
    Kt = S_tt1*transpose(M)*((M*S_tt1*transpose(M) + R)^-1);
    
    % 5: update state Xtt
    X_tt = X_tt1 + Kt*(Yt - M*X_tt1)
    
    % 6: update state cov Stt
    S_t1t1 = (I - Kt*M)*S_tt1
    
    
    %yvals = [yvals; X_tt(1)];
    yvals(end+1) = X_tt(1)
end
yvals(end) = [];

%% Plotting the data for Part 1
g = figure(1);
hold on
axis padded
axis([0 600 -3 3]);
set(gca, 'FontSize', 14)
d = plot(time, Data)
y = plot(time, yvals)
set(d, 'Color', '#45484f');
set(y, 'Color', '#1e4ae3');
xlabel('Time (s)')
ylabel('Yt (m/s)')
leg = legend('sensor data    ','filter output   ', 'Location', 'southeast');
leg_pos = get(leg,'position') ;
set(leg, 'FontName', 'Helvetica');
legend boxoff
%set(leg,'position',[leg_pos(1),leg_pos(2),...
 %                   leg_pos(3),leg_pos(4)]) ;
                


 

 
 
 
 
 