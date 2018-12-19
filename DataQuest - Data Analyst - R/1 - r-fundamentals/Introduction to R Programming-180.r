## 1. Calculating Grades In R ##

print((90+81+92)/3)

## 2. Performing Multiple Calculations ##

print((84+95+79)/3)

print((95+86+93)/3)



## 3. Performing Calculations using Arithmetic Operators ##

history = (77 + 85 + 90)/3
print(history)

music = (92 + 90 + 91)/3
print(music)

physical_education = (85+88+95)/3
print(physical_education)


## 4. Performing Calculations with Order of Operations ##

expression = 88 - ((88 + 87.66667 + 86 + 91.33333 + 84 + 91 + 89.33333)/7) 

print(expression)





## 5. Creating Comments ##

# We substract the mean of other classes to our result
print(
    88 - ((88 + 87.66667 + 86 + 91.33333 + 84 + 91 + 89.33333)/7) 
)


## 6. Assigning Values to a Variable ##

math <- 88 

# Add your code below
chemistry <- 87.66667
writing <- 86
art <- 91.33333
history <- 84
music <- 91
physical_education <- 89.33333

## 7. Performing Calculations Using Variables ##

math <- 88 
chemistry <- 87.66667
writing <-  86
art <- 91.33333
history <- 84
music <- 91
physical_education <- 89.33333

gpa = (math + chemistry + writing + art + history + music + physical_education)/7

history_difference = history - gpa


## 8. Creating Vectors ##

math <- 88 
chemistry <- 87.66667
writing <-  86
art <- 91.33333
history <- 84
music <- 91
physical_education <- 89.33333

final_scores <- c(math,chemistry,writing,art,history,music,physical_education)

## 9. Calculating the Mean ##

final_scores <- c(math, chemistry, writing, art, history, music, physical_education)

gpa <- mean(final_scores)

## 10. Performing Operations on Vectors ##

final_scores <- c(math, chemistry, writing, art, history, music, physical_education)

highest_score = max(final_scores)

lowest_score = min(final_scores)

num_classes = length(final_scores)


