function tone = makeSignalAndNoise(ampSignal,f,fs,toneDur,rampDur)
    signal=makeFreqGlide(f,f,fs,toneDur,rampDur,0)*ampSignal;
    noise=randn(1, toneDur*fs);
    tone = signal+noise;
end