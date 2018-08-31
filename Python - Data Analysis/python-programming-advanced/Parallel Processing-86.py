## 2. Using Mutable Values for Changing Information ##

class Counter():
    def __init__(self):
        self.count = 0
    def increment(self):
        self.count += 1
    def get_count(self):
        return self.count

def count_up_100000(counter):
    for i in range(100000):
        counter.increment()
        
counter = Counter()
initial_count = counter.get_count()

count_up_100000(counter)

final_count = counter.get_count()



## 3. Multithreading Multiple Processes ##

import threading

counter = Counter()
count_thread = threading.Thread(target=count_up_100000, args=[counter])
count_thread.start()
count_thread.join()

after_join = counter.get_count()
print(after_join)



## 4. Determinism of Program Results ##

import threading

def conduct_trial():
    counter = Counter()
    count_thread = threading.Thread(target=count_up_100000, args=[counter])
    count_thread.start()
    count= counter.get_count()
    
    count_thread.join()
    return count
 
trial1 = conduct_trial()
print(trial1)
trial2 = conduct_trial()
print(trial2)
trial3 = conduct_trial()
print(trial3)




## 5. Using Locks to Enforce Determinism in Multithreading ##

import threading

def count_up_100000(counter, lock):
    for i in range(10000):       
        lock.acquire()
        for i in range(10):
            counter.increment()
        lock.release()

def conduct_trial():
    counter = Counter()
    lock = threading.Lock()
    
    count_thread = threading.Thread(target=count_up_100000, args=[counter, lock])
    count_thread.start()
    
    lock.acquire()
    intermediate_value = counter.get_count()
    lock.release()
    
    count_thread.join()

    return intermediate_value

trial1 = conduct_trial()
print(trial1)
trial2 = conduct_trial()
print(trial2)
trial3 = conduct_trial()
print(trial3)

## 6. Counting in Two Steps ##

def count_up_100000(counter):
    for i in range(100000):
        counter.increment()

counter = Counter()

count_up_100000(counter)
count_up_100000(counter)

final_count = counter.get_count()

print(final_count)


## 7. Counting Once on Two Different Threads ##

import threading

def count_up_100000(counter):
    for i in range(100000):
        counter.increment()

def conduct_trial():
    counter = Counter()
    count_thread1 = threading.Thread(target=count_up_100000, args=[counter])
    count_thread2 = threading.Thread(target=count_up_100000, args=[counter])

    count_thread1.start()
    count_thread2.start()

    count_thread1.join()
    count_thread2.join()

    final_count = counter.get_count()
    return final_count

trial1 = conduct_trial()
trial2 = conduct_trial()
trial3 = conduct_trial()






## 8. Imitating Atomicity With Locks ##

import threading

class Counter():
    def __init__(self):
        self.count = 0
        self.lock = threading.Lock()
        
    def increment(self):
        self.lock.acquire()
        old_count = self.count
        self.count = old_count + 1
        self.lock.release()
        
    def get_count(self):
        return self.count

def count_up_100000(counter):
    for i in range(100000):
        counter.increment()

def conduct_trial():
    counter = Counter()
    count_thread1 = threading.Thread(target=count_up_100000, args=[counter])
    count_thread2 = threading.Thread(target=count_up_100000, args=[counter])

    count_thread1.start()
    count_thread2.start()

    count_thread1.join()
    count_thread2.join()

    final_count = counter.get_count()
    return final_count

trial1 = conduct_trial()
trial2 = conduct_trial()
trial3 = conduct_trial()

print(trial1)
print(trial2)
print(trial3)



