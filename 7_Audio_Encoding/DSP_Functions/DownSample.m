%%  Author:  Oliver Hough - 51769145 - AbdnUni
%   Desription: Downsamples signal to nearest factor of desired frequency
%   Input:      Desired fs , Input Signal Stuct
%   Function:   Downsample
%   Output:     Down Sampled Signal Data Strut
function output = DownSample(DesiredFreq,input)
    tic
    factor              = round(input.fs/DesiredFreq);
    output.sample  = [];
        for i=1:factor:length(input.sample)
            output.sample=[output.sample input.sample(i)];
        end
    output.fs=input.fs/factor;
    
    dis                      = sprintf('Downsampled Signal @ %i',output.fs);
    output.description       = dis;
    output.precision         = 'int16';% Variable Type
    output.samplediscription = input.samplediscription;
    output.functiontime = toc;
end