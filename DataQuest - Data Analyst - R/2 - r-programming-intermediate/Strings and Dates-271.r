## 1. Introduction ##

df <- read.csv("scores.csv")

head(df)



## 2. Concatenating Strings ##

head(df)

add_2014 <- paste(df$match_date,'-2014',sep=' ')




## 3. Updating a Column in a Dataframe ##

paste(df$match_date, "-2014")

df$match_date <- paste(df$match_date,"-2014")

update_2014 <- df$match_date



## 4. Extracting a Substring ##

extract_date <- function(date) {
    return(substr(date,4,length(date)))
    }

months_ <- tapply(df$match_date,df$match_date,extract_date)

months <- substr(df$match_date,3,8)



## 5. Splitting a String ##

match_date <- df$match_date

match_date <- as.character(match_date)

date_split <- strsplit(match_date,split=" ")




## 6. Replacing a Value in a String ##

df$match_date <- sub('June','-06',df$match_date)

df$match_date <- sub('July','-07',df$match_date)

updated_dates <- df$match_date



## 7. Removing the Whitespaces from our String ##

remove_space <- gsub(" ","",df$match_date)



## 8. Converting a String into a Date Format ##

date_convert <- as.Date(df$match_date,format='%d-%m-%Y')



## 9. Extracting Parts of the Date ##

pos_obj <- as.POSIXlt(df$match_date)

## 10. Extracting Values from our date column ##

dayofweek <- df$match_date$wday

## 11. Creating a new column in our dataframe ##

dayofweek <- df$match_date$wday

df$dayofwwek <- dayofweek



## 12. Building your own news headline generator ##

df$month <- sub(5,"June",df$match_date$mon)

df$month <- sub(6,"July",df$month)

headline <- paste("On",df$month,paste(df$match_date$mday,"th,",sep=""),df$win_country,'won the match',paste(df$home_goals,df$away_goals,sep='-'),sep=' ')



