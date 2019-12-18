% Setup the necessary structure for the decoder from the CC
%% CC code initialization
J = sqrt(-1);

if (CC)
    CC_rate = 1/2;
    %CCtrellis = poly2trellis(5,[37 27 33 25 35]);  % dfree = 20
    %CCtrellis = poly2trellis(3,[7 7 7 5 5]);   % dfree = 13
    %CCtrellis = poly2trellis(7,[135 135 147 163]);   % dfree = 20
    CCtrellis = poly2trellis(7,[135 163]);
    %load CCodes/trellis1By2Code2.mat;
    %CCtrellis = trellis;
    CCtrellis1 = CCtrellis;
    numStatesCC = CCtrellis1.numStates;
    numInputSymbolsCC = CCtrellis1.numInputSymbols;
    CCtrellis1.prevStates = zeros(numStatesCC,numInputSymbolsCC);
    %CCtrellis1.outputs = oct2dec(CCtrellis.outputs); % decimal conversion\
    numStates = CCtrellis1.numStates;
    inputIndexArray = zeros(1,numStates);
    for stateIndex = 1:numStates
        [CCtrellis1.prevStates(stateIndex,:),yy] = find(CCtrellis1.nextStates == stateIndex-1);
        CCtrellis1.inputIndexArray(stateIndex) = yy(1);
    end
    numStatesCC = CCtrellis.numStates;
    numInputSymbolsCC = CCtrellis.numInputSymbols;
end

% ---------> Convolutional encoder <----------- usng Matlab function
inBits = (rand(1,N) > 0.5);
inBits = inBits(1:numBits);

% Encode using CC code
CC_in = inBits;
CC_out = convenc(CC_in, CCtrellis);
CCcodedSym = (2*CC_out-1)*sqrt(1/3);

%--------------> Viterbi Decoder starts here <-------------
% *** Decode CC coded system
if (CC)
    noise1 = [1 J]/sqrt(2) * randn(2,length(CCcodedSym))
    chInput1 = CCcodedSym  + noise1 ;
    %temp = reshape(chInput1,CCcodeLen,N);
    numStates = CCtrellis.numStates;
    numInputSymbols = CCtrellis.numInputSymbols;
    pm = zeros(N+1,numStates);   % path metric for the path ending in
    % each state
    pm(1,:) = 1000*ones(1,numStates);              % start with large number to
    pm(1,1) = 0;
    % discourage this path
    pms = zeros(N+1,numStates);  % remember path
    bm = zeros(numStates,numInputSymbols);
    
    for symIndex = 1:N
        sigSet = chInput1((symIndex-1)*CCcodeLen+1:symIndex*CCcodeLen);
        dist = sum(abs(repmat(sigSet',1,2^CCcodeLen)- ...
            sqrt(CC_rate)*(2*reshape(dec2bits([0:2^CCcodeLen-1]',CCcodeLen),CCcodeLen,2^CCcodeLen)-1)).^2);
        %% Fill in the branch metrics based on min Hamming distances
        for stateIndex = 1:numStates
            for in = 1:numInputSymbols
                outputIndex = CCtrellis1.outputs(stateIndex,in);
                bm(stateIndex,in) = dist(1+outputIndex);
            end
        end
        
        % Update path metric
        for stateIndex = 1:numStates
            inputIndex = CCtrellis1.inputIndexArray(stateIndex);
            temp1 = CCtrellis1.prevStates(stateIndex,:);
            temp = [pm(symIndex,temp1) + bm(temp1,inputIndex)'];
            [minv,mini] = min(temp);
            pm(symIndex+1,stateIndex) = minv;
            pms(symIndex+1,stateIndex) = temp1(mini);
        end
    end   % End of SymbolIndex loop
    
    % Trace back the minimum distance path
    [pmVal,pmMin] = min(pm(end,:));  % choose the minimum path
    curr_state = pmMin;
    decodedBits1 = zeros(1,N);
    for symIndex = N:-1:1
        prev_state = pms(symIndex+1,curr_state);
        bit1 = find(CCtrellis.nextStates(prev_state,:) == curr_state-1);
        decodedBits1(symIndex) = bit1-1;
        curr_state = prev_state;
    end
end  % for if (CC)}