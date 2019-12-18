matrix = [1,1,1,0;1,1,0,1;1,0,1,1;0,1,1,1];
input_matrix = matrix*2.^[3:-1:0]';
encodedbits=[1;1;0;1];
 GaussianDecoderOutput_fp=GaussianTryReduction(input_matrix,encodedbits);
% GaussianDecoderOutput_fp=GaussianBTryExp(matrix,encodedbits);