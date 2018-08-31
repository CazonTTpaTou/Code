## 1. Introduction to Functions ##

# Goals scored for entire season 
thunderbirds <- c(4,3,5,1,0,2,4,3,2,2,1,4)
flamethrowers <- c(2,4,6,0,3,4,2,3,3,2,1,0)

thunderbirds_mean <- mean(thunderbirds)
flamethrowers_mean <- mean(flamethrowers)

## 2. Understanding the Components of a Function ##

thunderbirds <- 3
flamethrowers <- 1

get_sum <- function(x,y) {
    x+y
    }

total_goals <- get_sum(thunderbirds,flamethrowers)




## 3. Function Scoping ##

get_sum <- function(x,y){
    x + y
}

print(y)


## 4. Functions Inside of Functions ##

thunderbirds <- c(4,3,5,1,0,2,4,3,2,2,1,4)
flamethrowers <- c(2,4,6,0,3,4,2,3,3,2,1,0)

get_mean <- function(data) {
    sum(data) / length(data)
    }
    
thunderbirds_mean <- get_mean(thunderbirds)

flamethrowers_mean <- get_mean(flamethrowers)


## 5. Writing Your Own Function ##

thunderbirds <- c(4,3,5,1,0,2,4,3,2,2,1,4)
flamethrowers <- c(2,4,6,0,3,4,2,3,3,2,1,0)

get_predictions <- function(team_a,team_b) {
    mean_a <- mean(team_a)
    mean_b <- mean(team_b)
    predictions <- c(mean_a,mean_b)
    return(predictions)
    }

predicted_score <- get_predictions(thunderbirds,flamethrowers)





## 6. Adding Control Structures to our Function ##

thunderbirds <- c(4,3,5,1,0,2,4,3,2,2,1,4)
flamethrowers <- c(2,4,6,0,3,4,2,3,3,2,1,0)

get_predictions <- function(team_a,team_b,name_a,name_b) {
    mean_a <- mean(team_a)
    mean_b <- mean(team_b)
   
    if(mean_a>mean_b) {
        return(name_a)}
    else {return(name_b)}
    }

winner <- get_predictions(thunderbirds,flamethrowers,'thunderbirds','flamethrowers')
