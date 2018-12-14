## 2. Importing the Data ##

library(readr)

scores <- read_csv("scores.csv")

## 3. Selection: Writing Conditional Statements ##

if (scores$home_goals[3] > scores$away_goals[3]) {print("home team won")} else {print("home team did not win")}

## 4. Repetition: Writing For-Loops ##

for (country in scores$home_country) {
    print(country)
    }

## 5. Looping Over Rows of a Data Frame ##

for (i in 1:nrow(scores)) {
    print(scores$away_goals - scores$home_goals)
    }



## 6. Nested Control Structures ##

for (i in 1:nrow(scores)) {
    print(scores$home_goals[i] > scores$away_goals[i])
    }

## 7. Storing For-Loop Output in Objects ##

home_team_won <- c()

for (i in nrow(scores)) {
    home_team_won <- c(home_team_won,scores$home_goals > scores$away_goals)
    }



## 8. More Than Two Cases ##

if (scores$home_goals[3] > scores$away_goals[3]) {print("win")} else if (scores$away_goals[3] > scores$home_goals[3]) {print("lose")}  else {print("tie")}



## 9. More Than Two Cases: Writing a For-Loop ##

home_team_result <- c()

for (i in 1:nrow(scores)) {
    if (scores$home_goals[i] >  scores$away_goals[i]) {
        home_team_result <- c(home_team_result,"win")
        } else if (scores$home_goals[i] <  scores$away_goals[i]) {
            home_team_result <- c(home_team_result,"lose")
        } else {home_team_result <- c(home_team_result,"tie")}
    }

scores <- scores %>% mutate(home_team_result)    
