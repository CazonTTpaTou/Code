## 2. Comparing Object-Oriented to Functional ##

def read(filename):
    with open(filename,'r') as f:
        return [row for row in f.readlines()]
    
def count(liste):
    return len(liste)

example_lines = read('example_log.txt')

lines_count = count(example_lines)


## 4. The Lambda Expression ##

def read(filename):
    with open(filename, 'r') as f:
        return [line for line in f]
    
lines = read('example_log.txt')

sorted_lines = sorted (lines,key=lambda lines:lines.split(' ')[5])

print(sorted_lines)






## 5. The Map Function ##

lines = read('example_log.txt')

ip_addresses = list(map(lambda x:x.split(' ')[0],lines))

print(ip_addresses)






## 6. The Filter Function ##

lines = read('example_log.txt')

ip_addresses = list(map(lambda x:x.split()[0],lines))
filtered_ips = list(filter(lambda x:int(x.split('.')[0])<=20,ip_addresses))

for ip in filtered_ips:
    print(ip)
    
#print(filtered_ips)    



## 7. The Reduce Function ##

from functools import reduce

lines = read('example_log.txt')

addresses_ip = list(map(lambda x:x.split()[0],lines))
filtered_ips = list(filter(lambda x:int(x.split('.')[0])<=20,addresses_ip))

count_lines = reduce(lambda a,_ : 1 if isinstance(a,str) else a + 1,lines)

ips = reduce(lambda x,_ : 1 if isinstance(x,str) else x + 1,filtered_ips)

ratio = ips/count_lines

print(ratio)




## 8. Rewriting with List Comprehension ##

lines = read('example_log.txt')
# Rewrite ip_addresses, and filtered_ips.
# list(map(lambda x: x.split()[0], lines))
# list(filter(lambda x: int(x.split('.')[0]) <= 20, ip_addresses))

ip_addresses = list(row.split()[0] for row in lines)

filtered_ips = list(row.split('.')[0] for row in ip_addresses if int(row.split('.')[0])<=20)

count_all = reduce(lambda x, _: 1 if isinstance(x, str) else x + 1, lines)
count_filtered = reduce(lambda x, _: 1 if isinstance(x, str) else x + 1, filtered_ips)
ratio = count_filtered / count_all
print(ratio)


## 9. Writing Function Partials ##

from functools import partial

lines = read('example_log.txt')

ip_addresses = list(map(lambda x: x.split()[0], lines))

filtered_ips = list(filter(lambda x: int(x.split('.')[0]) <= 20, ip_addresses))

count = partial(
                reduce,
                lambda x,_ : 1 if isinstance(x,str) else x+1)

count_all = count(lines)
count_filtered = count(filtered_ips)

ratio = count_filtered / count_all 

print(ratio)




## 10. Using Functional Composition ##

lines = read('example_log.txt')

ratio = count_filtered / count_all

def adress_ip(lines):
    return list(map(lambda x:x.split()[0],lines))

def filtered_ip(adress_ips):
    return list(filter(lambda x:int(x.split('.')[0])<=20,adress_ips))

reduce_ip = partial(
                    reduce,
                    lambda x,_ : 1 if isinstance(x,str) else x + 1)

composed_ip = compose(
                        adress_ip,
                        filtered_ip,
                        reduce_ip)

counted = composed_ip(lines)

print(counted)


