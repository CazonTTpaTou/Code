## 2. Reading a CSV Files into a Dataframe ##

df <- read.csv('recent-grads.csv')

print(df)




## 3. Previewing the First Few Rows ##

head(df,6)

tail(df,6)



## 4. Examining the Internal Structure ##

str(df)

## 5. Numeric vs. Integer Data Types ##

petro_eng_med_salary <- 110000
finance_med_salary <- 47000

pet_integer <- is.integer(petro_eng_med_salary)
fin_integer <- is.integer(finance_med_salary)

## 6. Representing Categorical Values Using Factors ##

majors <- c('Arts','Biology & Life Science','Business','Computers & Mathematics', 'Engineering',
            'Health','Humanities & Liberal Arts','Psychology & Social Work','Social Science')

factor_majors <- factor(majors)

major_levels <- levels(factor_majors)

## 7. Selecting Data by Rows ##

rank_1_100 <- df[1:100,]

architectural_engineering <- df[19,]

computer_science <- df[21,]


## 8. Selecting Data by Columns ##

select_df <- df[,c('Major','Unemployment_rate','Median','Men','Women')]

## 9. Selecting Specific Values ##

rownames(df) <- df$Major

mech_eng_salary <- df["MECHANICAL ENGINEERING","Median"]

comp_sci_salary <- df["COMPUTER SCIENCE","Median"]

finance_salary <- df["FINANCE","Median"]


## 10. Using Comparison Operators to Filter Values ##

above_50 <- df[df$Median>50000,]
engineering <- df[df$Major_category=='Engineering',]
great_40 <- df[df$ShareWomen>0.4,]



## 11. Combining Conditions using Logical Operators ##

majors <- df[df$Median>50000 & df$ShareWomen > 0.4,]
             
             

## 12. Sorting A DataFrame ##

majors <- df[df$Median >50000 & df$ShareWomen >0.4, ]

major_choice <- majors[order(majors$Unemployment_rate),]

