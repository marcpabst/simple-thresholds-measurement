function tone = makeFreqGlide(fc1,fc2,fs,toneDur,rampDur,doDisplay)
% tone = makeFreqGlide(fc1,fc2,fs,toneDur,rampDur,doDisplay)
% 
% Create frequency glide
%
% Inputs
%   fc1         initial frequency of tone in Hz
%   fc2         final frequency of tone in Hz
%   fs          sampling frequency for the sound generated in Hz
%   toneDur          tone duration in seconds
%   rampDur     duration of the onset and offset ramps (s)
%   doDisplay   display spectrogram(1) or not(0)
%
% Outputs
%   tone        the stimulus waveform
%
% AB April 2010
%
%..........................................................................

%Generate tone
dt = 1/fs;
t = 0:dt:toneDur;
t = t(1:end-1); %make sure that tone has the right number of points

%Add raised cosine ramps
nRamp = floor(fs*rampDur);
ramp = 0.5 - 0.5 * cos(linspace(0, pi, nRamp));
ramp = [ramp, ones(1, floor(fs*toneDur) - nRamp*2), fliplr(ramp)];

tone = 0.9999*chirp(t,fc1,toneDur,fc2).*ramp;

if doDisplay
    figure; 
    subplot(2,1,1); hold on;
    title('tone with ramp');
    %plot([tone(1:0.01*fs) repmat([1 -1],1,0.0005*fs) tone(end-0.01*fs:end)]);
    plot(t,tone);
    subplot(2,1,2); hold on;
    title('Spectrogram with ramp');
    specgram(tone,1024,fs)
end