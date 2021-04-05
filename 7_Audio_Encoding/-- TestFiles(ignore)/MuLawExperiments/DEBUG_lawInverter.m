function [uncomp] = mulawInverter(muval)
    SIGN_BIT	= int16(0x0080);        % Sign bit for a A-law byte. */
    QUANT_MASK	= int16(0x000f);		% Quantization field mask.
    BIAS		= int16(0x0084);		% Bias for linear code.
    SEG_SHIFT	= int16(0x0004);        % Left shift for segment number. */
    SEG_MASK	= int16(0x0070);        % Segment field mask. */
    
    fprintf("Input: %i\n",muval)

    muval=bitcmp(int16(muval));
    fprintf("Compliment: %i\n",muval)
        
    uncomp=bitshift(bitand(muval,QUANT_MASK),3)+BIAS;
    fprintf("QUANT+BIAS: %i\n",uncomp)
    
    %bitshift(bitand(muval, SEG_MASK),SEG_SHIFT)
    uncomp=bitshift(uncomp,bitshift(bitand(muval, SEG_MASK),-SEG_SHIFT));
    fprintf("MASK+SHIFT: %i\n",uncomp)
    
    if  bitand(muval,SIGN_BIT) == 0
        uncomp=uncomp-BIAS;
    else
        uncomp=BIAS-uncomp;
    end
end