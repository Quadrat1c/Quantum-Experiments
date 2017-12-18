// Unconfirmed Tele and Duplication?
include "qelib1.inc";

qreg q[5];
creg c[5];
u3(0.3, 0.2, 0.1) q[0];
h q[1];
cx q[1],q[2];
h q[0];
measure q[0] -> c[0];
measure q[1] -> c[1];
z q[2];
x q[2];
measure q[2] -> c[2];
