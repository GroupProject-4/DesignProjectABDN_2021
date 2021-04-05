%%  Author:  Oliver Hough - 51769145 - AbdnUni
%   Disription: Bad Example of High Pass filter
%   Input:      Stop Band , Input Signal Stuct
%   Function:   Low pass filter: 
%               stopband=f_stop, rs=35db atenuation, order n=5
%   Output:     Filtered Signal Strut

function [output] = HighPass(f_stop,input)
    tic
    %% Low Pass Filter
    % FIlter Specs
    Rs=35;          % Stop Band Attenuation Db
    %f_stop=8000;    % Stop Band Freqency Hz
    n=5;           % Filter Order
    fnyq=input.fs/2;       
    Ws=f_stop/fnyq;
    % Cheby 2
    [z,p,k]= cheby2(n,Rs,Ws,'High');
    [bSW,aSW]=zp2tf(z,p,k);

    % Plot Results Uncomment to plot Freq Response of filter
    % figure('Name','High Pass Filter Frequency/Phase Response','NumberTitle','off')
    % freqz(bSW,aSW,f_stop,input.fs);                 % Plot Freq Response 
    
    
    output.sample=int16(filter(bSW,aSW, input.sample));  % Filter Signal
    dis=sprintf('High Pass Filter %ikHz',f_stop);
    output.description=dis;  
    output.fs=input.fs;
    output.precision = input.precision;
    output.samplediscription = input.samplediscription;
    output.functiontime = toc;  
end