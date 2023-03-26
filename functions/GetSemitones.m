% Author: Lorenzo S. Querol
% Date: 2021
% This function determines the amount of semitones that needs to be shifted
% upwards or downwards relative to the original key given by the user. A
% dictionary map was created since some notes are considered enharmonics
% therefore having the same value or position but possess a different name.
% This also takes into account the which key signature is closer to the
% original key.
% e.g. Eb is the same as D#
%      F# is the same as Gb
% ========================================================================
% Params   String   origKey    - original key of the audio file
%          String   targetKey  - target key audio file will be shifted to
% Returns  Integer  semitones  - number of semitones
function [semitones] = GetSemitones(origKey, targetKey)
    notes = containers.Map( ...
        {'C' 'C#' 'Db' 'D' 'D#' 'Eb' 'E' 'F' 'F#' 'Gb' 'G' 'G#' ...
        'Ab' 'A' 'A#' 'Bb' 'B'}, ...
        {1 2 2 3 4 4 5 6 7 7 8 9 9 10 11 11 12});
    
    % Get the upper distance of the target key from the original key
    upCtr = notes(origKey);
    upDistCtr = 0;
    while upCtr ~= notes(targetKey)
        upCtr = upCtr + 1;
        upDistCtr = upDistCtr + 1;
        if upCtr > 12
            upCtr = 1; end
    end

    % Get the lower distance of the target key from the original key
    downCtr = notes(origKey);
    downDistCtr = 0;
    while downCtr ~= notes(targetKey)
        downCtr = downCtr - 1;
        downDistCtr = downDistCtr + 1;
        if downCtr < 1
            downCtr = 12;
        end
    end

    % Compare the upper and lower distances and get the lower value
    if downDistCtr < upDistCtr
        semitones = -1 * downDistCtr;
    elseif upDistCtr < downDistCtr
        semitones = upDistCtr;
    else
        semitones = 0;
    end 
end
