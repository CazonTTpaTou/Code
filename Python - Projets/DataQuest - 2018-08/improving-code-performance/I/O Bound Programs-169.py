## 2. Profiling an I/O bound task ##

import cProfile
import sqlite3

query = "SELECT DISTINCT teamID from Teams inner join TeamsFranchises on Teams.franchID == TeamsFranchises.franchID where TeamsFranchises.active = 'Y';"
conn = sqlite3.connect("lahman2015.sqlite")

cur = conn.cursor()
teams = [row[0] for row in cur.execute(query).fetchall()]

def count_runs(teams):
    home_runs=list()
    query = 'select SUM(HR) FROM Batting Where teamID=?'
    for team in teams:        
        runs = cur.execute(query,[team]).fetchall()
        home_runs.append(runs[0][0])
    return home_runs

import cProfile

profile_string = "home_runs = count_runs(teams)"
cProfile.run(profile_string)




## 3. Blocking Tasks ##

import sqlite3

memory = sqlite3.connect(':memory:') # create a memory database
disk = sqlite3.connect('lahman2015.sqlite')

dump = "".join([line for line in disk.iterdump() if "Batting" in line])
memory.executescript(dump)

cur = memory.cursor()

def count_run(teams):
    home_runs=list()
    query = "SELECT SUM(HR) FROM Batting WHERE teamId=?"

    for team in teams:
        sum_hr = cur.execute(query,[team]).fetchall()[0][0]
        home_runs.append(sum_hr)
    
    return home_runs

string_profile = "count_run(teams)"
cProfile.run(string_profile)


    

## 4. Parallel Execution ##

import threading

def task(team):
    print(team)
    
for index,team in enumerate(teams):
    thread = threading.Thread(target=task,
                              args=(team,))
    thread.start()
    print("Started task {}".format(index))
    
    

## 5. Thread Blocking ##

import threading
import time

def task(team):
    time.sleep(3)
    print(team)
    
for index,team in enumerate(teams):
    thread = threading.Thread(target=task,
                              args=(team,))
    thread.start()
    print("Started task {}".format(index))
    
    
    

## 7. Joining Threads ##

import threading
import time

def task(team):
    print(team)
    
for number in range(11):
    team_names = teams[number*5:(number+1)*5]
    threads = list()
    
    for team in team_names:
        thread = threading.Thread(target=task,
                              args=(team,))
        thread.start()
        threads.append(thread)
    
    for th in threads:
        th.join()
        
    print('Finished batch {} \n'.format(number))
    
    
    

## 9. Locking ##

import threading
import time
import sys

def task(team):
    lock.acquire()
    print(team)
    sys.stdout.flush()
    lock.release()

lock = threading.Lock()
    
for number in range(11):
    team_names = teams[number*5:(number+1)*5]
    threads = list()
    
    for team in team_names:
        thread = threading.Thread(target=task,
                              args=(team,))
        thread.start()
        threads.append(thread)
    
    for th in threads:
        th.join()
        
    print('\n Finished batch {} \n'.format(number))    

## 10. Thread Safety ##

import cProfile
import sqlite3
import threading
import sys

lock = threading.Lock()

query = "SELECT DISTINCT teamID from Teams inner join TeamsFranchises on Teams.franchID == TeamsFranchises.franchID where TeamsFranchises.active = 'Y';"

conn = sqlite3.connect("lahman2015.sqlite", check_same_thread=False)
cur = conn.cursor()

teams = [row[0] for row in cur.execute(query).fetchall()]

query = "SELECT SUM(HR) FROM Batting WHERE teamId=?"

def count_runs(team):        
    
        lock.acquire()
        
        total_run=cur.execute(query,[team]).fetchall()
        print('Team : {} - {} homerun(s) \n'.format(team,
                                                    total_run[0][0]))
        sys.stdout.flush()
        
        lock.release()
        
threads = list()

for team in teams:
    thread = threading.Thread(target=count_runs,
                              args=(team,))
    thread.start()
    threads.append(thread)
    
for t in threads:
    t.join()

    

## 12. Returning Values From Threads ##

import threading

conn = sqlite3.connect("lahman2015.sqlite", check_same_thread=False)
best = {}

def best_batter():
    pass

def best_pitcher():
    pass

def best_fielder():
    pass
best = {}
lock = threading.Lock()

def best_batter():
    cur = conn.cursor()
    query = """
    SELECT 
        ((CAST(H AS FLOAT) + BB + HBP) / (AB + BB + HBP + SF)) + ((H + "2B" + 2*"3B" + 3*HR) / AB) as OBP,  
        playerID
    FROM Batting
    GROUP BY Batting.playerID
    HAVING AB > 100
    ORDER BY OBP desc
    LIMIT 20;
    """
    players = cur.execute(query).fetchall()
    names = [p[1] for p in players]
    best["batter"] = names
    lock.acquire()
    print("Done finding best batters.")
    lock.release()
    
    
def best_pitcher():
    cur = conn.cursor()
    query = """
    SELECT 
        ((13*CAST(HR AS FLOAT) + 3*BB - 2*SO) / IPOuts) + 3.2 as FIP,  
        playerID
    FROM Pitching
    GROUP BY Pitching.playerID
    HAVING IPOuts > 100
    ORDER BY FIP asc
    LIMIT 20;
    """
    players = cur.execute(query).fetchall()
    names = [p[1] for p in players]
    best["pitcher"] = names
    lock.acquire()
    print("Done finding best pitchers.")
    lock.release()

def best_fielder():
    cur = conn.cursor()
    query = """
    SELECT 
        (CAST(A AS FLOAT) + PO) / G as RF,  
        playerID
    FROM Fielding
    GROUP BY Fielding.playerID
    HAVING G > 100
    ORDER BY RF desc
    LIMIT 20;
    """
    players = cur.execute(query).fetchall()
    names = [p[1] for p in players]
    best["fielder"] = names
    lock.acquire()
    print("Done finding best fielders.")
    lock.release()

threads = []
for func in [best_fielder, best_batter, best_pitcher]:
    thread = threading.Thread(target=func)
    thread.start()
    threads.append(thread)

for thread in threads:
    thread.join()

print(best)