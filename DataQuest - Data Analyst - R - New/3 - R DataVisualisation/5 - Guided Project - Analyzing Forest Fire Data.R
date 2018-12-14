library(readr)

fire_file <- read.csv("E:/OneDrive/Formation/2018 - DataQuest/Path - Data Analyst - R - New/3 - R DataVisualisation/Data/forestfires.csv")

library(ggplot2)
library(stats)
library(dplyr)

df_month <- fire_file %>%
  group_by(month) %>%
  summarize(number=n()) %>%
  arrange(desc(number))

df_day <- fire_file %>%
  group_by(day) %>%
  summarize(number=n()) %>%
  arrange(desc(number))

ggplot(data=df_month) +
  aes(x=reorder(month,number),
      y=number) +
  geom_bar(stat = 'identity')

ggplot(data=df_day) +
  aes(x=reorder(day,-number),
      y=number) +
  geom_bar(stat = 'identity') +
  coord_flip()

forest_fires <- df_month %>%
  mutate(month=factor(month,levels=c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")))

ggplot(data=forest_fires) +
  aes(x=month,
      y=number)+
  geom_bar(stat = 'identity')

forest_fires_day <- df_day %>%
  mutate(day=factor(day,levels=c("mon","tue","wed","thu","fri","sat","sun")))

ggplot(data=forest_fires_day) +
  aes(x=day,
      y=number) +
  geom_bar(stat='identity') +
  coord_flip()

boxplot_day <- function(x,y) {
  ggplot(data=fire_file) + 
    aes_string(x=x,
               y=y) +
    geom_boxplot()
}

measures <- c('FFMC','DMC','DC','ISI','temp','RH','wind','rain')
axis <- 'day'
axis2 <- 'month'

library(purrr)
map2(axis,measures,boxplot_day)

fire_file_2 <- fire_file %>%
  mutate(month=factor(month,levels=c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")))

boxplot_month <- function(x,y) {
  ggplot(data=fire_file_2) + 
    aes_string(x=x,
               y=y) +
    geom_boxplot()
}

map2(axis2,measures,boxplot_month)

scatter_plot <- function(x,y) {
  ggplot(data=fire_file) +
    aes_string(x=x,
               y=y) +
    geom_point() +
    labs(title="Correlations between measures")
}

point_x <- 'area'
measures <- c('FFMC','DMC','DC','ISI','temp','RH','wind','rain')

map2(point_x,measures,scatter_plot)

fire_file_filtered <- fire_file %>%
  filter(area > 0 & area<= 150)

scatter_plot <- function(x,y) {
  ggplot(data=fire_file_filtered) +
    aes_string(x=x,
               y=y) +
    geom_point() +
    labs(title="Correlations between measures")
}

map2(measures,point_x,scatter_plot)

ggplot(data=fire_file_filtered) +
  aes(x=area) +
  geom_histogram(bins=10) +
  labs(title="Distribution of variable Area")

ggplot(data=fire_file_filtered) +
  aes(x=area) +
  geom_histogram(bins=15) +
  labs(title="Distribution of variable Area")




