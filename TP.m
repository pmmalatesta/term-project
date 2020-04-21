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
phi=roots([1 2.1*wn 3.4*wn*wn 2.7*wn*wn*wn wn*wn*wn*wn]);
chareq2=[1 2*wn*zeta wn*wn]
K=acker(A,B,phi);
[numCL,denCL]=ss2tf(A-B*K,B,C,D);
cltf=tf(numCL,denCL);
calGain=1/dcgain(cltf);
x_dot_0=0;
x_0=0;
theta_0=0;
theta_dot_0=0;
F=0;%
sim('PendulumCart_Block.slx', 0:.1:12)
