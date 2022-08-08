clc
[x,Fs]=audioread('resona.m4a');
[d,fs]=audioread('imTitrzi2.m4a');
p=audioplayer(x,Fs);
a=audioplayer(d,fs);
x=x(:,2); d=d(:,1);
%%
k=xcorr(x,x);%Autocorrelation function
L=length(x);
plot(-(L-1):(L-1),k)
power_Input=max(k)%max value of Autocorrelation function(this is the power of the input signal)

Output_Corla=xcorr(y,y);%Autocorrelation function
power_Output=max(Output_Corla)

Eror_Coral=xcorr(e,e);
power_Eror=max(Eror_Coral)

SNR=10*log10(power_Output/power_Eror)



%%
M=2100;%Filter order
mu=0.01;%Step parameter
lms = dsp.LMSFilter('Length',M,'StepSize',mu);%The LMS algorithm function
[y,e,w] =step(lms,x,d);
plot([d,y,e])%plot Disired,Eror,Outpout in the same gaph.
title('System Identification of an FIR filter')
legend('Desired','Output','Error')
xlabel('Time index')
ylabel('Signal value')
%filename = 'OutputNoEco2.m4a';
%audiowrite(filename,y,Fs);
%%
subplot (3,1,1);
k=xcorr(x,x);
L=length(x);
plot(-(L-1):(L-1),k)
title 'Autocorrelation-Signal With Eco'
xlabel 'Time[sec]' 
ylabel 'Amplitude'
hold on

subplot (3,1,2);
hy=xcorr(y,y);
L=length(y);
plot(-(L-1):(L-1),hy)
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

xf=fft(x);
N=length(x);
freq_vector=[0: 1/N :1-1/N].*(fs/1000);
plot(freq_vector,abs(xf))
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
yf=fft(y);
Ny=length(y);
freq_vector3=[0:1/Ny:1-1/Ny].*fs/1000;
plot(freq_vector,abs(yf))
title 'FFT Output signal'
xlabel ('Frequency') ;
ylabel ('Amplitude');
hold on
%%
%Calling to the function - LmsAlgotihm from the firs upload file on github.
[y,e,h]=LmsAlgorithm(x,d);
B=y';
A=e';
sound(B,fs)
clear sound
%filename = 'OutputNoEco1.m4a';
%audiowrite(filename,A,Fs);



    
    