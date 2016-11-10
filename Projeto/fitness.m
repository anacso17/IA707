%
% FILT is the row vector with the cut frequencies of the band pass filters
% The frequencies must be in fractions of the sampling frequency 

function [ fit ] = fitness(directory,FILT)
    songs = dir([directory '/*.flac']);
    groundtruth = dir([directory '/*.txt']);
    f0 = [];

  % for each song, finds the onsets
  for i = 1 : length(songs)		
    ref = load([directory  '/'  groundtruth(i).name]);
    [audio,fs] = audioread([directory  '/'  songs(i).name]);  

    %low pass filter in 8KHz
    [b,a] = butter(4,8*1000/fs);
    audio = filter(b,a,audio);

    % performs the onset detection
    onsets_signal = onset_detection(audio,FILT);
    
%     % plot the onsets signal
%     figure
%     t = 1 : length(onsets_signal);
%     t = t - 1;
%     t = (t/fs)*1000;
%     plot(t,onsets_signal,'b')
    
    % marks the peaks of the onset signal to compare with the groundtruth
    [peaks,marks] = findpeaks(onsets_signal,'minpeakheight',5*10^-6);
    
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
  r
  p
  f
  fit = mean(f0);

%   o = (marks-1)*1000/fs;

end

