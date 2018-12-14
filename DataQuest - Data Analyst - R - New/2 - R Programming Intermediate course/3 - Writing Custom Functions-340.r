## 1. Introduction to Writing Your Own Functions ##

library(readr)
scores <- read_csv("scores.csv")

## 2. Anatomy of a Function ##

multiply_100 <- function(x) {
    x * 100
    }

away_by_100 <- multiply_100(scores$away_goals)



## 3. When to Write a Function ##

compute_ratio <- function(x) {
    x/sum(x) * 100
    }

home_goals_percentage <- compute_ratio(scores$home_goals)
away_goals_percentage <- compute_ratio(scores$away_goals)



## 4. Writing Functions with Two Variables as Arguments ##

total_goals <- function(x,y) {
    (x / (x + y)) * 100
    }

home_percent <- total_goals(scores$home_goals,scores$away_goals)



## 5. Writing Functions for Conditional Execution ##

ratio_goals <- function(x,y) {
    if(x+y>0) {
        (x / (x+y)) * 100
        } else {
                0
        }
    }

ratio_goals(x=scores$away_goals[15],y=scores$home_goals[15])




## 6. Functions with More Than Two Arguments ##

multi <- function(x,y,z) {
    if (z >= 5 & z <= 10) {
        x * 2
        } else {
            y - 1}
    }

multi(x=scores$home_goals[1],
      y=scores$away_goals[1],
      z=scores$match_id[1])

