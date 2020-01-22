payload = [1 1 1 0];
gc = [1 1 1];
Tx = kron(payload,gc);
J = sqrt(-1);
offset = exp(J*2*pi*4000/10e6*[0:length(Tx)-1]);
TxOut = Tx.*offset;
%%
gc1 = [1 1 1];
fft_tx = fft(TxOut,14);
fft_gc = conj(fft(gc1,14));
output = ifft(fft_tx.*fft_gc)
output=sum(output(2:end-1));
plot(abs(output));