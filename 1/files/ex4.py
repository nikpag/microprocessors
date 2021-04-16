import matplotlib.pyplot as plt;
import numpy as np;

Design = np.array([20e3, 10e3, 100e3, 200e3]);
IC = np.array([10, 30, 2, 1]);
Assembly = np.array([10, 10, 2, 1]);
x = np.arange(1,1,100000);

plt.figure(1);

Total = [1,2,3,4];
for i in range(4):
  Total[i] = Design[i] + (IC[i]+Assembly[i])*x;
  plt.plot(x,Total[i],linewidth=1);

plt.grid();
plt.xlim([1,55000]);
plt.ylim([1,2000000]);

plt.show();

plt.savefig("ex4totalpython.png");

plt.figure(2);

PerUnit = [1,2,3,4];
for i in range(4):
  PerUnit[i] = Design[i]/x + (IC[i]+Assembly[i]);
  plt.plot(x,PerUnit[i],linewidth=2);

plt.grid();
plt.ylim([0,1000]);

plt.show();

plt.savefig("ex4perunitpython.png");