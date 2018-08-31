#! /usr/bin/env python3
import sys


total = 0
lastword = None
lastDocId = None

for line in sys.stdin:

    # Get key-value pair ((word, doc_id), count), and convert count into an int
    word, doc_id, count = line.strip().split()
    count = int(count)

    # Initialization
    if lastword is None:
        lastword = word
    if lastDocId is None:
        lastDocId = doc_id

    # Incrementation of the number of occurrences of "word" in the document "doc_id"
    if word == lastword and doc_id == lastDocId:
        total += count

    # Write (lastword, lastDocId, total) to stdout whenever reaching a new word or a new document
    else:
        print("%s\t%s\t%d" % (lastword, lastDocId, total))
        total = count
        lastword = word
        lastDocId = doc_id
    

if lastword is not None:
    print("%s\t%s\t%d" % (lastword, lastDocId, total))
