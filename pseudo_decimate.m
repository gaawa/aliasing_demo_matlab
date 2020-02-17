function [y, fs_eff]=pseudo_decimate(Nsamp, fs, dec_n, y, mode)
dec_factor=2^dec_n;
fs_eff = fs/dec_factor; % print effective sampling frequency
if dec_n~=0
    % Decimate signal
    switch mode
        case 'repeat'
            for y_i = [1:dec_factor:Nsamp]
               for i = [1:dec_factor-1]
                   y(y_i+i)=y(y_i);
               end
            end     
        case 'zero padding'
            for y_i = [1:dec_factor:Nsamp]
               for i = [1:dec_factor-1]
                   y(y_i+i)=0;
               end
            end
    end
end