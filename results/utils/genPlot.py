import matplotlib.pyplot as plt

# Plot data from files
def plotData(title, labels, xLabel, yLabel, x, y):
    for i in range(len(labels)):
        plt.plot(x, y[i], label=labels[i])
    # plt.xscale("log")
    plt.yscale("log")
    plt.xlabel(xLabel)
    plt.ylabel(yLabel)
    plt.title(title)
    plt.legend()
    plt.show()

#---------------------------------------------

# Nro. partidos
x = [  2, 6,  12,  12,  42,  56,  90, 132, 156, 182, 240, 650 ]

# Nro. Variables
y1 = [16, 54,  336, 1456, 3675, 7936, 25000, 43200, 50700, 86240,269824, 1799512]

# Nro. Clauses
y2 = [ 42, 384,17964,  183964,  791627, 1014760, 9412090, 21617412, 28778256, 96570446,  511797424, 7937034612]

labels = ["Nro. Variables", "Nro. Clausulas"]
title = "Nro. Variables vs. Nro. Clausulas"
plotData(title, labels, "Nro. partidos", "Nro. Variables / Clausulas", x, [y1, y2])

#---------------------------------------------
x = [  2, 6,  12,  12,  42,  56,  90, 132, 156, 182]

# Tiempo de traducción
y1 =[ 0.000636453, 0.001411569,  0.01708153, 0.141469222, 0.462121234,  0.66227943, 5.477628295, 15.430484139, 17.033555612, 57.999698434 ]

# Tiempo de solución    
y2 =[0.401567811, 0.401461051,  0.401370745,  0.401517574, 29.662130924,  1.202699169,  2.004433763,  5.229446678,  6.412920708, 109.141499816]

labels = ["Tiempo de traducción", "Tiempo de solución"]
title = "Tiempo de traducción vs. Tiempo de solución"
plotData(title, labels, "Nro. partidos", "Tiempo (s)", x, [y1, y2])
