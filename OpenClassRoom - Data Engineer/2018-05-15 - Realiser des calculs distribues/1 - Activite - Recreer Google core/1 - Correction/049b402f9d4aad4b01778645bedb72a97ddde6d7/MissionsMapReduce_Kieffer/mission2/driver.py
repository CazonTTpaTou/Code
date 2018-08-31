#! /usr/bin/env python3
import sys
import subprocess
import re
import numpy as np


s = 0.15 # teleport probability
epsilon = 0.001 # tolerence factor when iterating on PageRank

LOCAL_PATH = "/home/darkmatther/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_2/"
HDFS_PATH = "/user/darkmatther/ExoMapReduce_2/"

input_path = HDFS_PATH + "input/"
output_path = HDFS_PATH + "output/"

input_file = HDFS_PATH + "input/adj_list" # Need to have input/ and output/ directories already created on HDFS, and adj_list already copied in input/

linecount_mapper = LOCAL_PATH + "linecount_mapper.py"
linecount_reducer = LOCAL_PATH + "linecount_reducer.py"

pagerank_mapper = LOCAL_PATH + "pagerank_mapper.py"
pagerank_reducer =LOCAL_PATH + "pagerank_reducer.py"


def launchShellCommand(command):
    """ Launch UNIX command 'command' and return stdout as a string """

    p = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    output = p.communicate()[0]
    return output.decode('utf-8')
   


def main():
    """ Use 'clean' command line argument to recalculate the size of the PageRank vector (in a mapreduce process) """

    # **************************
    # Get command line arguments
    # **************************
    
    clean = False
    if len(sys.argv) >= 2:
        if sys.argv[1] == "clean":
            clean = True


    # *****************************************************************************************************
    # Calculate the size 'n' of the PageRank vector using mapreduce on input file adj_list (stored on HDFS)
    # *****************************************************************************************************

    recalculate = False

    out = launchShellCommand("hdfs dfs -cat {}linecount/*".format(output_path)).strip()

    # Calculate 'n' if not done already
    pattern = re.compile("^[0-9]+$")
    if pattern.match(out) is None:
        recalculate = True
        
    # Delete output directory if it already exists AND if user has set command line argument 'clean'
    elif pattern.match(out) is not None and clean == True:         
        launchShellCommand("hdfs dfs -rm -r {}linecount".format(output_path))
        recalculate = True

    if recalculate == True:
        print("\nComputing the size of the PageRank vector ...\n")
        launchShellCommand("mapred streaming -input {} -output {}linecount -mapper {} -reducer {}"\
                           .format(input_file, output_path, linecount_mapper, linecount_reducer))
    
    n = int(launchShellCommand("hdfs dfs -cat {}linecount/part-00000".format(output_path)).strip())

    print("\nSize of the PageRank vector = ", n, "\n")


    # *************************************************
    # Create file to store PageRank vector at each step
    # *************************************************

    # Create initial PageRank vector
    x_0 = [str(1.0/n)] * n

    # Store initial PageRank vector in external file
    iter_pagerank_path = LOCAL_PATH + "iter_pagerank.txt"
    with open(iter_pagerank_path, 'w') as x:
        x.write(' '.join(x_0))


    # ******************
    # Calculate PageRank
    # ******************
    
    i = 0 # Counter of iterations

    # Delete output directory if already exists
    out = launchShellCommand("hdfs dfs -test -d {}pagerank; echo $?".format(output_path))
    if int(out) == 0:
        launchShellCommand("hdfs dfs -rm -r {}pagerank".format(output_path))

    while True:

        i += 1
        print("************\nIteration", i, "\n************\n")

        # Launch mapreduce process
        launchShellCommand("mapred streaming -input {} -output {}pagerank -mapper {} -reducer '{} {} {}' -file {}"\
                           .format(input_file, output_path, pagerank_mapper, pagerank_reducer, str(s), str(n), iter_pagerank_path))
        
        # Parse output file (from reducer) to get the new PageRank vector
        new_x = launchShellCommand("hdfs dfs -cat {}pagerank/part-00000 | sort -n | cut -f 2 | tr '\n' ' '".format(output_path)).split()

        # Get last iteration of the PageRank vector from iter_pagerank.txt
        last_x = []    
        with open('iter_pagerank.txt', 'r') as f:
            last_x = f.readlines()[-1].strip().split()
        
        # Append the new PageRank vector to iter_pagerank.txt
        with open('iter_pagerank.txt', 'a') as f:
            f.write("\n" + ' '.join(new_x))

        # Calculate delta = || new_x - last_x ||
        delta = np.linalg.norm(np.array([float(xi) for xi in new_x]) - np.array([float(xi) for xi in last_x]))
        print("\ndelta = ", delta)

        # Delete output directory
        launchShellCommand("hdfs dfs -rm -r {}pagerank".format(output_path))

        # Stop PageRank calculation if delta <= epsilon
        if delta <= epsilon:
            print("|| new_x - last_x || <= ", epsilon, "? -> TRUE\n")
            with open('pagerank.txt', 'w') as f:
                f.write(' '.join(new_x))
            break
        else:
            print("|| new_x - last_x || <= ", epsilon, "? -> FALSE")
            print("\nStarting new iteration ...\n")
            


    print("***************************************")
    print("PAGERANK CALCULATION ENDED SUCCESSFULLY")
    print("\nTotal number of iterations : ", i)
    print("\nPageRank vector written in pagerank.txt")
    print("\nList of the 20 webpages with highest PageRank :")
    launchShellCommand("cat pagerank.txt | tr ' ' '\n' | awk '{print NR \"\t\" $0}' | sort -k 2 -r | head -n 20 > results.txt")
    print(launchShellCommand("cat results.txt"))
    print("***************************************")




if __name__ == '__main__':
    main()
