% A part of this implementation was adapted from:
% Title: Guitar Pitch Shifter
% Author: François Grondin
% Date: 2009-2021
% Code version: ~
% Availability: http://www.guitarpitchshifter.com/matlab.html
% ========================================================================
% This function determines the amount of frames that can be made from the
% input signal, and creates a matrix based on an overlapping frame
% interval. Each frame contains 25% (excluding the first) of the previous
% frame's values.
% ========================================================================
% Params   Vector  magnitude - magnitudes of current frame
%          Vector  synPhase  - phases of current frame
%          Vector  Wn        - window function
% Returns  Vector  frame     - transformed frame
% ========================================================================
function [numFrames, frames] = CreateFrames (inputSignal, N, windowSize, anHop)
    % Determine the number of frames that can be made from inputSignal
    numFrames = floor((N-windowSize)/anHop);
    
    % Initialize frames matrix
    frames = zeros(numFrames,windowSize);
    
    % Fill the matrix with frames
    timePtr = 0;
    for i = 1:numFrames
        frames(i,:) = inputSignal(timePtr + 1:timePtr + windowSize);
        timePtr = timePtr + anHop;
    end
end
