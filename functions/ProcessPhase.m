% A part of this implementation was adapted from:
% Title: Phase Vocoder Algorithm by J. L. Flanagan and R. M. Golden
% Author: ederwander
% Date: 2017
% Code version: ~
% Availability: https://tinyurl.com/7h3dyxuw (Signal Processing - Stack Exchange)
% ========================================================================
% This function processes the phase vector of the current frame. By
% unwrapping the phase, the true frequency can be obtained in that certain
% time interval.
% ========================================================================
% Params  Vector  currentPhase  - current phase to be processed
%         Vector  prevPhase     - phases of previous frame
%         Vector  synPhase      - synthesized phases of current frame
%         Integer windowSize    - window size
%         Integer anHop         - analysis hop size
%         Integer syHop         - synthesis hop size
% Returns Vector  prevPhase     - phases of previous frame
%         Vector  synPhase      - synthesized phases of current frame
function [prevPhase, synPhase] = ProcessPhase (currentPhase, prevPhase, ...
        synPhase, windowSize, anHop, syHop)
    % Center frequency
    centFreq = (0 : windowSize - 1) * 2 * pi * anHop / windowSize;
    
    % Phase Difference from previous phase
    deltaPhi = currentPhase - prevPhase;
    prevPhase = currentPhase;

    % Unwrapped phase
    phaseDifference = deltaPhi - centFreq;

    % Map from +pi to -pi
    wrappedPhase = mod(phaseDifference + pi, 2 * pi) - pi;

    % Determine the true frequency
    trueFreq = 2 * pi * (0:(windowSize-1)) / windowSize + wrappedPhase / anHop;
    
    % Get the processed phase
    synPhase = synPhase + syHop * trueFreq;
end
