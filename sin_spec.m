function sin_spec(dec_n, f_sig_relative, psd_scale, dec_mode)
%% Settings %%
% Sampling setting
Nsamp=2^12;
fs=1e3;
% Sinus setting
f_sin=fs/2*f_sig_relative;
% decimation setting
%dec_n=2;

%% Process %%
% Generate time vector
Ts=1/fs; % Sampling periode
t=[0:(Nsamp-1)]*Ts;
% Generate zero-centered frequency vector
f_res = fs/Nsamp; % frequency resolution
f=[-Nsamp/2:Nsamp/2-1]*f_res;

% Generate sinus signal vector
y=sin(2*pi*f_sin*t);
[y, fs_eff]=pseudo_decimate(Nsamp, fs, dec_n, y, dec_mode);
    

% calculate power spectral density
Y_fft=fftshift(fft(y)); % zero-centered fft
Y_psd=(Y_fft.*conj(Y_fft))./(Nsamp*fs);

%Y_psd=abs(Y_fft).^2./Nsamp;

%% Graph %%
% use frequency scale normalized to the effective sampling frequency
f_norm=f./fs_eff;

figure(2)

subplot(2,1,1)
plot(t,y)
ylabel('Amplitude')
xlabel('time')
title("f_{sig} = " + f_sin + "Hz,         f_s(effective) = " + fs_eff + "Hz")
subplot(2,1,2)
switch psd_scale
    case 'linear'
        plot(f_norm,Y_psd)
        ylim([0,1000/fs]) % static plot scale
        ylabel('Power')
    case 'log'
        semilogy(f_norm, Y_psd)
        %plot(f_norm,log10(Y_psd))
        ylim([ 10^(-5-log10(fs)),10^(5-log10(fs)) ]) % static plot scale
        ylabel('Power (log)')
end
fs_ratio = (fs/2)/fs_eff;
for x_nyquist = [0:0.5:fs_ratio]
    xline(x_nyquist,'--r');
    xline(-x_nyquist,'--r');
end
xlabel('normalized to effective f_s')
P_tot=sum(Y_psd)*fs/Nsamp;
title("P_{tot}="+P_tot)
grid on
figure(1)
