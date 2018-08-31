import os
import sys
import copy
import collections

import nltk
import nltk.tokenize

## PageRank #####################################################################################

import os
import sys
import math

import numpy
import pandas

# Generalized matrix operations:
def __extractNodes(matrix):
    nodes = set()
    for colKey in matrix:
        nodes.add(colKey)
    for rowKey in matrix.T:
        nodes.add(rowKey)
    return nodes

def __makeSquare(matrix, keys, default=0.0):
    matrix = matrix.copy()
    
    def insertMissingColumns(matrix):
        for key in keys:
            if not key in matrix:
                matrix[key] = pandas.Series(default, index=matrix.index)
        return matrix

    matrix = insertMissingColumns(matrix) # insert missing columns
    matrix = insertMissingColumns(matrix.T).T # insert missing rows

    return matrix.fillna(default)

def __ensureRowsPositive(matrix):
    matrix = matrix.T
    for colKey in matrix:
        if matrix[colKey].sum() == 0.0:
            matrix[colKey] = pandas.Series(numpy.ones(len(matrix[colKey])), index=matrix.index)
    return matrix.T

def __normalizeRows(matrix):
    return matrix.div(matrix.sum(axis=1), axis=0)

def __euclideanNorm(series):
    return math.sqrt(series.dot(series))

# PageRank specific functionality:

def __startState(nodes):
    if len(nodes) == 0: raise ValueError("There must be at least one node.")
    startProb = 1.0 / float(len(nodes))
    return pandas.Series({node : startProb for node in nodes})

def __integrateRandomSurfer(nodes, transitionProbs, rsp):
    alpha = 1.0 / float(len(nodes)) * rsp
    return transitionProbs.copy().multiply(1.0 - rsp) + alpha

def powerIteration(transitionWeights, rsp=0.15, epsilon=0.00001, maxIterations=1000):
    # Clerical work:
    transitionWeights = pandas.DataFrame(transitionWeights)
    nodes = __extractNodes(transitionWeights)
    transitionWeights = __makeSquare(transitionWeights, nodes, default=0.0)
    transitionWeights = __ensureRowsPositive(transitionWeights)

    # Setup:
    state = __startState(nodes)
    transitionProbs = __normalizeRows(transitionWeights)
    transitionProbs = __integrateRandomSurfer(nodes, transitionProbs, rsp)
    
    # Power iteration:
    for iteration in range(maxIterations):
        oldState = state.copy()
        state = state.dot(transitionProbs)
        delta = state - oldState
        if __euclideanNorm(delta) < epsilon: 
            break

    return state

## TextRank #####################################################################################
    
def __preprocessDocument(document, relevantPosTags):
    
    words = __tokenizeWords(document)
    posTags = __tagPartsOfSpeech(words)
    
    # Filter out words with irrelevant POS tags
    filteredWords = []
    for index, word in enumerate(words):
        word = word.lower()
        tag = posTags[index]
        if not __isPunctuation(word) and tag in relevantPosTags:
            filteredWords.append(word)

    return filteredWords

def textrank(document, windowSize=2, rsp=0.15, relevantPosTags=["NN", "ADJ"]):    
    # Tokenize document:
    words = __preprocessDocument(document, relevantPosTags)
    
    # Build a weighted graph where nodes are words and
    # edge weights are the number of times words cooccur
    # within a window of predetermined size. In doing so
    # we double count each coocurrence, but that will not
    # alter relative weights which ultimately determine
    # TextRank scores.
    edgeWeights = collections.defaultdict(lambda: collections.Counter())
    for index, word in enumerate(words):
        for otherIndex in range(index - windowSize, index + windowSize + 1):
            if otherIndex >= 0 and otherIndex < len(words) and otherIndex != index:
                otherWord = words[otherIndex]
                edgeWeights[word][otherWord] += 1.0

    # Apply PageRank to the weighted graph:
    wordProbabilities = pagerank.powerIteration(edgeWeights, rsp=rsp)
    wordProbabilities.sort(ascending=False)

    return wordProbabilities

## NLP utilities ################################################################################

def __asciiOnly(string):
    return "".join([char if ord(char) < 128 else "" for char in string])

def __isPunctuation(word):
    return word in [".", "?", "!", ",", "\"", ":", ";", "'", "-"]

def __tagPartsOfSpeech(words):
    return [pair[1] for pair in nltk.pos_tag(words)]

def __tokenizeWords(sentence):
    return nltk.tokenize.word_tokenize(sentence)

## tests ########################################################################################

def applyTextRank(fileName, title="a document"):
    print
    print "Reading \"%s\" ..." % title
    filePath = os.path.join(os.path.dirname(__file__), fileName)
    document = open(filePath).read()
    document = __asciiOnly(document)
    
    print "Applying TextRank to \"%s\" ..." % title
    keywordScores = textrank(document)
    
    print
    header = "Keyword Significance Scores for \"%s\":" % title
    print header
    print "-" * len(header)
    print keywordScores
    print

def main():
    sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

    # Application de l'algorithme PageRank sur la matrice d'adjacence du dataset Movies
    applyTextRank("Movies_Adj_List", "Movies")    

if __name__ == "__main__":
    main()




