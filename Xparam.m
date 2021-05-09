theta = 0:10:350;
Xs1 = (0.5+0.1i)*(exp(1i*theta*(pi/180)));
Xs2 = (0.1+0.02i)*(exp(2i*theta*(pi/180)));
Xs3 = (0.05 + 0.005i)*(exp(3i*theta*(pi/180)));
Xs = Xs1 + Xs2 + Xs3;
Y = fft(Xs);
Fs = 1000;
freq1 = 0:Fs/(2*length(Xs)):Fs/2-1;
Xt1 = (0.3+0.2i)*(conj(exp(1i*theta*(pi/180))));
Xt2 = (0.1+0.1i)*(conj(exp(2i*theta*(pi/180))));
Xt3 = (0.03+0.05i)*(conj(exp(3i*theta*(pi/180))));
Xt = Xt1 + Xt2 + Xt3;
Y1 = fft(Xt);
figure
plot(freq1,Y);
hold on;
plot(freq1,Y1);
legend('Xs','Xt')
title('FFT of Xs and Xt')
xlabel('Frequency')
ylabel('Magnitude of Coefficients')
n=length(Xs);
Yz = fftshift(Y);
Yz1 = fftshift(Y1);
fshift = (-n/2:n/2-1)*(Fs/n);
powershift = abs(Yz).^2/n; 
powershift1 = abs(Yz1).^2/n; 
figure
stem(fshift,powershift);
hold on;
stem(fshift,powershift1);
figure
plot(Xs)
title('Xs real vs imaginary')
xlabel('Real')
ylabel('Imaginary')
b = Xs + Xt;
figure
plot(b)
title('Combination of Xs and Xt parameters')
xlabel('Real')
ylabel('Imaginary')