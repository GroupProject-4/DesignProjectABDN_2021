% Functioon bassed on Sun Microsystems functions
   % December 30, 1994:
   % Functions linear2alaw, linear2ulaw have been updated to correctly
   % convert unquantized 16 bit values.
   % Tables for direct u- to A-law and A- to u-law conversions have been
   % corrected.
   % Borge Lindberg, Center for PersonKommunikation, Aalborg University.
   % bli@cpk.auc.dk


function [muvalue] = mulaw2(pcmvalue)
    debug=false;
    LookUpTable.seg_uend    = int16([0x003F, 0x007F, 0x00FF, 0x01FF, 0x03FF, 0x07FF, 0x0FFF, 0x1FFF]);
    LookUpTable.BIAS		= int16(0x0084);         % Bias for linear code. */
    LookUpTable.CLIP        = int16(8159);


    if debug==true
        fprintf("Input: %i\n",pcmvalue)
    end
    pcmvalue =bitshift(pcmvalue,-2,'int16');
    
    if debug==true
        fprintf("Sign Of Magnitude: %i\n",pcmvalue)
    end
    
    if pcmvalue < 0
       pcmvalue=-pcmvalue;
       mask=int16(0x007F);
    else
       mask=int16(0x00FF);
    end
    if debug==true
        fprintf("Mask: %i\n",mask)
    end
    if pcmvalue>LookUpTable.CLIP
       pcmvalue=LookUpTable.CLIP;
    end
    if debug==true
        fprintf("Clip: %i\n",pcmvalue)
    end
    pcmvalue=pcmvalue+bitshift(LookUpTable.BIAS,-2,'int16');
    
    if debug==true
        fprintf("Bias: %i\n",pcmvalue)
    end
    
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
    
    
    if debug==true
        fprintf("PCM Value+BIAS: %i\n",pcmvalue);
        fprintf("Segment: %i\n", seg);
    end 
    
    if seg >= 9
        muvalue=bitxor(int16(0x7F), mask);
        if debug==true
            fprintf("uValue: seg>8 %i\n", 0x7F);
        end
    else
        muvalue=bitor(bitshift(seg-1,4),bitand(bitshift(pcmvalue,-(seg)),int16(0xF)));
        if debug==true
            fprintf("uValue: %i\n", muvalue);
        end
        muvalue=bitxor(muvalue,mask);
        
    end

end