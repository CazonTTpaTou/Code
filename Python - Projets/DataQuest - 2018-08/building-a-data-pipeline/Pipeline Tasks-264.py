## 2. Generators in Python ##

def squares(N):
    i=-1
    while True:
        i+=1
        if i>N:
            raise StopIteration
        yield i*i

squared_values = [value for value in squares(20)]



















## 4. Manipulating Generators in Tasks ##

log = open('example_log.txt')
def parse_log(log):
    for line in log:
        split_line = line.split()
        remote_addr = split_line[0]
        time_local = split_line[3] + " " + split_line[4]
        request_type = split_line[5]
        request_path = split_line[6]
        status = split_line[8]
        body_bytes_sent = split_line[9]
        http_referrer = split_line[10]
        http_user_agent = " ".join(split_line[11:])
        yield (
            remote_addr, time_local, request_type, request_path,
            status, body_bytes_sent, http_referrer, http_user_agent
        )

first_line = next(parse_log(log))

## 5. Data Cleaning in Parse Log ##

log = open('example_log.txt')

def parse_log(log):
    for line in log:
        split_line = line.split()
        remote_addr = split_line[0]
        time_local_raw = split_line[3] + " " + split_line[4]
        time_local = parse_time(time_local_raw)
        
        request_type = strip_quotes(split_line[5])
        request_path = split_line[6]
        status = int(split_line[8])
        body_bytes_sent = int(split_line[9])
        http_referrer = strip_quotes(split_line[10])
        http_user_agent = strip_quotes(" ".join(split_line[11:]))
        
        yield (
            remote_addr, time_local, request_type, request_path,
            status, body_bytes_sent, http_referrer, http_user_agent
        )
        
first_line = next(parse_log(log))




## 6. Write to CSV ##

import csv

log = open('example_log.txt')
parsed = parse_log(log)
def build_csv(lines, header=None, file=None):
    if header:
        lines = [header] + [l for l in lines]
    writer = csv.writer(file, delimiter=',')
    writer.writerows(lines)
    file.seek(0)
    return file

file = open('temporary.csv', 'r+')
csv_file = build_csv(
    parsed,
    header=[
        'ip', 'time_local', 'request_type',
        'request_path', 'status', 'bytes_sent',
        'http_referrer', 'http_user_agent'
    ],
    file=file
)
    
contents = csv_file.readlines()
print(contents[:5])

## 7. Chaining Iterators ##

import csv

log = open('example_log.txt')
parsed = parse_log(log)

def build_csv(lines, header=None, file=None):
    # if header:
    #    lines = [header] + [l for l in lines]
    writer = csv.writer(file, delimiter=',')
    writer.writerows(lines)
    file.seek(0)
    return file

file = open('temporary.csv', 'r+')
csv_file = build_csv(
    parsed,
    header=[
        'ip', 'time_local', 'request_type',
        'request_path', 'status', 'bytes_sent',
        'http_referrer', 'http_user_agent'
    ],
    file=file
)
    
contents = csv_file.readlines()
import itertools

def build_csv(lines, header=None, file=None):
    if header:
        lines = itertools.chain([header], lines)
    writer = csv.writer(file, delimiter=',')
    writer.writerows(lines)
    file.seek(0)
    return file

file = open('temporary.csv', 'r+')
csv_file = build_csv(
    parsed,
    header=[
        'ip', 'time_local', 'request_type',
        'request_path', 'status', 'bytes_sent',
        'http_referrer', 'http_user_agent'
    ],
    file=file
)

contents = csv_file.readlines()
print(contents[:5])

## 8. Counting Unique Request Types ##

import csv

log = open('example_log.txt')
parsed = parse_log(log)
file = open('temporary.csv', 'r+')
csv_file = build_csv(
    parsed,
    header=[
        'ip', 'time_local', 'request_type',
        'request_path', 'status', 'bytes_sent',
        'http_referrer', 'http_user_agent'
    ],
    file=file
)

def count_unique_requests(file):
    count_request_type = dict()
    next(file)
    
    for line in file.readlines():
        request_type = line.split(',')[2]
        if request_type in count_request_type.keys():
            count_request_type[request_type]+=1
        else:
            count_request_type[request_type]=1
       
    return count_request_type

uniques = count_unique_requests(csv_file)
            
print(uniques)            
        
    
    
    

## 9. Task Reusability ##

import csv

def count_unique_request(csv_file):
    reader = csv.reader(csv_file)
    header = next(reader)
    idx = header.index('request_type')
    
    uniques = {}
    for line in reader:
        
        if not uniques.get(line[idx]):
            uniques[line[idx]] = 0
        uniques[line[idx]] += 1
    return uniques


log = open('example_log.txt')
parsed = parse_log(log)
file = open('temporary.csv', 'r+')
csv_file = build_csv(
    parsed,
    header=[
        'ip', 'time_local', 'request_type',
        'request_path', 'status', 'bytes_sent',
        'http_referrer', 'http_user_agent'
    ],
    file=file
)
uniques = count_unique_request(csv_file)
def count_unique_request(csv_file):
    reader = csv.reader(csv_file)
    header = next(reader)
    idx = header.index('request_type')
    
    uniques = {}
    for line in reader:
        
        if not uniques.get(line[idx]):
            uniques[line[idx]] = 0
        uniques[line[idx]] += 1
    return ((k, v) for k,v in uniques.items())

log = open('example_log.txt')
parsed = parse_log(log)
file = open('temporary.csv', 'r+')
csv_file = build_csv(
    parsed,
    header=[
        'ip', 'time_local', 'request_type',
        'request_path', 'status', 'bytes_sent',
        'http_referrer', 'http_user_agent'
    ],
    file=file
)
uniques = count_unique_request(csv_file)
summarized_file = open('summarized.csv', 'r+')
summarized_csv = build_csv(uniques, header=['request_type', 'count'], file=summarized_file)
print(summarized_file.readlines())