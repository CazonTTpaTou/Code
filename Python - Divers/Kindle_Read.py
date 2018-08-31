import io
import os
import string

Path = 'C:\\Users\\monne\\Desktop'
nameFile = 'Kindle_Text.txt'
separator ='\\'

PathFile = separator.join((Path,nameFile))

row=0
books = []
titleBook = ''
content = []

with io.open(PathFile, mode="r", encoding="utf-8") as f:
    for line in f:
        row+=1
        if row % 5 ==2:
            title=line            
            if title != titleBook:
                book={}
                book['title'] = titleBook
                book['content'] = content
                books.append(book)
                titleBook = title
                content=[]
        if row % 5 ==0:
            content.append(line)

PathDest = 'C:\\Users\\monne\\Desktop\\Extraits'

for extrait in books:        
    name = ' '.join(word.strip(string.punctuation) for word in extrait['title'].split())    
    name = ".".join((name.replace('/','-')[0:32],"txt"))
    nameFile = separator.join((PathDest,name)) 
    texte = " ".join(extrait['content'])
    
    with io.open(nameFile, mode="w", encoding="utf-8") as f: 
        f.write(texte)       
    




