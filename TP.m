%Run this section to generate variables, gains, transfer functions etc.
%constants, and simulation data
M=2;
m=0.5;
l=1;
g=9.81;
%State Matricees
A=[0 (M+m)*g/(M*l) 0 0;1 0 0 0;0 -m*g/M 0 0;0 0 1 0];
B=[-1/(M*l); 0; 1/M; 0];
b=B;
C=[0 0 0 1];
D=[0];
%Desired Characteristics
ts=2;
os=.0432;
%wn,zeta calcs
zeta=(-log(os)/pi)/sqrt(1+(log(os)/pi)^2);
wn=4/(zeta*ts);
%initial conditions
x_dot_0=0;
x_0=0;
theta_0=0;
theta_dot_0=0;
chareq2des=[1 2*wn*zeta wn*wn];%the characteristic equation for desired response of system
zeroRemove=conv([1 3.1321],[1 wn]);%one pole at zero, one at the natural freq
phi=roots(conv(zeroRemove,chareq2des));
K=acker(A,B,phi);%svf gains
[numCL,denCL]=ss2tf(A-B*K,B,C,D);
[numO,denO]=ss2tf(A,B,C,D);
oltf=tf(numO,denO);%transfer function for open loop poles
cltf=tf(numCL,denCL);%transfer function for cal gain
calGain=1/dcgain(cltf);
lineStates=sim('tpSimul.slx',0:.1:12);
sim('PendulumCart_Block.slx', 0:.1:12);
pOver=100*(max(nlpos.Data)-1);
%%
%Maps generated and saved as pngs deliverable 1
%If formatting needs to be changed, run this section to generate
pzmap(oltf);
title("Open Loop Pole Zero Map");
figure(2);
pzmap(cltf);
title("Closed Loop Pole Zero Map")
%%
%linear non-linear comparison
%deliverable 2
subplot(3,1,1);
plot(conef.time,conef.Data,'b');
hold on;
plot(lineStates.effort.time,lineStates.effort.Data,'--r');
xlabel("Time (s)");
ylabel("Control Effort");
title("Control Effort Vs. Time");
legend("Non-linear System", "Linearized System");
subplot(3,1,2);
plot(nlstates.time,nlstates.Data(:,2),'b');
hold on;
plot(lineStates.states.time,lineStates.states.Data(:,2),'--r');
xlabel("Time (s)");
ylabel("Angular Position (rads)");
title("Angular Position vs. Time");
legend("Non-linear System", "Linearized System");
subplot(3,1,3);
plot(nlpos.time,nlpos.Data,'b');
hold on;
plot(lineStates.position.time,lineStates.position.Data,'--r');
xlabel("Time (s)");
ylabel("Position (m)");
title("Cart Position vs. Time");
legend("Non-linear System", "Linearized System");
%%
%deliv 3 Meeting specs
ref=ones(1,13);
t=0:1:12;
plot(t,ref,'--k');
hold on;
plot(nlpos.time,nlpos.Data,'*b');
plot(lineStates.position.time,lineStates.position.Data,'.-r');
xlabel("Time(s");
ylabel("Position (m)");
legend("Reference Input","Non-linear System", "Linearized System");
title("I don't know what to put in right now, please think of a good title AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
%%
%Deliv 4 velocities
subplot(2,1,1);
plot(nlstates.time,nlstates.Data(:,1),'b');
hold on;
plot(lineStates.states.time,lineStates.states.Data(:,1),'--r');
xlabel("Time(s");
ylabel("Angular Velocity (rad/s)");
title("Pendulum Angular Velocity vs. Time");
legend("Non-linear System", "Linearized System");
subplot(2,1,2);
plot(nlstates.time,nlstates.Data(:,3),'b');
hold on;
plot(lineStates.states.time,lineStates.states.Data(:,3),'--r');
xlabel("Time(s");
ylabel("Velocity (m/s)");
title("Cart Velocity vs. Time");
legend("Non-linear System", "Linearized System");
%%
PendulumCartAnim(nlstates.Data(:,4),nlstates.Data(:,2),nlstates.time,l);