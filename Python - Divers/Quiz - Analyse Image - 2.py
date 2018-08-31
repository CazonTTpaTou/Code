import numpy as np

matrice_X = np.array([[0,0,0,0,0],[0,0,0,0,0],[0,0,1,0,0],[0,0,0,0,0],[0,0,0,0,0]])
matrice_H = np.array([[1,2,3],[4,5,6],[7,8,9]])

dim_U = np.arange(-2,3,1)
dim_V = np.arange(-2,3,1)

def Cross_Correlation(X,H,U,V,i,j):
    Pixel = 0

    for u in U:
        for v in V:

            if int(i-u)>4:
                i_moins_u = 0
            else:
                i_moins_u = int(i-u)

            if int(j-v)>4:
                j_moins_v = 0
            else:
                j_moins_v = int(j-v)
            """
            print('----------------')
            print('u=',u)
            print('v=',v)
            print(H[int(u),int(v)])

            print(X[i_plus_u,j_plus_v])
            """
            Pixel=(Pixel
                  +H[int(u),int(v)]
                  *X[i_moins_u,j_moins_v])

    return Pixel

matrice_Y = np.zeros((5,5))

for (i,j), value in np.ndenumerate(matrice_Y):
    matrice_Y[(i,j)]=Cross_Correlation(matrice_X,
                                        matrice_H,
                                        dim_U,
                                        dim_V,
                                        i,
                                        j)

print(matrice_Y)


"""

print(matrice_X)
print(matrice_H)
print(dim_U)
print(dim_V)

print(matrice_X[1,2])
print(matrice_X[3,3])

print(Cross_Correlation(matrice_X,
                        matrice_H,
                        dim_U,
                        dim_V)) 

"""







