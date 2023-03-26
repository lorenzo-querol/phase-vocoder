% Author: Lorenzo S. Querol
% Date: 2021
% This function transforms the signal to the frequency domain via FFT and
% is windowed by the Hamming window function.
% ========================================================================
% Params   Vector  currentFrame  - current frame
% Vector   Wn                    - window function
%          Vector  anHop         - analysis hop size
%          Integer windowSize    - window Size
% Returns  Vector  phaseVector   - phases of current frame
%          Vector  magVector     - magnitudes of current frame
% ========================================================================
function [magVector, phaseVector] = AnalyzeFrame (currentFrame, Wn, anHop, windowSize)
    % Analysis of Signal
    windowVector = fft(currentFrame .* Wn') / sqrt(((windowSize / anHop) / 2));
    magVector = abs(windowVector);
    phaseVector = angle(windowVector);
end


