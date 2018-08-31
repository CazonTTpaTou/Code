
# coding: utf-8

# # Analyse avec pandas

# ## ndarray

# In[1]:


import numpy as np
data = [1,2,3,4,5,6]
dt = np.array(data)
dt


# In[3]:


data2 = [[1,2,3,4,5,6],[7,8,9,10,11,12]]
dt2 = np.array(data2)
dt2


# In[6]:


dt3 = np.arange(16)
dt3


# In[8]:


dt4 = np.identity(4)
dt4


# In[10]:


dt3.astype(np.float64)
dt3


# In[12]:


dt5 = dt2.astype(dt3.dtype)
dt5


# ## Indexation

# In[14]:


dt6=dt3[0:3]
dt6


# In[15]:


dt6 = 35
dt6


# In[16]:


dt3


# In[17]:


dt3_slice = dt3[0:3]
dt3_slice[0] = 35
dt3


# In[20]:


dt7 = dt3[0:3].copy()
dt7


# In[3]:


arr3d = np.array([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]])
arr3d


# In[6]:


arr3d[0]


# In[7]:


arr3d[0][1]


# In[13]:


arr3d[:1,:1,:2]


# In[14]:


arr3d[:,:1]


# ## indexation booléenne

# In[20]:


names = np.array(['bob','joe','will','bob','will','joe','joe'])
data = np.random.randn(7,4)
data


# In[18]:


names == 'bob'


# In[22]:


data[names=='bob']


# In[21]:


data[names=='bob',3]


# In[25]:


mask = (names=='bob') | (names=='will')
mask = (names=='bob') & (names=='will')
mask = (names!='bob') & (names!='will')


# In[26]:


data[mask]


# In[28]:


data[data<0]=0
data


# ## Fancy indexing

# In[33]:


arr = np.empty((8,4))
for i in range(8):
    arr[i]=i
arr


# In[32]:


arr[[4,3,0,6]]


# In[36]:


arr[[1,5,7,2],[0,3,1,2]]


# In[42]:


arr = np.arange(32).reshape((8,4))
arr


# In[41]:


arr[np.ix_([1,5,7,2],[0,3,1,2])]


# ## Transposition

# In[43]:


arr = np.arange(15).reshape(3,5)
arr


# In[44]:


arr.T


# In[45]:


np.dot(arr.T,arr)


# In[46]:


np.dot(arr,arr.T)


# In[48]:


arr.swapaxes(0,1)


# ## Fonctions rapides

# In[53]:


x= np.random.randn(8)
y= np.random.randn(8)
x


# In[54]:


y


# In[56]:


m = np.maximum(x,y)
m


# In[58]:


arr = np.random.randn(7)*5
arr


# In[59]:


np.modf(arr)


# In[61]:


arr = np.arange(10)
arr


# In[69]:


a = np.arange(10)
b = np.random.randn(10)

s = np.add(a,b)
ss = np.subtract(a,b)
sm = np.multiply(a,b)
dm = np.divide(a,b)
mo = np.mod(b,a+1)
gr = np.greater(a,b)
#xo = np.logical_xor(a,b)


# ## Vectorisation

# In[70]:


points = np.arange(-5,5,0.001)
xs,ys = np.meshgrid(points,points)
z = np.sqrt(xs**2+ys**2)
z


# In[72]:


import matplotlib.pyplot as plt
plt.imshow(z,cmap=plt.cm.gray);plt.colorbar()
plt.show()


# In[74]:


xarr = np.random.randn(10)
yarr = np.random.randn(10)
cond = np.array([True,False,True,False,True,False,True,False,True,False])
result = [(x if c else y) for x,y,c in zip(xarr,yarr,cond)]
result


# In[75]:


np.where(cond,xarr,yarr)


# In[79]:


np.where(np.array(result)<0,-1,result)


# In[81]:


sommeCumulLigne = z.cumsum(0)
produitCumulColonne = z.cumprod(1)
nombreValPositives = (z > 0).sum()
nombreValPositives


# In[82]:


bools = np.array([False,True,False,True])
bools.any()
bools.all()


# ## Trier

# In[85]:


arr = np.random.randn(4,4)
arr


# In[87]:


arr.sort()
arr


# In[90]:


arri = np.random.randn(4,3)
arri


# In[93]:


arri.sort(0)
arri


# In[95]:


tab = np.random.randn(4,4)
tri_ligne = np.sort(tab,0)
tri_ligne


# In[97]:


tri_colonne = np.sort(tab,1)
tri_colonne


# In[98]:


large_arr = np.random.randn(100)
centile_5 = large_arr[int(0.05*len(large_arr))]
centile_5


# ## Logique ensembliste

# In[100]:


liste = [0,1,2,0,1,2,3]
np.unique(liste)


# In[101]:


part1 = np.arange(0,10)
part2 = np.arange(5,15)
part1


# In[102]:


part2


# In[104]:


np.intersect1d(part1,part2)


# In[105]:


np.union1d(part1,part2)


# In[106]:


np.in1d(part1,part2)


# In[108]:


np.setdiff1d(part1,part2)


# In[109]:


np.setxor1d(part1,part2)


# ## Entrée - sortie

# In[110]:


arr = np.arange(10)
np.save('some_array',arr)


# In[112]:


np.load('some_array.npy')


# ## Algèbre linéaire

# In[115]:


from numpy.linalg import inv,qr,eig,solve,det
X = np.random.randn(5,5)
mat = X.T.dot(X)
inv(mat)


# In[114]:


mat.dot(inv(mat))


# In[118]:


valeurs_propres = eig(X)
valeurs_propres[0]


# In[119]:


determinant = det(X)
determinant


# In[120]:


A = [[1,2],[3,7]]
B = [5,15]
solve(A,B)


# ## Nombre aléatoire

# In[121]:


from random import normalvariate
N = 100000
get_ipython().run_line_magic('timeit', 'samples = [normalvariate(0,1) for _ in range(N)]')
get_ipython().run_line_magic('timeit', 'np.random.normal(size=N)')


# In[122]:


bin = np.random.binomial(100,0.7)
bin


# In[123]:


normal_0_1 = np.random.randn(20)
normal_0_1


# In[124]:


uniforme = np.random.rand(10)
uniforme


# In[135]:


entiers = np.random.randint(2,15,(2,3,2))
entiers


# In[150]:


per = np.random.permutation(5)
per


# In[154]:


L = ['a','b','c','d','e','f']
s = np.random.shuffle(L)


# In[156]:


gamma = np.random.gamma(np.arange(0,10))
gamma


# In[183]:


import matplotlib.pyplot as plt

position = 0
walk = [position]
steps = 100

for i in range(steps):
    if np.random.randint(0,2):
        step=1 
    else: 
        step=-1
    position += step
    walk.append(position)

plt.plot(np.arange(steps+1),walk)
plt.show()


# In[185]:


draws = np.random.randint(0,2,size=100)
steps = np.where(draws>0,1,-1)
walk = steps.cumsum()

plt.plot(np.arange(100),walk,color='red')
plt.show()


# In[186]:


## first crossing time
# valeur pour laquelle on dépasse 10 en valeur absolue...
(np.abs(walk) >=10).argmax()

