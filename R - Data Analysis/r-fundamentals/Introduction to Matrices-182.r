## 2. Combine Vectors ##

harvard <- c(1,1,1,1,3)
stanford <- c(2,9,3,4,10)
MIT <- c(3,3,2,2,1)
cambridge <- c(4,2,6,13,48)
oxford <- c(5,7,12,9,15)
columbia <- c(6,13,13,12,4)

uni_vector <- c(harvard,stanford,MIT,cambridge,oxford,columbia)



## 3. Creating a Matrix ##

uni_vector <- c(harvard, stanford, MIT, cambridge, oxford, columbia)

uni_matrix <- matrix(uni_vector,nrow=6,ncol=length(harvard),byrow=TRUE)



## 4. Vector & Matrix Data Types ##

columbia_types <- c("columbia",6,13,13,12,4)

type <- class(columbia_types)



## 5. Naming Rows And Columns ##

categories <- c("world_rank","quality_of_education","influence","broad_impact","patents")

universities <- c("Harvard","Stanford","MIT","Cambridge","Oxford","Columbia")

rownames(uni_matrix) <- universities

colnames(uni_matrix) <- categories

named_uni_matrix <- uni_matrix 

## 6. Finding the dimensions of the matrix ##

tuition <- c(43280,45000,45016,49350,28450,55161)

print(dim(uni_matrix))

print(length(tuition))

equality <- (dim(uni_matrix)[1]==length(tuition))

print(equality)


## 7. Creating new columns and rows ##

tuition <- c(43280,45000,45016,49350,28450,55161)

uni_matrix <- cbind(uni_matrix,tuition)



## 8. Subsetting And Indexing A Matrix By Element ##

oxford_influence = uni_matrix[5,3]
stanford_impact = uni_matrix[2,4]
cambridge_patents = uni_matrix[4,5]
MIT_world_rank = uni_matrix[3,1]



## 9. Subsetting a Matrix by Rows & Columns ##

world_rank = uni_matrix[,1]
columbia = uni_matrix[6,]
patents = uni_matrix[,5]



## 10. Sorting a Matrix ##

top_edu <- sort(uni_matrix[,2])
low_cost <- sort(uni_matrix[,6])

## 11. Sorting Then Previewing Data ##

top_edu <- sort(uni_matrix[,"quality_of_education"])
low_cost <- sort(uni_matrix[,"tuition"])

top_two_edu <- head(top_edu,2)

two_low_cost <- head(low_cost,2)

