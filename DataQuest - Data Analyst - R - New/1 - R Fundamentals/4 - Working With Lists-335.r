## 1. Lists: Objects That Can Contain Multiple Data Types ##

uni_clubs <- list("ballroom dancing","rugby","bird watching","pottery")

## 2. Anatomy of a List ##

club_title <- c("Chess Club")
club_description <- c("Meets two nights a week for members to play chess. Snacks are provided.")
club_dues <- c(50, 20, 15)
meeting_days <- c("Monday", "Wednesday")
meeting_times <- c("6:00 pm", "8:00 pm")

club_meetings <- rbind(meeting_days,meeting_times)
chess_club <- list(club_title,club_description,club_dues,club_meetings)

## 3. Assigning Names to List Objects ##

names(chess_club) <- c("club_title","club_description","club_dues","club_meetings")

## 4. Indexing Lists ##

chess_club$club_dues[2]

## 5. Modifying List Elements ##

chess_club$club_dues[3] = 5



## 6. Adding Elements to Lists ##

first_yr <- c(12, 14)
second_yr <- c(3, 1)
third_yr <- c(5, 6)
fourth_yr <- c(2, 2)

member_years_chess <- cbind(first_yr,second_yr,third_yr,fourth_yr)
rownames(member_years_chess) <- c("fall","spring")

chess_club[["member_years_chess"]] <- member_years_chess





## 7. Combining Lists ##

uni_clubs <- list(rugby_club=rugby_club,ballroom_dancing=ballroom_dancing,chess_club=chess_club)