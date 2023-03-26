% Author: Lorenzo S. Querol
% Date: 2021
% This function transforms the signal back to time domain given the
% magnitude and synthesized phases.
% ========================================================================
% Params   Vector  magnitude  - magnitudes of current frame
%          Vector  synPhase   - phases of current frame
%          Vector  Wn         - window function
%          Vector  syHop      - synthesis hop size
%          Integer windowSize - window Size
% Returns  Vector  frame      - transformed frame
function [frame] = SynthesizeFrame (magnitude, synPhase, Wn, syHop, windowSize)
    complexVector = magnitude .* exp(1i * synPhase);
    frame = real(ifft(complexVector)) .* Wn' / sqrt(((windowSize / syHop) / 2));
end