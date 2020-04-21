%constants
M=2;
m=0.5;
l=1;
g=9.81;

A=[0 (M+m)*g/(M*l) 0 0;1 0 0 0;0 -m*g/M 0 0;0 0 1 0];
B=[-1/(M*l); 0; 1/M; 0];
b=B;
C=[0 0 0 1];
D=[0];
ts=2;
os=.0432;
zeta=(-log(os)/pi)/sqrt(1+(log(os)/pi)^2);
wn=4/(zeta*ts);
chareq2des=[1 2*wn*zeta wn*wn];
zeroRemove=conv([1 3.1321],[1 wn]);
phi=roots(conv(zeroRemove,chareq2des));
K=acker(A,B,phi);
[numCL,denCL]=ss2tf(A-B*K,B,C,D);
cltf=tf(numCL,denCL);
calGain=1/dcgain(cltf);
x_dot_0=0;
x_0=0;
theta_0=0;
theta_dot_0=0;
F=0;%
%%
sim('PendulumCart_Block.slx', 0:.1:12);
sim('tpSimul.slx',0:.1:12);
max(nlpos.Data)
plot(nlpos.time,nlpos.Data);
%plot(out.position.time,out.position.Data);
hold on;
plot(t,maxy)
plot(t,min);
plot(grabbadabbah,grubba);
plot(t,over);
%figure(2);
%plot(nlstates.time,nlstates.Data(:,2));