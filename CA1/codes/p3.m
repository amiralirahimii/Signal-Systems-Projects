%Part3_1: generate signal
ts=1e-9;
T=1e-5;
tau=1e-6;
t=0:ts:T;
index=round(tau/ts);
sentSignal=zeros(size(t));
sentSignal(1:index)=1;

figure;
plot(t,sentSignal,'b');
grid on;
ylim([-2 2]);

%Part3_2 generate recieved signal
c=3e8;
R=450;
td=3e-6;
startIndex=round(td/ts);
recievedSignal=zeros(size(t));
recievedSignal(startIndex+1:startIndex+index)=0.5;
hold on;
plot(t,recievedSignal,'r');

%Part3_3 find the td with correlation (using p3_3 function)
[findR, corrVal] = p3_3(recievedSignal);
figure;
plot(t,corrVal);
grid on;
fprintf('part3_3: Found R is: %d',p3_3(recievedSignal));

%Part3_4 add noise
noisePower=0:0.1:5;
estimationError=zeros(size(noisePower));
for i=1:size(noisePower,2)
    sumEstimationError = 0;
    for j=1:100
        noise = noisePower(i) * randn(size(recievedSignal));
        generateNoisySignal = recievedSignal + noise;
        estimation = p3_3(generateNoisySignal);
        sumEstimationError = sumEstimationError + abs(estimation-450);
    end
    estimationError(i)=sumEstimationError/100;
end

figure;
plot(noisePower, estimationError);
xlabel('Noise Power(Based On Standard Deviation)');
ylabel('estimation Error(m)');
grid on;
