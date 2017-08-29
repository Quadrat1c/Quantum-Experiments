// quantum entanglement experiment
include "qelib1.inc";
qreg a[4];
qreg b[4];
creg c[4];
creg d[4];

h a[0];
h a[1];
h a[2];
h a[3];
cx a[0],b[0];
cx a[1],b[1];
cx a[2],b[2];
cx a[3],b[3];
barrier a[0],a[1],a[2],a[3];
barrier b[0],b[1],b[2],b[3];
measure a[0] -> c[0];
measure a[1] -> c[1];
measure a[2] -> c[2];
measure a[3] -> c[3];
measure b[0] -> d[0];
measure b[1] -> d[1];
measure b[2] -> d[2];
measure b[3] -> d[3];
