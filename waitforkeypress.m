function key = waitforkeypress
% WAITFORKEYPRESS  Stopps the execution until key is pressed
%   KEY = WAITFORKEYPRESS returns the corresponding char code
fh = figure(...
    'name','...', ... % title is not really important
    'keypressfcn','set(gcbf,''Userdata'',double(get(gcbf,''Currentcharacter''))) ; uiresume ', ... % add a callback to store key code as userdata and resume
    'windowstyle','modal',... % creates a modal dialogue
    'numbertitle','off', ...
    'position',[0 0  1 1],... % it's .. invisible!
    'userdata','timeout') ;  

uiwait; % wait for uiresume (within callback)
key = get(fh,'Userdata'); % get the key code
delete(fh) % destroy the modal dialogue
end