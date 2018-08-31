## 3. Processing Applications ##

import pandas
applications = pandas.read_csv("applications.csv")
from datetime import datetime

def compute_age(date_birth):
    today = datetime.now()
    datebirth = datetime.strptime(date_birth,'%Y-%m-%d %H:%M:%S')
    age = (today - datebirth).days / 365.25
    return (age >=18)

def check_adress(adress):
    state = adress.split(" ")[-2]
    return (state=='CA')

def process_application(row):
    status = (compute_age(row['birthdate']) 
              & (check_adress(row['address'])))
    
    return status

application_status = applications.apply(process_application,axis=1)       
              
print(compute_age('1995-01-15 22:53:49'))
print(check_adress('0644 Carrie Mountain Apt. 538 Larsenville  TX 50038-5437'))
print(check_adress('Catherine Jensen,10568 Mcguire Springs Apt. 726 Benjaminville CA 94656,7715 Ronald Meadow Apt. 602 Leside  CA 27498-1815'))

print(application_status)
      
      

## 5. Stacks ##

import threading
import math
import time

def compute_age(date_birth):
    today = datetime.now()
    datebirth = datetime.strptime(date_birth,'%Y-%m-%d %H:%M:%S')
    age = (today - datebirth).days / 365.25
    return (age >=18)

def check_adress(adress):
    state = adress.split(" ")[-2]
    return (state=='CA')

def process_application(row):
    status = (compute_age(row['birthdate']) 
              & (check_adress(row['address'])))
    
    return status

wait_times = list()
stack = list()
task_numbers = list()

def add_tasks():
    for index,row in applications.iterrows():
        number = index + 1
        stack.insert(0,(number,row))        
        task_numbers.append(number)
        time.sleep(0.001)
        
def process_tasks():
    tasks_finished = 0
    while tasks_finished < 2400:
        if not stack:
            time.sleep(0.001)
        else:        
            task_number, application = stack.pop(0)
            resp = process_application(application)
            tasks_finished+=1
            if task_number == task_numbers[-1]:
                wait_times.append(600)
            else:
                wait_times.append((24-math.ceiling(task_number/300))*3600)

t1 = threading.Thread(target=add_tasks)        
t2 = threading.Thread(target=process_tasks)

t1.start()
t2.start()

threads = [t1,t2]

for th in threads:
    th.join()
    
average_wait_time = sum(wait_times)/len(wait_times)

print(wait_times)





## 6. Implementing A Stack ##

class Stack():
    def __init__(self):
        self.items = list()
        
    def push(self,value):
        self.items.insert(0,value)
        
    def pop(self):
        return self.items.pop(0)
    
    def count(self):
        return len(self.items)
    
stack = Stack()

for val in range(1,4):
    stack.push(val)

stack.pop()

print(stack.count())




## 7. Time Spent In Stacks ##

import matplotlib.pyplot as plt

stack = Stack()
queue_times = list()
wait_times = list()

def add_tasks():
    for index, row in applications.iterrows():
        stack.push((index + 1, row))
        queue_times.append(0)
        time.sleep(.001)

def process_tasks():
    tasks_finished = 0
    while tasks_finished < 2400:
        if stack.count() == 0:
            time.sleep(1)
        else:
            task_number, application = stack.pop()
            resp = process_application(application)
            tasks_finished += 1
            
            wait_times.append(20*queue_times[task_number-1]+600)
            
            for number in range(len(queue_times)):
                queue_times[number]+=1

t1 = threading.Thread(target=add_tasks)
t2 = threading.Thread(target=process_tasks)

t1.start()
t2.start()
for t in [t1,t2]:
    t.join()

average_wait_time = sum(wait_times) / 2400
print(average_wait_time)

plt.plot(wait_times)
plt.show()


## 9. Waiting Time With Queues ##

import threading
import math
import time

def process_application(application):
    time.sleep(.001)
    birth_date = datetime.strptime(application["birthdate"], "%Y-%m-%d %H:%M:%S")
    delta = (birth_date - datetime.now()).total_seconds()
    delta /= (3600 * 24 * 365.25)
    if delta < 18:
        return False
    state = application["address"].split(" ")[-2]
    if state != "CA":
        return False
    return True
wait_times = []
queue = []

def add_tasks():
    for index, row in applications.iterrows():
        queue.append((index + 1, row))
        time.sleep(.001)

def process_tasks():
    tasks_finished = 0
    while tasks_finished < 2400:
        if len(queue) == 0:
            time.sleep(1)
        else:
            task_number, application = queue.pop(0)
            resp = process_application(application)
            tasks_finished += 1
            wait_times.append((24 - math.ceil(task_number / 300)) * 3600)
                
t1 = threading.Thread(target=add_tasks)
t2 = threading.Thread(target=process_tasks)

t1.start()
t2.start()
for t in [t1,t2]:
    t.join()

average_wait_time = sum(wait_times) / 2400
print(average_wait_time)

## 10. Implementing a Queue ##

class Queue():
    pass
class Queue():
    def __init__(self):
        self.items = []
    
    def push(self, value):
        self.items.append(value)
    
    def pop(self):
        return self.items.pop(0)
    
    def count(self):
        return len(self.items)

queue = Queue()
queue.push(1)
queue.push(2)
queue.push(3)
queue.pop()

## 11. Time Spent In Queues ##

queue = []
queue_time = list()

def add_tasks():
    for index, row in applications.iterrows():
        queue.append((index + 1, row))
        queue_time.append(0)
        time.sleep(.001)

def process_tasks():
    tasks_finished = 0
    while tasks_finished < 2400:
        if len(queue) == 0:
            time.sleep(1)
        else:
            task_number, application = queue.pop(0)
            resp = process_application(application)
            tasks_finished += 1
            
            wait_times.append(20*queue_time[task_number-1]+600)
            
            for number in range(len(queue_time)):
                queue_time[number]+=1
                
t1 = threading.Thread(target=add_tasks)
t2 = threading.Thread(target=process_tasks)

t1.start()
t2.start()
for t in [t1,t2]:
    t.join()

average_wait_time = sum(wait_times) / 2400
print(average_wait_time)




## 12. Profiling Stacks As Elements Are Added ##

queue_times = []
wait_times = [0] * 2400
stack = []

def add_tasks():
    for index, row in applications.iterrows():
        stack.insert(0,(index + 1, row))
        queue_times.append(0)
        time.sleep(.001)
        
def process_tasks():
    tasks_finished = 0
    while tasks_finished < 2400:
        if len(stack) == 0:
            time.sleep(1)
        else:
            task_number, application = stack.pop(0)
            resp = process_application(application)
            tasks_finished += 1
            index = tasks_finished - 1
            wait_times[index] =20*queue_times[index]+600
            
            for i in range(len(queue_times)):
                queue_times[i] += 1
                
t1 = threading.Thread(target=add_tasks)
t2 = threading.Thread(target=process_tasks)

t1.start()
t2.start()
for t in [t1,t2]:
    t.join()

    plt.bar(range(2400),wait_times)
    plt.show()
    



## 13. Profiling Queues As Elements Are Added ##

queue_times = []
wait_times = [0] * 2400
queue = []

def add_tasks():
    for index, row in applications.iterrows():
        queue.append((index + 1, row))
        queue_times.append(0)
        time.sleep(.001)

def process_tasks():
    tasks_finished = 0
    while tasks_finished < 2400:
        if len(queue) == 0:
            time.sleep(1)
        else:
            task_number, application = queue.pop(0)
            resp = process_application(application)
            tasks_finished += 1
            task_index = tasks_finished-1
            wait_times[task_index] = 20*queue_times[task_index]+600
            
            for i in range(len(queue_times)):
                queue_times[i] += 1

t1 = threading.Thread(target=add_tasks)
t2 = threading.Thread(target=process_tasks)

t1.start()
t2.start()

for t in [t1,t2]:
    t.join()

plt.bar(range(2400), wait_times)

