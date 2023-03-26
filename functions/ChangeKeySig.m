% A part of this implementation was adapted from:
% Title: Guitar Pitch Shifter
% Author: François Grondin
% Date: 2009-2021
% Code version: ~
% Availability: http://www.guitarpitchshifter.com/matlab.html
% ========================================================================
% This function changes the key signature of the audio file given. The
% function implements a phase vocoder algorithm wherein Short Time Fourier
% Transform (STFT) is applied to the signal to process it in the Frequency
% Domain. Furthermore, it also uses the OLA (OverLap Add) method to reduce
% discontinuities in the synthesized signal.
% ========================================================================
% Params   String   audioFile    - file name of the audio file
%          Integer  semiTones    - intended amount of pitch shift
% Returns  Vector   outputSignal - pitch-shifted signal
function [outputSignal] = ChangeKeySig (audioFile, semiTones)
    % Read audio file
    [inputSignal, Fs] = audioread(audioFile);
    
    N = length(inputSignal);    % Length of inputSignal
    windowSize = 1024;          % Optimal window size
    Wn = hamming(windowSize);   % Hanning window function
    SF = 2^(semiTones/12);      % Pitch scaling factor
    anHop = windowSize/4;       % Analysis hop size
    syHop = round(SF*anHop);    % Resynthesis hop size

    % Create overlapping frames matrix
    [numFrames, inputFrames] = CreateFrames(inputSignal, N, windowSize, anHop);

    % Initialize processed output frames matrix
    outputFrames = zeros(numFrames, windowSize);
    synPhase = zeros(1, windowSize);
    prevPhase = zeros(1, windowSize);
    
    % Loop through the matrix and process frame-by-frame
    for i = 1 : numFrames
        % Analyze current frame
        [magnitude, phase] = AnalyzeFrame(inputFrames(i,:), Wn, anHop, windowSize);
        
        % Process current frame
        [prevPhase, synPhase] = ProcessPhase(phase, prevPhase, ...
            synPhase, windowSize, anHop, syHop);
        
        % Resynthesize current frame into outputFrames
        outputFrames(i,:) = SynthesizeFrame(magnitude, synPhase, Wn, syHop, windowSize);
    end
   
    % Overlap adding of frames (FD-PSOLA) & interpolation
    outputSignal = ResampleSignal(outputFrames, SF, numFrames, syHop, windowSize);
    subplot(3,1,1), plot(inputSignal), title('Input signal');
    subplot(3,1,2), plot(outputSignal), title('Output signal');
    
    % Play the output signal
    sound(outputSignal, Fs);
end
