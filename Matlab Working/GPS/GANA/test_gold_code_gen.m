%% Program to test the GPS L1 C/A code generation and correlation properties

clear all
close all

sArray = zeros(1023,38);
for ii = 0:36
    svLabel = ['SV',num2str(ii)];
    init_g1 = ones(1,10);
    init_g2 = ones(1,10);
    codeLen = 1023;
    offset = 0;
    fbMode = svLabel;
    [code, symbol] = GPS_GoldSequence_generator(init_g1, init_g2, codeLen, fbMode, offset);
    sArray(:,ii+1) = symbol;
end
% Check the correlation properties in Zero lag
%plot(abs(sArray' * sArray));
% Check the correlation properies in non-zero lag
maxXcorr = 0;
for ii = 0:36
    for jj = ii+1:36
        temp =abs(xcorr(sArray(:,ii+1),sArray(:,jj+1)));
        maxTemp = max(temp);
        if (maxTemp > maxXcorr)
            maxXcorr = maxTemp;
            disp(['Max Correlation between ',num2str(ii),' and ',num2str(jj),' is ',num2str(maxXcorr)]);
        end
        
        %plot(temp);
        %title(['XCORR between codes: ',num2str(ii+1),' and ', num2str(jj+1)]);
        %pause(1);
    end
end

% End of program
