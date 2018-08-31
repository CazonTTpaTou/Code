import re

texte1 = 'kkdkskksdksdk1925dsdgsd'
texte2 = 'ttt________1945dhdhd--'
texte3 = 'rtyy 1956 ioou kkk'
texte4 = 'r25y 1989 2003 ioou kkk'
texte5 = 'r25y 2015 ioo666666u kkk'

pattern = re.compile("(\\d{4})")

textes = [texte1,texte2,texte3,texte4,texte5]

for text in textes:
    occurence = re.findall('[0-9]{4}',text)
    list_year = list()

    for occ in occurence:
        if int(occ) > 1900 and int(occ) <2020:
            list_year.append(occ)

    release_year = min(list_year)
    
    print(release_year)






    