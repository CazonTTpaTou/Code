## 3. Read the File Into a String ##

f=open('dq_unisex_names.csv','r')
names = f.read()

## 4. Convert the String to a List ##

f = open('dq_unisex_names.csv', 'r')
names = f.read()

names_list = names.split('\n')
first_five = names_list[:5]
print(first_five)

## 5. Convert the List of Strings to a List of Lists ##

f = open('dq_unisex_names.csv', 'r')
names = f.read()
names_list = names.split('\n')

nested_list=[]

for names in names_list:
    nested_list.append(names.split(','))

print(nested_list[:5])


## 6. Convert Numerical Values ##

print(nested_list[0:5])

numerical_list = []

for nest in nested_list:
    numerical_list.append([nest[0],float(nest[1])])

                           

## 7. Filter the List ##

# The last value is ~100 people
numerical_list[len(numerical_list)-1]

thousand_or_greater = []

for num in numerical_list:
    if num[1]>=1000:
        thousand_or_greater.append(num[0])

print(thousand_or_greater[:10])
