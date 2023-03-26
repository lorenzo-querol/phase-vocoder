% A part of this implementation was adapted from:
% Title: Guitar Pitch Shifter
% Author: François Grondin
% Date: 2009-2021
% Code version: ~
% Availability: http://www.guitarpitchshifter.com/matlab.html
% ========================================================================
% This function implements the OLA (Overlap Add) and interpolation to
% reconstruct the pitch shifted signal and match the length of the original
% input signal.
% ========================================================================
% Params  Vector    outputFrames  - time domain output signal
% Integer SF                      - pitch scaling factor
%         Integer   numFrames     - number of frames in input
%         Integer   syHop         - synthesis hop size
%         Integer   windowSize    - window size
% Returns Vector    outputSignal  - resampled signal
function [outputSignal] = ResampleSignal(outputFrames, SF, numFrames, syHop, windowSize)
    % Initialize the vector for the output signal
    outputSignal = zeros(numFrames * syHop - syHop + windowSize, 1);
    timePtr = 1;
    
    % Place each frame at every synthesis hop size interval
    for i = 1 : numFrames
        outputSignal(timePtr : timePtr + windowSize - 1) = ...
            outputSignal(timePtr : timePtr + windowSize - 1) + ...
            outputFrames(i, :)';
        timePtr = timePtr + syHop;
    end

    % Reconstruct the output signal
    outputSignal = interp1((0:length(outputSignal)-1),outputSignal, ...
        (0:SF:length(outputSignal)-1));
end