%%  Author:  Oliver Hough - 51769145 - AbdnUni
%   Crdeit:     Bassed on g711.c by Sun Microsystems
%      http://web.mit.edu/audio/src/build/i386_linux2/sox-11gamma-cb/g711.c
%   Disription: uLaw Expander function
%   Input:      Input Signal Stuct
%   Function:   Converts from 8bit G.711 uLaw->16 Bit PCM:            
%   Output:     Uncompressed Signal Strut

function [output] = g711u_Decoder(input)
    tic
    SIGN_BIT	= int16(0x0080);        % Sign bit for a A-law byte. */
    QUANT_MASK	= int16(0x000f);		% Quantization field mask.
    BIAS		= int16(0x0084);		% Bias for linear code.
    SEG_SHIFT	= int16(0x0004);        % Left shift for segment number. */
    SEG_MASK	= int16(0x0070);        % Segment field mask. */
    
   for i=1:1:length(input.sample)
        muval=int16(input.sample(i));
        muval=bitcmp(int16(muval));         
        uncomp=bitshift(bitand(muval,QUANT_MASK),3)+BIAS;
        uncomp=bitshift(uncomp,bitshift(bitand(muval, SEG_MASK),-SEG_SHIFT));

        if  bitand(muval,SIGN_BIT) == 0
            uncomp=uncomp-BIAS;
        else
            uncomp=BIAS-uncomp;
        end
        output.sample(i)=uncomp;
    end
    output.fs=input.fs;
    output.description  = 'g711 uLaw Decoded';
    output.precision    = 'int16';% Variable Type
    output.functiontime = toc;
end