%%  Author:  Oliver Hough - 51769145 - AbdnUni
%   Disription: Example Low Pass filter
%   Input:      Stop Band , Input Signal Stuct
%   Function:   Low pass filter: 
%               stopband=f_stop, rs=35db atenuation, order n=12
%   Output:     Filtered Signal Strut
function [output] = LowPass(f_stop,input)
    tic    
%% Low Pass Filter
    % FIlter Specs
    Rs=35;          % Stop Band Attenuation Db
    %f_stop=8000;    % Stop Band Freqency Hz
    n=17;           % Filter Order
    fnyq=input.fs/2;       
    Ws=f_stop/fnyq;
    % Cheby 2
    [z,p,k]= cheby2(n,Rs,Ws,'Low');
    [bSW,aSW]=zp2tf(z,p,k);

    % Plot Results Uncomment to plot Freq Response of filter
    % figure('Name','Low Pass Filter Frequency/Phase Response','NumberTitle','off')
    % freqz(bSW,aSW,f_stop,input.fs);                 % Plot Freq Response 
    
    
    output.sample=int16(filter(bSW,aSW, input.sample));  % Filter Signal
    dis=sprintf('Low Pass Filter %ikHz',f_stop);
    output.description=dis;  
    output.fs=input.fs;
    output.precision = input.precision;
    output.samplediscription = input.samplediscription;
    output.functiontime = toc;  
    %% Conver to Floar for SNR calculation
    temp=single(input.sample);
    temp=temp./max(temp);
    temp2=single(output.sample);
    temp2=temp2./max(temp2);
    output.noise=snr(temp, temp2);
end