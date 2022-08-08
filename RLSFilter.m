clc
[x,Fs]=audioread('highpass_signal.wav');%האות המצוי בכניסה למסנן עם האקו
[d,fs]=audioread('yonatan.wav'); %האות הרצוי - ללא אקו או רעש
%%x=x(:,1);d=d(:,1);
[y,w,delta] = RLSFilterI232(x,d);
y=y';
plot([d,y])
title('System Identification of an FIR filter')
legend('Desired','Output')
xlabel('Time index')
ylabel('Signal value')

%%sound(x,fs)
%clear sound

%%filename = 'OutputNoEcoNoDiv.m4a';
%%audiowrite(filename,e,fs);
%%
%Plot the filter.
h_overall = [ 1 w'];
[H,j] = freqz(h_overall,1);
zplane(h_overall,1)
V=10*log10((abs(H)));%Frequancy response in db.

subplot (2,1,1);
plot(j,V)
title 'Normlize frequency response'
xlabel ('Frequency[Hz]')
ylabel ('Gain[db]')
grid on
hold on

subplot (2,1,2);
zplane(h_overall,1)
title 'Zplane'
grid on

fvtool(h_overall)





%%

subplot (3,1,1);
k=xcorr(x,x);
L=length(x);
plot(-(L-1):(L-1),k)
title 'Autocorrelation-Signal With Eco and Shift Phase'
xlabel 'Time[sec]' 
ylabel 'Amplitude'
hold on

subplot (3,1,2);
he=xcorr(e,e);
L=length(e);
plot(-(L-1):(L-1),he)
title 'Autocorrelation-Signal Output'
xlabel 'Time[sec]' 
ylabel 'Amplitude'
hold on

subplot (3,1,3);
hd=xcorr(d,d);
L=length(d);
plot(-(L-1):(L-1),hd)
title 'Autocorrelation-Signal Output Desired'
xlabel 'Time[sec]' 
ylabel 'Amplitude'
hold on

%%
subplot(3,1,1);

xf=abs(fft(x));
N=length(x);
freq_vector=[0: 1/N :1-1/N].*(fs/1000);
plot(freq_vector,xf)
title 'FFT Input sinal'
xlabel ('Frequency') ;
ylabel ('Amplitude');
hold on

subplot(3,1,2);
df=fft(d);
Nd=length(d);
freq_vector2=[0:1/Nd:1-1/Nd].*fs/1000;
plot(freq_vector,abs(df))
title 'FFT Disired signal'
xlabel ('Frequency') ;
ylabel ('Amplitude');
hold on

subplot(3,1,3);
yf=fft(e);
Ny=length(e);
freq_vector3=[0:1/Ny:1-1/Ny].*fs/100;
plot(freq_vector,abs(yf))
title 'FFT Output signal'
xlabel ('Frequency') ;
ylabel ('Amplitude');
hold on
%%
Input_Coral=xcorr(x,x);%Autocorrelation function
L=length(x);
%plot(-(L-1):(L-1),k)
power_Input=max(Input_Coral)%max value of Autocorrelation function(this is the power of the input signal)

Output_Corla=xcorr(y,y);%Autocorrelation function
power_Output=max(Output_Corla)


