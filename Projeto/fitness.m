% FILT is the row vector with the cut frequencies of the band pass filters
% The frequencies must be in fractions of the sampling frequency 

function [ fit ] = fitness(directory,FILT)
    
    down_factor = 1;%5;
    cut_freq = 6*1000;

    songs = dir([directory '/*.flac']);
    groundtruth = dir([directory '/*.txt']);
    f0 = [];

% for each song, finds the onsets
%   for i = 1 : length(songs)
  for i = 1:5
    ref = load([directory  '/'  groundtruth(i).name]);
    
    [audio,fs] = audioread([directory  '/'  songs(i).name]);  
    [b,a] = butter(4,cut_freq/fs);
    audio = filter(b,a,audio);
    
    audio = downsample(audio, down_factor);
    fs = fs/down_factor;

    onsets_signal = onset_detection(audio,FILT*down_factor);
    
%     figure
%     t = 1 : length(onsets_signal);
%     t = t - 1;
%     t = (t/fs)*1000;
%     plot(t,onsets_signal,'b')
    
    [peaks,marks] = findpeaks(onsets_signal,'minpeakheight',5*10^-7);
    
%     % plots the marks and the groundtruth
%     hold on
%     plot((marks-1)*1000/fs,peaks,'ro')
%     t = 1 : length(ref);
%     t = t - 1;
%     stem(ref,3*10^-5*ones(size(ref)),'g^')
%     hold off
    
% compare with the groundtruth (reference)
    [r(i),p(i),f(i)] = evaluation((marks-1)*1000/fs, ref);
    f0 = [f0 f(i)];
  end

% prints the results and calculate the mean (fit)
%   r
%   p
%   f
  fit = mean(f0);
%   o = (marks-1)*1000/fs;
end

