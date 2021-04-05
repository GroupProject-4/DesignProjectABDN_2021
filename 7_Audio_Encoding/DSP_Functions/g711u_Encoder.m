%%  Author:  Oliver Hough - 51769145 - AbdnUni
%   Crdeit:     Bassed on g711.c by Sun Microsystems
%      http://web.mit.edu/audio/src/build/i386_linux2/sox-11gamma-cb/g711.c
%   Disription: uLaw Compressor function
%   Input:      Input Signal Stuct
%   Function:   Converts from 16bit PCM-> 8bit G.711 uLaw:            
%   Output:     Compressed Signal Strut

function [output] = g711u_Encoder(input)
    tic
    LookUpTable.seg_uend    = int16([0x003F, 0x007F, 0x00FF, 0x01FF, 0x03FF, 0x07FF, 0x0FFF, 0x1FFF]);
    LookUpTable.seg_uend    = int16([63, 127, 255, 511, 1023, 2047, 4095, 8191]);
    LookUpTable.BIAS		= int16(0x0084);         % Bias for linear code. */
    LookUpTable.CLIP        = int16(8159);
    
    for j=1:1:length(input.sample)

        pcmvalue =bitshift(input.sample(j),-2,'int16');

        if pcmvalue < 0
           pcmvalue=-pcmvalue;
           mask=int16(0x007F);
        else
           mask=int16(0x00FF);
        end

        if pcmvalue>LookUpTable.CLIP
           pcmvalue=LookUpTable.CLIP;
        end

        pcmvalue=pcmvalue+bitshift(LookUpTable.BIAS,-2,'int16');

        for i=1:1:8
           if pcmvalue <= LookUpTable.seg_uend(1,i)
               LookUpTable.seg_uend(1,i);
               seg = int16(i);
               break;
           else
               seg=int16(9);
           end
        end
            %seg=seg-1;
        if seg >= 9
            muvalue=bitxor(int16(0x7F), mask);
            else
            muvalue=bitor(bitshift(seg-1,4),bitand(bitshift(pcmvalue,-(seg)),int16(0xF)));
            muvalue=bitxor(muvalue,mask);
        end
    output.sample(j)=uint8(muvalue);
    end
    
    output.fs=input.fs;
    output.description  = 'Compressed Signal';
    output.precision    = 'uint8';% Variable Type
    output.functiontime = toc;
end

