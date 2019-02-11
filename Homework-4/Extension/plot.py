import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
from random import randint

fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111)

x = [1000, 10000, 100000, 1000000]
y1 = [0.000001682, 0.000011308, 0.0001072, 0.001164]
y2 = [0.00004915, 0.000736, 0.00479, 0.05094]

ax.plot(x, y1, marker='', color='olive', linewidth=2, label='C')
ax.plot(x, y2, marker='', color='olive', linewidth=2, linestyle='dashed', label="Ruby")
ax.legend()

plt.xlabel('Length of array')
plt.ylabel('Running time')

fig.savefig('graph.png')

