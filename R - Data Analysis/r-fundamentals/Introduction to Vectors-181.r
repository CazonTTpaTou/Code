## 1. Indexing a Vector By Position ##

final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)

third <- final_scores[3]

print(third)



## 2. Understanding Numeric Data Types ##

final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)

class(final_scores)

## 3. Understanding Character Data Types ##

class_names <- c("math", "chemistry", "writing", "art", "history", "music", "physical_education")
type <- class(class_names)

## 4. Naming Values ##

class_names <- c("math", "chemistry", "writing", "art", "history", "music", "physical_education")
final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)

names(final_scores) <- class_names

named_final_scores <- final_scores


## 5. Indexing Vectors using Names ##

class_names <- c("math", "chemistry", "writing", "art", "history", "music", "physical_education")
final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)
names(final_scores) <- class_names

history = final_scores["history"]
art = final_scores["art"]
music = final_scores["music"]


## 6. Comparing Values And Logical Data Types ##

class_names <- c("math", "chemistry", "writing", "art", "history", "music", "physical_education")
final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)
names(final_scores) <- class_names

history_math <-  final_scores["history"] > final_scores["math"]

writing_art <- final_scores["writing"] <= final_scores["art"]

music_chem <- final_scores["music"] == final_scores["chemistry"]




## 7. Comparing Single Values against Vectors ##

class_names <- c("math", "chemistry", "writing", "art", "history", "music", "physical_education")
final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)
names(final_scores) <- class_names

lowest_score <- min(final_scores)

lowest_logical <- (lowest_score == final_scores)

## 8. Indexing using Logical Data Types ##

class_names <- c("math", "chemistry", "writing", "art", "history", "music", "physical_education")
final_scores <- c(88, 87.66667, 86, 91.33333, 84, 91, 89.33333)
names(final_scores) <- class_names

lowest_score <- min(final_scores)
lowest_logical <- lowest_score == final_scores

lowest_class <- final_scores[lowest_logical]



## 9. Performing Arithmetic with a Vector ##

tests <- c(76, 89, 78, 88, 79, 93, 89)
homework <- c(85, 90, 88, 79, 88, 95, 74)
sum <- tests + homework

projects <- c(77, 93, 87, 90, 77, 82, 80)

johnny_scores <- (sum + projects)/3

johnny_overall <- mean(johnny_scores)



## 10. Vector Recycling Rule ##

tests <- c(76, 89, 78)
homework <- c(85, 90, 88, 79, 88, 95, 74)

projects <- c(77, 93, 87, 90, 77, 82, 80)

recycling <- tests + homework

print(recycling)



## 11. Appending Data To A Vector ##

tests <- c(76, 89, 78)

tests <- c(tests, 88, 79, 93, 89)