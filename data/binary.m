clc;clear; 
max_values=zeros(100);
arr = dir('*.csv');

for  k=1:length(arr)


csv_content=importdata(arr(k).name); %import the data 
t=(csv_content.data(:,2)-csv_content.data(1,2))./1000000; %time in seconds
X=csv_content.data(:,7)-mode(csv_content.data(:,7));
L=1000*(t(end)-t(1)); %signal length in milliseconds
Fs=1000*length(t)/L; %sampling frequency in Hz
T=1/Fs; %period of sampling in seconds
N=length(t);
%for i=1:N
%    if X(i)>7
%        X(i)=1;
%    elseif X(i)<-7
%        X(i)=1;
%    else
%        X(i)=0;
%    end 
%end

%figure (2*k-1)

%plot(t, X)
%
Y=fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
figure (k)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

xIndex = find(P1 == max(P1), 1, 'first');
maxXValue = f(xIndex)
max_values(k)=maxXValue; 
end
