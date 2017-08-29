// Name of Experiment: Adder #20170828185654 v1
// Quantum ripple-carry adder

OPENQASM 2.0;
include "qelib1.inc";

qreg cin[1];
qreg a[4];
qreg b[4];
qreg cout[1];
creg ans[5];
gate majority a,b,c {
cx c,b;
cx c,a;
ccx a,b,c;
}
gate notMajority a,b,c {
ccx a,b,c;
cx c,a;
cx a,b;
}

x a[0]; // a = 0001
x b[0]; // b = 1111
x b[1];
x b[2];
x b[3];
// set input states
majority cin[0],b[0],a[0];
majority a[0],b[1],a[1];
majority a[1],b[2],a[2];
majority a[2],b[3],a[3];
cx a[3],cout[0];
// add a to b, storing result in b
notMajority a[2],b[3],a[3];
notMajority a[1],b[2],a[2];
notMajority a[0],b[1],a[1];
notMajority cin[0],b[0],a[0];
measure b[0] -> ans[0];
measure b[1] -> ans[1];
measure b[2] -> ans[2];
measure b[3] -> ans[3];
measure cout[0] -> ans[4];
