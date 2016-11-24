function result = onset_detection_v2(data,FILT)
% FILT
n = size(FILT, 2);
odd = 1:2:n;
even = 2:2:n;

%verifica validade e corrige filtro
n = size(FILT,2);
odd = 1:2:n;
even = 2:2:n;
for k = 1:n/2
    if FILT(odd(k)) > FILT(even(k))
        aux = FILT(odd(k));
        FILT(odd(k)) = FILT(even(k));
        FILT(even(k)) = aux;
    end
end

for i = 1 : n/2                 % creates filters and performs operation
    result = 0;
    
    [B, A] = butter(4,FILT([odd(i) even(i)]));
    band = filter(B,A,data);        % butterworth bandpass filter
    band = filter(B,A,band);        % butterworth bandpass filter
    band = filter(B,A,band);        % butterworth bandpass filter
    band = filter(B,A,band);        % butterworth bandpass filter
    band  = abs(band);              % full wave rectifier
    
    [B, A] = butter(4, 0.000907,'low');
    band = filter(B,A,band);        % butterworth lowpass filter
%     figure
%     plot(band)
    band = diff(band);              % first order difference
%     figure
%     plot(band)
    band(band<0) = 0;               % half wave rectifier
    
    if size(result,2) < size(band,2)
        result(size(band,2)) = 0;
    elseif size(band,2) < size(result,2)
        band(size(result,2)) = 0;
    end
    result = result + band;     % sum
end
%     figure
%     plot(result)
end

