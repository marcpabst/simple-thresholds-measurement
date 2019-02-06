function konstanzverfahren2(dispAmp, startSeq)
    % konstanzverfahren2
    % Measure threshold for detecting presence of sine tone
    % AB April 2010
    % modified SG & UR April 2014
    % modified DM April 2018
    % modified MP April 2018
    % ..........................................................................
 
    toneDur = 0.5; % tone duration in seconds
    rampDur = 0.020; % duration of ramps
    amp0 = 0; % min. signal amplitude
    amp1 = 0.5; % max. signal amplitude
    fs = 16000; % sampling rate
    freq = 400; % frequency of sine
    
    filename = "auswertung.xlsx";
    
    t = 10; % number of tones per set
    n = 10; % number of of sets
 
    if nargin < 1 % default
        dispAmp = false;
    end
    if nargin < 2
        startSeq = 1;
    end
    
    testSequences = zeros(n, t);  % create an empty matrix to store sequences in
    ls = linspace(amp0, amp1, t); % create the sequences by generating linear spaced points
    for i = 1:1:size(testSequences, 1)
        testSequences(i, :) = ls(randperm(length(ls))); % create a random permutation and add sequences to matrix
    end
    
    data = zeros(size(testSequences, 2)*n, 4); % create an empty matrix for data
    
    for nSeq = startSeq:size(testSequences, 1)
        fprintf('\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
        disp(['Testsequenz ' num2str(nSeq)]);
        input('Start mit ENTER');
        for nTone = 1:size(testSequences, 2)
            pause(0.3)
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
            data(((nSeq-1)*10+nTone), :) = [nSeq, nTone, testSequences(nSeq, nTone), answer];
        end
    end
    
    % fit curve
    coeff = fitLogisticCurve(data, false);
    
    while true
        try
            fprintf("Speichere Daten in %s... ",filename)
            %xlswrite(filename, repmat(' ',[1000 4]),1,"A5")
            xlswrite(filename, data,1,"A5") % schreibt die Datenmatrix in [filename], sheet 1, ab Zelle A5
            xlswrite(filename, coeff,1,"J29") % schreibt gefittete Koeffizienten in [filename], sheet 1, ab Zelle J29
            break
        catch 
            input('...FEHLER: Konnte nicht in Datei schreiben. Neuer Versuch mit ENTER.');
        end
    end
    winopen auswertung.xlsx
 
