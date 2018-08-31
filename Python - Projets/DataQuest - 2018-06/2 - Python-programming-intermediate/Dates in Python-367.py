## 1. The Time Module ##

import time

current_time = time.time()

print(current_time)

## 2. Converting Timestamps ##

import time

current_time = time.time()

current_struct_time = time.gmtime(current_time)

current_hour = current_struct_time.tm_hour

print(current_hour)



## 3. UTC ##

from datetime import datetime as dt

current_datetime = dt.utcnow()

current_year = current_datetime.year
current_month = current_datetime.month



## 4. Timedelta ##

import datetime
from datetime import datetime as dt

kirks_birthday = dt(year=2233,month=3,day=22)

diff = datetime.timedelta(weeks=15)

before_kirk = kirks_birthday - diff



## 5. Formatting Dates ##

import datetime

formatTime = "%I:%M%p on %A %B %d, %Y"

mystery_date_formatted_string = mystery_date.strftime(formatTime)

print(mystery_date_formatted_string )




## 6. Parsing Dates ##

import datetime

# 12:00AM on Thursday December 31, 2015
formatTime = "%I:%M%p on %A %B %d, %Y"

mystery_date_2  = datetime.datetime.strptime(mystery_date_formatted_string,
                                             formatTime)

print(mystery_date_2)





## 8. Reformatting Our Data ##

import datetime

for post in posts:
    post[2] = datetime.datetime.fromtimestamp(float(post[2]))
    
    

## 9. Counting Posts from March ##

march_count = 0

for post in posts:
    if post[2].month == 3:
        march_count+=1
        
print(march_count)



## 10. Counting Posts from Any Month ##

def count_posts_in_month(number_month):
    march_count = 0
    for row in posts:
        if row[2].month == number_month:
            march_count += 1
    return march_count

feb_count = count_posts_in_month(2)

aug_count = count_posts_in_month(8)


