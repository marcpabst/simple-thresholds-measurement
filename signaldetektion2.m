function signaldetektion2(dispAmp, startSeq)
    % signaldetektion
    % Measure threshold for detecting frequency glide
    % AB April 2010
    % modified SG & UR April 2014
    % modified DM April 2018
    % ..........................................................................
 
    toneDur = 0.5; % tone duration in seconds
    rampDur = 0.020; % duration of ramps
    amp1 = 0.15; % signal amplitude
    fs = 16000; % sampling rate
    freq = 400; % frequency of sine tone (in Hz)
    
    t = 10; % number of tones
    n = 3; % number of sets per criteria
    c = 3; % number of criteria
    
    filename = "auswertung.xlsx";
 
    if nargin < 1 % default
        dispAmp = 0;
    end
    if nargin < 2
        startSeq = 1;
    end
    
    testSequences = zeros(n*c, t);  % create an empty matrix to save sequences
    ls = [0,0,0,0,0,amp1,amp1,amp1,amp1,amp1]; % create the sequences by generating linear spaced points
    for i = 1:1:size(testSequences, 1)
        testSequences(i, :) = ls(randperm(length(ls))); % create a random permutation and add sequences to matrix
    end
    
    data = zeros(size(testSequences, 2)*n*c, 4); % create an empty matrix for data
    for nSeq = startSeq:size(testSequences, 1)
        disp(' ');
        disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
        disp(['Testsequenz ' num2str(nSeq)]);
        input('Start mit ENTER');
        for nTone = 1:size(testSequences, 2)
            testTone = makeSignalAndNoise(testSequences(nSeq, nTone),freq, fs, toneDur, rampDur);
            if dispAmp
                 disp(['Ton Nr. ' num2str(nTone, '%0.2d') ' (' num2str(testSequences(nSeq, nTone)) ')']);
            else
                 disp(['Ton Nr. ' num2str(nTone, '%0.2d')]);
            end
            fprintf("Ton vorhanden? (y/n)")
            sound(testTone, fs)
            [answer, charCode] = getEncodedAnswersFromInput(["y","n"],[1,0]);
            fprintf(" [%s]\n",char(charCode))
            data(((nSeq-1)*10+nTone), :) = [ceil(nSeq/n), nTone, testSequences(nSeq, nTone), answer];
        end
    end
    
    while true
        try
            fprintf("Speichere Daten in %s... ",filename)
            %xlswrite(filename, repmat(' ',[1000 4]),2,"A5")
            xlswrite(filename, data,2,"A5") % schreibt die Datenmatrix in [filename], sheet 1, ab Zelle A5
            break
        catch 
            input('...FEHLER: Konnte nicht in Datei schreiben. Neuer Versuch mit ENTER.');
        end
    end
    winopen auswertung.xlsx
 
 