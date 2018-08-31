## 2. Matrix Vector Multiplication ##

matrix_a = np.asarray([[0.7,3,9],
                    [1.7,2,9],
                    [0.7,9,2]])

vector_b = np.asarray([[1],
                      [2],
                      [1]])

ab_product = matrix_a.dot(vector_b)


## 3. Matrix Multiplication ##

matrix_a = np.asarray([
    [0.7, 3],
    [1.7, 2],
    [0.7, 9]
], dtype=np.float32)

matrix_b = np.asarray([
    [113, 3, 10],
    [1, 0, 1],
], dtype=np.float32)

product_ab = matrix_a.dot(matrix_b)

product_ba = matrix_b.dot(matrix_a)



## 4. Matrix Transpose ##

matrix_a = np.asarray([
    [0.7, 3],
    [1.7, 2],
    [0.7, 9]
], dtype=np.float32)

matrix_b = np.asarray([
    [113, 3, 10],
    [1, 0, 1],
], dtype=np.float32)




transpose_a = np.transpose(matrix_a)
print(transpose_a)

print(np.transpose(matrix_a))

trans_ba = np.transpose(matrix_b).dot(transpose_a)

trans_ab = transpose_a.dot(np.transpose(matrix_b))

product_ab = matrix_a.dot(matrix_b)

print(np.transpose(product_ab))

print(trans_ba == product_ab)




## 5. Identity Matrix ##

i_2 = np.asarray([[1,0],
                  [0,1]])
                  
i_3 = np.asarray([[1,0,0],
                  [0,1,0],
                  [0,0,1]])
                  
matrix_33 = np.asarray([[3,5,5],
                      [8,7,6],
                      [5,8,9]])                   
                  
matrix_23 = np.asarray([[1,3,2],                     
                      [4,5,7]])                     
                        
identity_33 = matrix_33.dot(i_3)
                        
identity_23 = np.transpose(matrix_23).dot(i_2)       
                        
                        

## 6. Matrix Inverse ##

matrix_a = np.asarray([
    [1.5, 3],
    [1, 4]
])

def matrix_inverse_two(matrice):
    det = 1/(matrice[0,0]*matrice[1,1]-matrice[0,1]*matrice[1,0])
    mat = np.asarray([[matrice[1,1],matrice[0,1]*(-1)],
                      [matrice[1,0]*(-1),matrice[0,0]]])
    return det * mat

inverse_a = matrix_inverse_two(matrix_a)

print(inverse_a)
    
    

## 7. Solving The Matrix Equation ##

matrix_a = np.asarray([[30,-1],
                       [50,-1]])

matrix_b = np.asarray([[-1000],
                       [-100]])

solution_x = np.linalg.inv(matrix_a).dot(matrix_b)

print(solution_x)





## 8. Determinant For Higher Dimensions ##

matrix_22 = np.asarray([
    [8, 4],
    [4, 2]
])

matrix_33 = np.asarray([
    [1, 1, 1],
    [1, 1, 6],
    [7, 8, 9]
])

det_22 = numpy.linalg.det(matrix_22)

det_33 = numpy.linalg.det(matrix_33)


