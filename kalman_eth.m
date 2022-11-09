clc;
clear all;

 % trying out ethereum 
 %file = 'eth-daily.xlsx';
 file = 'gemini_ETHUSD_day.csv';
B = xlsread(file);
B = readmatrix(file, 'Range', [3 4 500 4]);
i = size(B)
i(1)
for t = 1:i(1)
    c = i(1) - t
    if (c == 0) break;
    end
    A(t) = B(c);
end

A(end) = [];
A = transpose(A);

% TIME DATA
t1 = datetime(2020,5,30,8,0,0);
t2 = datetime(2021,10,7,8,0,0);
days = t1:1:t2

%% Initalize our state matricies
R = 1000;
M = [1 0];
X_tt = [1; 0];
Q = [0 0; 0 0.00001];
I = [1 0; 0 1];
phi = [1 1; 0 1];
yvals = [X_tt(1)];
S_t1t1 = [1 0; 0 1];
time = 1:size(A);



%% perform looping process 

for t = 1:size(A)

    % 1: Predict next state
    X_tt1 = phi * X_tt;
    
    % 2: Predict next covariant
    S_tt1 = phi * S_t1t1 * transpose(phi) + Q;
    
    % 3: obtain next measurement Yt
    Yt = A(t);
    
    % 4: find K gain
    Kt = S_tt1*transpose(M)*((M*S_tt1*transpose(M) + R)^-1);
    
    % 5: update state Xtt
    X_tt = X_tt1 + Kt*(Yt - M*X_tt1);
    
    % 6: update state cov Stt
    S_t1t1 = (I - Kt*M)*S_tt1;
    
    
    %yvals = [yvals; X_tt(1)];
    yvals(end+1) = X_tt(1);
end
yvals(end) = [];

%% Plotting the data for Part 1
g = figure(1);
hold on
axis padded
%axis([500 1000 0 200000]);
set(gca, 'FontSize', 14);
d = plot(days, A);
%datetick('x','mmm-yy', 'keeplimits');
y = plot(days, yvals)
set(d, 'Color', '#45484f');
set(y, 'Color', '#1e4ae3');
xlabel('Days (d)');
%ylabel('Volume Traded')
ylabel('Open Price ($)')
leg = legend('Volume','filter output', 'Location', 'southeast');
leg_pos = get(leg,'position') ;
set(leg, 'FontName', 'Helvetica');
legend boxoff
%set(leg,'position',[leg_pos(1),leg_pos(2),...
 %                   leg_pos(3),leg_pos(4)]) ;
                


 

 
 
 