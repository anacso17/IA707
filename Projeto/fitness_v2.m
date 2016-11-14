function [ fit ] = fitness_v2(directory,FILT)
    
%     FILT = sort(FILT,2,'ascend');
    down_factor = 1;
    %cut_freq = 6*1000;
    cut_freq = FILT(end);
    minpeakheight = FILT(end-1);
    FILT = FILT(1:end-2);
    
    files = dir([directory '/*.mat']);
    %songs = dir([directory '/*.mat']);
    %groundtruth = dir([directory '/*.txt']);
    f0 = zeros(length(files),1);
    
    for i = 1 : length(files)
        fprintf('Reading file %s... ', files(i).name);
        load([directory  '/'  files(i).name]);

        if cut_freq/fs <= 0 || cut_freq/fs >= 1
            f0(i) = 0;
            continue;
        end
        [b,a] = butter(4,cut_freq/fs);
        audio = filter(b,a,audio);

        audio = downsample(audio, down_factor);
        fs = fs/down_factor;
        %FILT = [40/fs FILT];

        onsets_signal = onset_detection(audio,FILT*down_factor);
        %a = max(onsets_signal);
        %onsets_signal(onsets_signal<a/20) = 0;
    %     figure
    %     t = 1 : length(onsets_signal);
    %     t = t - 1;
    %     t = (t/fs)*1000;
    %     plot(t,onsets_signal,'b')
        
        if max(onsets_signal) >= minpeakheight
            [peaks,marks] = findpeaks(onsets_signal,'minpeakheight',minpeakheight);
            %f = evaluation_v2((marks-1)*1000/fs, onsets);
            [~,~,f] = evaluation((marks-1)*1000/fs, onsets);
        else
            f = 0;
        end
        f0(i) = f;
    %     hold on
    %     plot((marks-1)*1000/fs,peaks,'ro')
    %     t = 1 : length(ref);
    %     t = t - 1;
    %     stem(ref,3*10^-5*ones(size(ref)),'g^')
    %     hold off

        fprintf('fitness: %f\n', f);
        %fprintf('%s\n', mat2str([FILT, minpeakheight, cut_freq], 3));
                
    end
    %   r
    %   p
    %   f
    fit = mean(f0);
    %   o = (marks-1)*1000/fs;
end