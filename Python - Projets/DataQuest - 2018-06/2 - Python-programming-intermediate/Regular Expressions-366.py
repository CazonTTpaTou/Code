## 1. Introduction ##

strings = ["data science", "big data", "metadata"]
regex = "data"

## 2. Wildcards in Regular Expressions ##

strings = ["bat", "robotics", "megabyte"]
regex = "b.t"

## 3. Searching the Beginnings And Endings Of Strings ##

strings = ["better not put too much", "butter in the", "batter"]
bad_string = "We also wouldn't want it to be bitter"
regex = "^b.tter"

## 5. Reading and Printing the Data Set ##

import csv

with open("askreddit_2015.csv","r") as f:
          posts_with_header = list(csv.reader(f))
          
posts = posts_with_header[1:]

for index,post in enumerate(posts):
          if index<10:
            print(post)
          

## 6. Counting Simple Matches in the Data Set with re() ##

import re

of_reddit_count = 0
text_search = "of Reddit"

for post in posts:
    if re.search(text_search,post[0]):
        of_reddit_count += 1

print(of_reddit_count)



## 7. Using Square Brackets to Match Multiple Characters ##

import re

of_reddit_count = 0
text_search = "of [Rr]eddit"

of_reddit_count_old = 0
for row in posts:
    if re.search(text_search, row[0]) is not None:
        of_reddit_count += 1
        
        

## 8. Escaping Special Characters ##

import re

#text_search = "\[[Ss]erious\]"
text_search = "\[Serious\]"

serious_count = 0

for post in posts:
    if re.search(text_search,post[0]):
        serious_count += 1
        
print(serious_count)



## 9. Combining Escaped Characters and Multiple Matches ##

import re

serious_count = 0
for row in posts:
    if re.search("\[[Ss]erious\]", row[0]) is not None:
        serious_count += 1

## 10. Adding More Complexity to Your Regular Expression ##

import re

text_search="[\[(][Ss]erious[\])]"

serious_count = 0
for row in posts:
    if re.search(text_search, row[0]) is not None:
        serious_count += 1

## 11. Combining Multiple Regular Expressions ##

import re

serious_start_count = 0
serious_end_count = 0
serious_count_final = 0

for post in posts:
    if re.search("^[\[(][Ss]erious[\])]",post[0]) is not None:
        serious_start_count+=1
        
    if re.search("[\[(][Ss]erious[\])]$",post[0]) is not None:
        serious_end_count+=1
        
    if re.search("^[\[\(][Ss]erious[\]\)]|[\[\(][Ss]erious[\]\)]$",post[0]) is not None:
        serious_count_final+=1        




## 12. Using Regular Expressions to Substitute Strings ##

import re

pattern = "^[\[\(][Ss]erious[\]\)]|[\[\(][Ss]erious[\]\)]$"
replace = "[Serious]"

for post in posts:
    post[0] = re.sub(pattern,replace,post[0])
    
    
    
    



    

## 13. Matching Years with Regular Expressions ##

import re

year_strings = []

pattern="[1-2][0-9][0-9][0-9]"

for year in strings:
    if re.search(pattern,year) is not None:
        year_strings.append(year)
        
print(year_strings)



## 14. Repeating Characters in Regular Expressions ##

import re

year_strings = []

pattern="[1-2][0-9]{3}"

for year in strings:
    if re.search(pattern,year) is not None:
        year_strings.append(year)
        
print(year_strings)





## 15. Challenge: Extracting all Years ##

import re

pattern = "[1-2][0-9]{3}"

years = re.findall(pattern,years_string)