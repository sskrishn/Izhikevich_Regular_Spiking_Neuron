# Izhikevich_Regular_Spiking_Neuron


a)To implement the program to simulate the neuron using the model which combines the biologically
plausibility of Hodgkin-Huxley-type dynamics and the computation efficiency of integrate-and-fire neurons
i.e., Izhikevich spiking model for different levels of synaptic currents or injected dc currents and plot the
simulations for five different current levels. Also need to plot for spike rate versus injected dc current
ranging from 0 to 20 in steps of 0.25


b)To implement the program to simulate a simple network of two neurons, A and B where A gets a steady
external input IA, and B only gets its input from the output of A using the same model as discussed in
problem statement 1 and plot mean spike rate of both neurons against input current of neuron. Also need to
plot mean spike rate of neuron A versus mean spike rate of neuron A.
 
 **Brief Background**
 
 
One of the most widely used current models for neurons is the Izhikevich model, proposed by Eugene Izhikevich
(Izhikevich, 2003, 2004). It models the membrane potential of a neuron by two coupled differential
equations:

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)

with the condition that:
if v ≥ 30, v = c, u = u + d (3)
Thus, the model is defined completely by four parameters: a, b, c and d. By setting the parameters to
different values, neurons with many different natural behaviors can be obtained, as described in Izhikevich
(2003, 2004). The model generates the full shape of the action potential. Thus, it is more than an integrateand-fire
model but far less complicated than a Hodgkin-Huxley model.

**Membrane potential vs Injected current.**


*File : simulation_of_neuron.m*


As we increase the Injected current, we have observed that spiking rates of neuron are also increasing significantly. Initially membrane voltage will be at resting potential and when we inject pulses of dc current, it will get increased as depolarization occurred and again after reaching maximum, it will get decreased as repolarization occurred. It will get below the resting potential as more positive ions (k+ ions) will try to get equilibrium for k+ which is less than the initial resting potential but eventually it will reach to resting potential after refractory period. Fig 1.1(a) and Fig. 1.1(b) from simulation_of_neuron.png seem to be regular spiking and remaining three figures seem to have initial bursting and then having periodic spiking which is spike frequency adaptation. Reason for this is during the initial burst, recovery variable u builds up and eventually switches the dynamics from bursting to spiking.

**Mean Spike Rate vs Injected dc-current.** 


*File : spiking_rate.m*


Here mean spike rate R is calculated for each value of I considering the last 800 steps of each 1000-step trial. From the figure spiking_rate.png, the mean spike rate will remain zero initially indicating for almost negligible currents the spike rate will be almost negligible. And then there is steep increase for particular period and then increasing monotonically with increasing currents. Also observed, by increasing the time scale of recovery variable ‘a’, we have observed that mean spike rate increases monotonically but with lesser slope. 

**Neuron B gets input from Neuron A**


*File : two_neurons.m*


We can observe that input current for neuron B depends on output of neuron A and some weight, there is no constant current for neuron B and so more fluctuations are observed for larger values of current to neuron A which leads decrease of mean spike rate of neuron B. Also we can infer that Neuron A is inhibiting Neuron B sometimes and also exhibiting in some other times which is causing inter small spikes in simulation of neuron B.



