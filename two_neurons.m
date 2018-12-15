% This MATLAB file generates figure 1 in the paper by
% Izhikevich E.M. (2004)
% Which Model to Use For Cortical Spiking Neurons?
% use MATLAB R13 or later. December 2018. Cincinnati, Ohio
% Modified by Siva Sai Krishna Paladugu
%%%%%%%%%%%%%%% Mean Spike Rates of two neurons %%%%%%%%%%%%%%%%%%%%%%
r_a = [];
r_b = [];
for j = 0:0.25:20.0
    spikeCount_a = 0;
    spikeCount_b = 0;
    steps = 1000; %This simulation runs for 1000 steps
    a = 0.02; b = 0.25; c = - 65; d = 6; w = 80.0; %parameters with initial values
    y = 0;
    Va = - 64; ua = b * Va; %membrane voltage of neuron A with initial value
    VVa = []; uua = []; IIa = [];
    Vb = - 64; ub = b * Vb; %membrane voltage of neuron B with initial value
    VVb = []; uub = []; IIb = [];
    tau = 0.25; %tau is the discretization time-step
    tspan = 0:tau:steps; %tspan is the simulation interval
    T1 = 50; %T1 is the time at which the step input rises
    spike_ts_a = [];
    spike_ts_b = [];
    for t = tspan
        if (t > T1)
            Ia = j; %input current with values ranging from 1 to 20.
        else
            Ia = 0;
        end;
     
        Va = Va + tau * (0.04 * Va ^ 2 + 5 * Va + 140 - ua + Ia);
        ua = ua + tau * a * (b * Va - ua); %discretized main equations for neuron A
     
        if Va > 30 %if this is a spike
            y = 1; %TO CALCULATE I FOR B WE WILL USE y.
            VVa(end + 1) = 30; %VVa is the time-series of membrane potentials of A
            Va = c;
            ua = ua + d;
            spike_ts_a = [spike_ts_a; 1]; %records a spike
            if (t > 200)
                spikeCount_a = spikeCount_a + 1; %counts spikes for neuronA
            end
        else
            y = 0;
            VVa(end + 1) = Va;
            spike_ts_a = [spike_ts_a; 0]; %records no spike
        end;
        uua(end + 1) = ua;
        IIa(end + 1) = Ia;
        Ib = w * y; %getting current for neuron B
        Vb = Vb + tau * (0.04 * Vb ^ 2 + 5 * Vb + 140 - ub + Ib);
        ub = ub + tau * a * (b * Vb - ub); %discretized main equations for neuron B
        if Vb > 30 %if this is a spike
            VVb(end + 1) = 30; %VVb is the time-series of membrane potentials of B
            Vb = c;
            ub = ub + d;
            spike_ts_b = [spike_ts_b; 1]; %records a spike
            if (t > 200)
                spikeCount_b = spikeCount_b + 1; %counts number of spikes for B
            end
        else
            VVb(end + 1) = Vb;
            spike_ts_b = [spike_ts_b; 0]; %records no spike
        end;
        IIb(end + 1) = Ib;
        uub(end + 1) = ub;
    end;
    r_a(end + 1) = spikeCount_a / 800; %Mean spike rate for neuron A
    r_b(end + 1) = spikeCount_b / 800; %Mean spike rate for neuron B
    if Ia == 10
        figure(4)
        subplot(4, 1, 3)
        plot(tspan, VVa); %VVa is plotted as the output
        axis([0 max(tspan) - 90 40])
        ylabel('V_m of A');
        xlabel('Time step');
        title(['Fig. 2.4.c Simulation of Neuron A for I_A = ', num2str(Ia)])
        subplot(4, 1, 4)
        plot(tspan, VVb); %VVb is plotted as the output
        axis([0 max(tspan) - 90 40])
        ylabel('V_m of B');
        xlabel('Time step');
        title(['Fig. 2.4.d Simulation of Neuron B for I_A = ', num2str(Ia)])
        figure(5)
        subplot(4, 1, 3)
        plot(tspan, IIa); %IIa is plotted as the output
        axis([0 max(tspan) - 10 15])
        ylabel('I_A');
        xlabel('Time step');
        title('Fig. 2.5.c I_A vs Time')
        subplot(4, 1, 4)
        plot(tspan, IIb); %IIb is plotted as the output
        axis([0 max(tspan) - 10 90])
        ylabel('I_B');
        xlabel('Time step');
        title('Fig. 2.5.d I_B vs Time for I_A=10')
    end
    if Ia == 2
        figure(4)
        subplot(4, 1, 1)
        plot(tspan, VVa); %VVa is plotted as the output
        axis([0 max(tspan) - 90 40])
        ylabel('V_m of A');
        xlabel('Time step');
        title(['Fig. 2.4.a Simulation of Neuron A for I_A = ', num2str(Ia)])
        subplot(4, 1, 2)
        plot(tspan, VVb); %VVb is plotted as the output
        axis([0 max(tspan) - 90 40])
        ylabel('V_m of B');
        xlabel('Time step');
        title(['Fig. 2.4.b Simulation of Neuron B for I_A = ', num2str(Ia)])
        figure(5)
        subplot(4, 1, 1)
        plot(tspan, IIa); %IIa is plotted as the output
        axis([0 max(tspan) - 10 15])
        ylabel('I_A');
        xlabel('Time step');
        title('Fig. 2.5.a I_A vs Time')
        subplot(4, 1, 2)
        plot(tspan, IIb); %IIb is plotted as the output
        axis([0 max(tspan) - 10 90])
        ylabel('I_B');
        xlabel('Time step');
        title('Fig. 2.5.b I_B vs Time for I_A=2')
    end
end
%%%%%%%% plots %%%%%%%%
cur = 0:0.25:20;
figure(1)
%subplot(3,1,1)
plot(cur, r_a, 'r'); %R_A vs I_A
axis([0 max(cur) 0 0.1])
ylabel('Mean Spike Rate (R_A) of Neuron A');
xlabel('Current (I_A) for Neuron A');
xticks([0 max(cur)])
xticklabels([0 20])
yticks([0 0.1]);
title('Fig. 2.1. Mean Spike Rate (R_A) of Neuron A vs I_A for Neuron A');
figure(2)
%subplot(3,1,2)
plot(cur, r_b, 'b'); %R_B vs I_A
axis([0 max(cur) 0 0.1])
ylabel('Mean Spike Rate (R_B) of Neuron B');
xlabel('Current (I_A) for Neuron A');
xticks([0 max(cur)])
xticklabels([0 20])
yticks([0 0.1]);
title('Fig. 2.2. Mean Spike Rate (R_B) of Neuron B vs I_A for Neuron A');
figure(3)
%subplot(3,1,3)
scatter(r_a, r_b, 'k'); %R_A vs R_B
xlabel('Mean Spike Rate (R_A) of Neuron A');
ylabel('Mean Spike Rate (R_B) of Neuron B');
title('Fig. 2.3. Mean Spike Rate (R_A) of Neuron B vs Mean Spike Rate (R_B) of Neuron
A');
