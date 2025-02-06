import math
import matplotlib.pyplot as plt
with open('file.csv','w') as f:
    for val in range(100):
        t=0.1*val
        y=math.sin(2*t)
        f.write('{},{}\n'.format(t,y))
with open('file.csv','r') as f:
    x=[]
    y=[]
    for line in f.readlines():
        line.split(',')
        x_val,y_val=line[:-1].split(',')
        x.append(x_val)
        y.append(y_val)
plt.plot(x, y)

plt.xticks([])
plt.yticks([])
plt.xlabel("Ось X")
plt.ylabel("Ось Y")
plt.title("Простой график")
plt.legend()


plt.show()

