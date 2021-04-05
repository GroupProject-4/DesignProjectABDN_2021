function [output] = g726_Compresor(input)
    tic
    if input.precision == 'uint8'
        fid=fopen('uG911output.raw','w');
        fwrite(fid,input.sample, input.precision);
        fclose(fid);
    else 
        print("ERROR: Invalid Input")
    end
    
    output.functiontime = toc;
end