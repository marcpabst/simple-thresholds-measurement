function testSignalAndNoise
    toneDur = 0.5;
    rampDur = 0.020;
    freq = 400;
    ampSound = .6;
    fs = 16000;

    testTone = makeSignalAndNoise(0,freq,fs,toneDur,rampDur);
    sound(testTone,fs)
    pause(2)
    testTone = makeSignalAndNoise(ampSound,freq,fs,toneDur,rampDur);
    sound(testTone,fs)
end