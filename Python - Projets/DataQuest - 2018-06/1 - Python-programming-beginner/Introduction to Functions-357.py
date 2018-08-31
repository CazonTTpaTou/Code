## 1. Overview ##

f = open('movie_metadata.csv','r')
data=f.read()

rows=data.split('\n')
movie_data=[]

for row in rows:
    movie_data.append(row.split(','))
                      
print(movie_data[:5])
                      
                      

## 3. Writing Our Own Functions ##

def first_elts(data):
    liste=[]
    for movie in data:
        liste.append(movie[0])
    return liste

movie_names=first_elts(movie_data)



## 4. Functions with Multiple Return Paths ##

wonder_woman = ['Wonder Woman','Patty Jenkins','Color',141,'Gal Gadot','English','USA',2017]

def is_usa(name):
    if wonder_woman[0]==name:
        if wonder_woman[6]=='USA':
            return True
        else:
            return False

wonder_woman_usa = is_usa(wonder_woman[0])            

## 5. Functions with Multiple Arguments ##

wonder_woman = ['Wonder Woman','Patty Jenkins','Color',141,'Gal Gadot','English','USA',2017]

def is_usa(input_lst):
    if input_lst[6] == "USA":
        return True
    else:
        return False
    
def index_equals_str(liste,index,string):
    if liste[index]==string:
        return True
    else:
        return False
    
wonder_woman_in_color = index_equals_str(wonder_woman,2,'Color')    



## 6. Optional Arguments ##

def index_equals_str(input_lst,index,input_str):
    if input_lst[index] == input_str:
        return True
    else:
        return False
def counter(input_lst,header_row = False):
    num_elt = 0
    if header_row == True:
        input_lst = input_lst[1:len(input_lst)]
    for each in input_lst:
        num_elt = num_elt + 1
    return num_elt

us_movies = []

for movie in movie_data:
    if index_equals_str(movie,6,'USA'):
        us_movies.append(movie[0])

num_of_us_movies = counter(us_movies)        

## 7. Calling a Function inside another Function ##

def feature_counter(input_lst,index, input_str, header_row = False):
    num_elt = 0
    if header_row == True:
        input_lst = input_lst[1:len(input_lst)]
    for each in input_lst:
        if each[index] == input_str:
            num_elt = num_elt + 1
    return num_elt

def summary_statistics(liste):
    dictionnaire = {}
    dictionnaire['japan_films']=feature_counter(liste,6,'Japan',True)
    dictionnaire['color_films']=feature_counter(liste,2,'Color',True)
    dictionnaire['films_in_english']=feature_counter(liste,5,'English',True)
    return dictionnaire

summary=summary_statistics(movie_data)

