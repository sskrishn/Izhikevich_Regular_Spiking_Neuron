% This MATLAB file generates figure 1 in the paper by
% Izhikevich E.M. (2004)
% Which Model to Use For Cortical Spiking Neurons?
% use MATLAB R13 or later. December 2018. Cincinnati, Ohio
% Modified by Siva Sai Krishna Paladugu
%%%%%%%%%%%%%%% mean spike rate R vs I %%%%%%%%%%%%%%%%%%%%%%
RR = [];
for j = 0:0.25:20.0
    spikeCount = 0;
    steps = 1000; %This simulation runs for 1000 steps
    a = 0.02; b = 0.25; c = - 65; d = 6; %parameters with initial values
    V = - 64; u = b * V; %membrane voltage with initial value
    VV = []; uu = [];
    tau = 0.25; %tau is the discretization time-step and
    tspan = 0:tau:steps; %tspan is the simulation interval
    T1 = 50; %T1 is the time at which the step input rises
    spike_ts = [];
    for t = tspan
        if (t > T1)
            I = j; %input current with values ranging from 1 to 20.
        else
            I = 0;
        end;
        V = V + tau * (0.04 * V ^ 2 + 5 * V + 140 - u + I); %discretized main equations
        u = u + tau * a * (b * V - u);
        if V > 30 %if this is a spike
            VV(end + 1) = 30; %VV is the time-series of membrane potentials
            V = c;
            u = u + d;
            spike_ts = [spike_ts; 1]; %records a spike
            if (t > 200)
                spikeCount = spikeCount + 1; %counting spikes for last 800 steps
            end
        else
            VV(end + 1) = V;
            spike_ts = [spike_ts; 0]; %records no spike
        end;
        uu(end + 1) = u;
    end;
    RR(end + 1) = spikeCount / 800; %mean spike rate by getting count of spikes
end
%%%%%%%% plots %%%%%%%%
cur = 0:0.25:20;
plot(cur, RR, 'r');
axis([0 max(cur) 0 0.1])
ylabel('Mean Spike Rate (R)');
xlabel('Current (I)')
xticks([0 max(cur)])
xticklabels([0 20])
yticks([0 0.1)]);
title('Fig. 1.2. Mean Spike Rate (R) vs I')