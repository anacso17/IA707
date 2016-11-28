function [ fit ] = fitness_v5(directory,FILT,flag,m)

    down_factor = 1;
    cut_freq =  16*1000;
    
    minpeakheight = FILT(end); 
    FILT = FILT(1:end-1);

    files = dir([directory '/*.mat']);
    f0 = [];
    
    for k = 1:length(FILT)
        if(FILT(k)) == 0
            FILT(k) = 0.0001;
        end     
    end

    if flag == 0
          for i = 1 : m
            load([directory  '/'  files(i).name]);
%             fprintf('%s\n',files(i).name);

            [b,a] = butter(4,cut_freq/fs);
            audio = filter(b,a,audio);

            audio = downsample(audio, down_factor);
            fs = fs/down_factor;
%             FILT = [40/fs FILT];

            onsets_signal = onset_detection_v2(audio,FILT*down_factor);

            if max(onsets_signal) >= minpeakheight
                [peaks,marks] = findpeaks(onsets_signal,'minpeakheight',minpeakheight);
                [r(i),p(i),f] = evaluation((marks-1)*1000/fs, onsets);
            else
                f = 0;
            end
            f0(i) = f;

          end
    else 
         for i = 1 : length(files)
            load([directory  '/'  files(i).name]);
            fprintf('%s...\n',files(i).name);

            [b,a] = butter(4,cut_freq/fs);
            audio = filter(b,a,audio);

            audio = downsample(audio, down_factor);
            fs = fs/down_factor;
%             FILT = [40/fs FILT];

            onsets_signal = onset_detection_v2(audio,FILT*down_factor);

            if max(onsets_signal) >= minpeakheight
                [peaks,marks] = findpeaks(onsets_signal,'minpeakheight',minpeakheight);
                [r(i),p(i),f] = evaluation((marks-1)*1000/fs, onsets);
            else
                f = 0;
            end
            f0(i) = f;
            fprintf('%f...\n',f);

%             figure
%             t = 1 : length(onsets_signal);
%             t = t - 1;
%             t = (t/fs)*1000;
%             plot(t,onsets_signal,'b')
%             
%             hold on
%             plot((marks-1)*1000/fs,peaks,'bo')
%             t = 1 : length(onsets);
%             t = t - 1;
%             stem(onsets,a*ones(size(onsets)),'ro')
%             hold off
% 
%             figure
%             stem((marks-1)*1000/fs,peaks,'b')
%             hold on
%             stem(onsets,max(onsets_signal)*ones(size(onsets)),'r')
%             hold off
          end
    end
%   r
%   p
%   f0
  fit = mean(f0);
%   o = (marks-1)*1000/fs;
end

