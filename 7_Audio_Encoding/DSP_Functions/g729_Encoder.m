function [output] = g729_Encoder(input)
    tic
    if input.precision == 'int16'
        fid=fopen('EncoderInput.raw','w');
        fwrite(fid,input.sample, input.precision);
        fclose(fid);
    else 
        print("ERROR: Invalid Input");
    end
    
    system('cp_g729_encoder.exe EncoderInput.raw EncoderOutput');
    system('cp_g729_decoder.exe EncoderOutput DecoderOutput.raw');
    temp=sampleloader('DecoderOutput.raw', input.fs, input.samplediscription);
    temp.description =  'g729_Decoded';
    
    system('del EncoderInput.raw EncoderOutput DecoderOutput.raw');
    output = temp;
    output.functiontime = toc;
end

