import random
import time
import heapq 

heap_list = list(range(10 * 100 * 5000))
random.shuffle(heap_list)
    
start = time.time()
sorted(heap_list, reverse=True)[:100]
print("Sorting search took: {} seconds".format(time.time() - start))

start = time.time()
heapq.nlargest(100, heap_list)
print("Heap search took: {} seconds".format(time.time() - start))


