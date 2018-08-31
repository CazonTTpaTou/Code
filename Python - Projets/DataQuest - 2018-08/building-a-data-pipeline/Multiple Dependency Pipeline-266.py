## 2. Intro to DAGs ##

cycle = [4,6,7]





## 3. The DAG Class ##

class DAG:
    def __init__(self):
        self.graph = {}
    
    def add(self, node, to=None):
        if node in self.graph.keys():
            if to:
                self.graph[node].append(to)
        else :
            self.graph[node] = list()
            if to:
                self.graph[node].append(to)

dag = DAG()

dag.add(1)
dag.add(1, 2)
dag.add(1, 3)
dag.add(1, 4)
dag.add(3, 5)
dag.add(2, 6)
dag.add(4, 7)
dag.add(5, 7)
dag.add(6, 7)
dag.add(7,None)

print(dag.graph)

## 5. Finding Number of In Degrees ##

class DAG(BaseDAG):
    def in_degrees(self):
        node_in_degrees = dict()
        
        for key,value in self.graph.items():
            if key not in node_in_degrees.keys():
                node_in_degrees[key] = 0
                
            for node in value:
                if node not in node_in_degrees.keys():
                    node_in_degrees[node] = 1
                else:
                    node_in_degrees[node] += 1
                    
        return node_in_degrees

dag = DAG()

dag.add(1)
dag.add(1, 2)
dag.add(1, 3)
dag.add(1, 4)
dag.add(3, 5)
dag.add(2, 6)
dag.add(4, 7)
dag.add(5, 7)
dag.add(6, 7)

in_degrees = dag.in_degrees()

print(in_degrees)



## 6. Challenge: Sorting Dependencies ##

class DAG(BaseDAG):
    
    def sort(self):
        in_degrees = self.in_degrees()
        to_visit = deque()
        for node in self.graph:
            if in_degrees[node] == 0:
                to_visit.append(node)
        
        searched = []
        while to_visit:
            node = to_visit.popleft()
            for pointer in self.graph[node]:
                in_degrees[pointer] -= 1
                if in_degrees[pointer] == 0:
                    to_visit.append(pointer)
            searched.append(node)
        return searched

dag = DAG()
dag.add(1)
dag.add(1, 2)
dag.add(1, 3)
dag.add(1, 4)
dag.add(3, 5)
dag.add(2, 6)
dag.add(4, 7)
dag.add(5, 7)
dag.add(6, 7)
dependencies = dag.sort()


## 7. Enhance the Add Method ##

class DAG(BaseDAG):
    def add(self, node, to=None):
        if not node in self.graph:
            self.graph[node] = []
        if to:
            if not to in self.graph:
                self.graph[to] = []
            self.graph[node].append(to)
            
        if len(self.sort()) != len(self.graph):
            raise Exception
            
dag = DAG()
dag.add(1)
dag.add(1, 2)
dag.add(1, 3)
dag.add(1, 4)
dag.add(3, 5)
dag.add(2, 6)
dag.add(4, 7)
dag.add(5, 7)
dag.add(6, 7)
# Add a pointer from 7 to 4, causing a cycle.
dag.add(7, 4)

## 8. Adding DAG to the Pipeline ##

class Pipeline:
    def __init__(self):
        self.tasks = DAG()
        
    def task(self, depends_on=None):
        def inner(f):
            pass
        return inner

pipeline = Pipeline()

def first():
    return 20

def second(x):
    return x * 2

def third(x):
    return x // 3

def fourth(x):
    return x // 4
class Pipeline:
    def __init__(self):
        self.tasks = DAG()
        
    def task(self, depends_on=None):
        def inner(f):
            self.tasks.add(f)
            if depends_on:
                self.tasks.add(depends_on, f)
            return f
        return inner

pipeline = Pipeline()
@pipeline.task()
def first():
    return 20

@pipeline.task(depends_on=first)
def second(x):
    return x * 2

@pipeline.task(depends_on=second)
def third(x):
    return x // 3

@pipeline.task(depends_on=second)
def fourth(x):
    return x // 4

print(pipeline.tasks.graph)

## 9. Challenge: Running the Pipeline ##

class Pipeline:
    def __init__(self):
        self.tasks = DAG()
        
    def task(self, depends_on=None):
        def inner(f):
            self.tasks.add(f)
            if depends_on:
                self.tasks.add(depends_on, f)
            return f
        return inner
    
    def run(self):
        completed=dict()
        scheduled = self.tasks.sort()
        
        for index,task in enumerate(scheduled):
            if index==0:
                completed[task] = task()
            else:
                for key,value in self.tasks.graph.items():
                    if task in value:
                        completed[task] = task(completed[key])                
        return completed

pipeline = Pipeline()

@pipeline.task()
def first():
    return 20

@pipeline.task(depends_on=first)
def second(x):
    return x * 2

@pipeline.task(depends_on=second)
def third(x):
    return x // 3

@pipeline.task(depends_on=second)
def fourth(x):
    return x // 4

outputs = pipeline.run()
