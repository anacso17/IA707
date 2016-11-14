function result = onset_detection(data,FILT)
% FILT
n = size(FILT, 2);

for i = 1 : n-1                     % creates filters and performs operation
    fmin = FILT(i);
    fmax = FILT(i+1);
    result = 0;
    
    [B, A] = butter(4,[fmin fmax]);
    band = filter(B,A,data);        % butterworth bandpass filter
    band = filter(B,A,band);        % butterworth bandpass filter
    band = filter(B,A,band);        % butterworth bandpass filter
    band = filter(B,A,band);        % butterworth bandpass filter
    band  = abs(band);              % full wave rectifier
    
    [B, A] = butter(4, 0.000907/2,'low');
    band = filter(B,A,band);        % butterworth lowpass filter
    band = diff(band);              % first order difference
    band(band<0) = 0;               % half wave rectifier
    
    if size(result,2) < size(band,2)
        result(size(band,2)) = 0;
    elseif size(band,2) < size(result,2)
        band(size(result,2)) = 0;
    end
    result = result + band;     % sum
end

end

