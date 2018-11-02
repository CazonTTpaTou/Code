# Finobacci Suite
def Finobacci(n):
    if n<=0 :
        return 0
    if n==1 :
        return 1
    return Finobacci(n-1) + Finobacci(n-2)

def SuiteFinobacci(number):
    return '-'.join(str(Finobacci(n)) for n in range(number))

print(SuiteFinobacci(10))   

# Jupyter MatplotLib

from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
from plotly.graph_objs import Scatter, Figure, Layout

# Display a graph with some numbers
iplot([{"x": [1, 2, 3, 4, 5, 6, 7, 8], "y": [0, 1, 1, 2, 2, 3, 3, 4]}]) 






