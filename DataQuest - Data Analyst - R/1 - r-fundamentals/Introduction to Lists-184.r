## 1. Reviewing Our Data Structures ##

companies <- list("boom_tech","car_mechanics","Pineapple.co","slurp_snacks")

## 2. Creating a List of Objects ##

research <- list("Data Analyst",c(74000,60000,80000),"Must have skills with R programming")

## 3. Naming Your List ##

research <- list("Data Analyst", c(74000,60000,80000), "Must have skills with R programming")

names(research) <- c("job_title","salaries","job_requirements")

named_research <- names(research)


## 4. Creating a Named List ##

research <- list("job_title"="Data Analyst", "salaries"=c(74000,60000,80000),"job_requirements"="Must have skills with R programming")



## 5. Adding Values to a List ##

research <- list(job_title = "Data Analyst", salaries = c(74000,60000,80000), job_requirements = "Must have skills with R programming")

research <- c(research,vacation=21)



## 6. Indexing a List ##

research <- list(job_title = "Data Analyst", salaries = c(74000,60000,80000), job_requirements = "Must have skills with R programming")

salaries = research[[2]]

## 7. Changing Values in a List ##

research <- list(job_title = "Data Analyst", salaries = c(74000,60000,80000), job_requirements = "Must have skills with R programming")

research[[1]] = "Jr. Data Scientist"



## 8. Merging Lists ##

research <- list(job_title = "Jr. Data Scientist", salaries = c(74000,60000,80000), job_requirements = "Must have skills with R programming", vacation = 28)

more_research <- list(retirement = "pension", bonus = 10000, commute_time = "30 minutes")

combined <- c(research,more_research)