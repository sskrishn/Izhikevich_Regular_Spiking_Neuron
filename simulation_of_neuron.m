% This MATLAB file generates figure 1 in the paper by
% Izhikevich E.M. (2004)
% Which Model to Use For Cortical Spiking Neurons?
% use MATLAB R13 or later. December 2018. Cincinnati, Ohio
% Modified by Siva Sai Krishna Paladugu 
%%%%%%%%%%%%%%% regular spiking %%%%%%%%%%%%%%%%%%%%%%
counter = 0;
lbls = ['a', 'b', 'c', 'd', 'e']; %to have different figure names
colors = ['k', 'm', 'c', 'r', 'b']; %to have different colors for plots
for j = 0:5:20 %j is for different current levels
    steps = 1000; %This simulation runs for 1000 steps
    a = 0.02; b = 0.25; c = - 65; d = 6; %parameters with initial values
    V = - 64; u = b * V; %membrane voltage with initial value
    VV = []; uu = [];
    tau = 0.25; %tau is the discretization time-step
    tspan = 0:tau:steps; %tspan is the simulation interval
    T1 = 50; %T1 is the time at which the step input rises
    spike_ts = [];
    counter = counter + 1;
    for t = tspan
        if (j == 0)
            j = 1;
        end
        if (t > T1)
            I = j; %input current with values 1,5,10,15,20
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
        else
            VV(end + 1) = V;
            spike_ts = [spike_ts; 0]; %records no spike
        end;
        uu(end + 1) = u;
    end;
    %%%%%%%% plots %%%%%%%%
    subplot(5, 1, counter)
    plot(tspan, VV, colors(counter)); %VV is plotted as the output
    axis([0 max(tspan) - 90 40])
    xlabel('Time-step');
    ylabel('Mem-Vol')
    xticks([0 max(tspan)])
    xticklabels([0 steps])
    yticks([- 90 40)]);
    title(['Fig. 1.1(', lbls(counter), '). Simulation for I = ', num2str(j)])
end