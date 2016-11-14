function [ fit ] = fitness(directory,FILT)
    
%     FILT = sort(FILT,2,'ascend');
    down_factor = 1;
    cut_freq =  6*1000;
    
    minpeakheight = FILT(end); 
    FILT = FILT(1:end-1);

    files = dir([directory '/*.mat']);
    f0 = [];

%   for i = 1 : length(files)
  for i = 1:20
    load([directory  '/'  files(i).name]);

    [b,a] = butter(4,cut_freq/fs);
    audio = filter(b,a,audio);
    
    audio = downsample(audio, down_factor);
    fs = fs/down_factor;
%     FILT = [40/fs FILT];
    
    onsets_signal = onset_detection(audio,FILT*down_factor);
%     a = max(onsets_signal);
%     onsets_signal(onsets_signal<a/20) = 0;
 
    if max(onsets_signal) >= minpeakheight
        [peaks,marks] = findpeaks(onsets_signal,'minpeakheight',minpeakheight);
        [r(i),p(i),f] = evaluation((marks-25)*1000/fs, onsets);
    else
        f = 0;
    end
    f0(i) = f;
    
%     figure
%     t = 1 : length(onsets_signal);
%     t = t - 1;
%     t = (t/fs)*1000;
%     plot(t,onsets_signal,'b')
%     
%     hold on
%     plot((marks-1)*1000/fs,peaks,'bo')
%     t = 1 : length(onsets);
%     t = t - 1;
%     stem(onsets,a*ones(size(onsets)),'ro')
%     hold off
    
  end
  r
  p
  f0
  fit = mean(f0);
%   o = (marks-1)*1000/fs;
end

