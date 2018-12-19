## 1. Introduction ##

df_scores <- read.csv("scores.csv")

## 2. Writing Code for Understanding & Runtime ##

total_goals_per_game <- df_scores$home_goals + df_scores$away_goals

total_goals <- 0
num_games <- 0

for (g in total_goals_per_game){
    total_goals <- total_goals + g
    num_games <- num_games + 1
}

average <- total_goals/num_games

average_goals <- sum(total_goals_per_game) / length(total_goals_per_game)

print(average_goals)

## 3. Introduction to the Apply Family ##

brazil <- list(c(3,1),c(0,0),c(1,4),c(1,1),c(2,1),c(1,7),c(0,3))

total_goals <- lapply(brazil,sum)

## 4. Using lapply with custom functions ##

brazil <- list(c(3,1),c(0,0),c(1,4),c(1,1),c(2,1),c(1,7),c(0,3))

get_result <-function(score) {
    if(score[1]>score[2]) {
        return("Win")}
    if(score[1]==score[2]){
        return("Tie")}
    if(score[1]<score[2]){
        return("Loss")}
    }

match_results <- lapply(brazil,get_result)



## 5. Using sapply over built-in functions ##

england_scores <- list(c(1,2),c(1,2),c(0,0))

england_totals_s <- sapply(england_scores,sum)

england_totals_l <- lapply(england_scores,sum)




## 6. Using sapply over custom functions ##

england_scores <- list(c(1,2),c(1,2),c(0,0))

diff <- function(score) {
    return(abs(score[1]-score[2]))
    }
    
goal_diff <- sapply(england_scores,diff)
    
    

## 7. Using vapply to control returned values ##

england_scores <- list(c(1,2),c(1,2),c(0,0))

total <- vapply(england_scores,sum,as.numeric(1))

## 8. Using tapply on dataframes & matrices ##

home_average <- tapply(df_scores$home_goals,df_scores$home_country,mean)

away_average <- tapply(df_scores$away_goals,df_scores$away_country,mean)