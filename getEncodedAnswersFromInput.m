function [value, charCode] = getEncodedAnswersFromInput(chars, codes)
% GETENCODEDANSWERSFROMINPUT  Stopps the execution until key is pressed
%   KEY = WAITFORKEYPRESS returns the corresponding char code
charCode = waitforkeypress;
if(charCode==27) % throw an exception if key is [esc]
    throw(MException('getEncodedAnswersFromInput:Canceled', 'Abgebrochen'))
elseif(contains(char(charCode),chars))
    value = codes(chars==char(charCode));
else
    [value, charCode] = getEncodedAnswersFromInput(chars, codes); % if the key pressed was not y, n or esc
    return;
end

end

