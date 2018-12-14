## 1. Importing and Modifying Data ##

library(readr)
library(dplyr)
reviews_1 <- read_csv("movie_reviews_2.csv")
reviews_2 <- reviews_1 %>% 
    select(FILM = FILM,
           Rotten_Tomatoes = RT_user_norm,
           Metacritic = Metacritic_user_nom,
           IMDB = IMDB_norm,
           Fandango = Fandango_Ratingvalue)




## 2. Understanding Relationships Between Variables ##

ggplot(data=reviews_2) +
    aes(x=Fandango,
        y=Rotten_Tomatoes) +
    geom_point()



## 3. Creating Informative Scatter Plots ##

# ggplot(data = reviews_2) +
#   aes(x = Fandango, y = Rotten_Tomatoes) +
#   geom_point()

ggplot(data = reviews_2) +
    aes(x=Fandango,
        y=Rotten_Tomatoes)+
    geom_point(alpha=0.3) +
    xlim(1,5) +
    ylim(1,5) +
    theme(panel.background = element_rect(fill="white"))


    

## 4. Creating Multiple Scatter Plots ##

 ggplot(data = reviews_2) +
   aes(x = Fandango, y = IMDB) +
   geom_point(alpha = 0.3) +
   xlim(1,5) +
   ylim(1,5) +
   theme(panel.background = element_rect(fill = "white"))

 ggplot(data = reviews_2) +
   aes(x = Fandango, y = Metacritic) +
   geom_point(alpha = 0.3) +
   xlim(1,5) +
   ylim(1,5) +
   theme(panel.background = element_rect(fill = "white"))

## 5. Write a Function to Create Multiple Scatter Plots ##

graph <- function(x,y) {
ggplot(data = reviews_2) + 
     aes_string(x = x, y = y) +
     geom_point(alpha = 0.3) +
     xlim(1,5) +
     ylim(1,5) +
     theme(panel.background = element_rect(fill = "white"))
    }

x_var <- names(reviews_2)[5]
y_var <- names(reviews_2)[2:4]

map2(x_var,y_var,graph)


