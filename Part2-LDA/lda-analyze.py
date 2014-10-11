from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import metrics
from operator import itemgetter
from sklearn.metrics import classification_report
import csv
import os

infile = open('tlcdata.txt')
nyt_data = []
#nyt_labels = []
#csv_reader = csv.reader(nyt)

for line in infile:
	nyt_data.append(line.strip())

infile.close()

from gensim import corpora, models, similarities
from itertools import chain
import nltk
from nltk.corpus import stopwords
from operator import itemgetter
import re

###documents = [nltk.clean_html(document) for document in nyt_data]
stoplist = stopwords.words('english')
texts = [[word for word in document.lower().split() if word not in stoplist] for document in nyt_data]

dictionary = corpora.Dictionary(texts)
corpus = [dictionary.doc2bow(text) for text in texts]

tfidf = models.TfidfModel(corpus) 
corpus_tfidf = tfidf[corpus]

#lsi = models.LsiModel(corpus_tfidf, id2word=dictionary, num_topics=100)
#lsi.print_topics(20)

n_topics = 12
lda = models.LdaModel(corpus_tfidf, id2word=dictionary, num_topics=n_topics)

for i in range(0, n_topics):
	temp = lda.show_topic(i, 10)
	terms = []
	for term in temp:
		terms.append(term[1])
	print "Top 10 terms for topic #" + str(i) + ": "+ ", ".join(terms)



#print 
#print 'Which LDA topic maximally describes a document?\n'
#print 'Original document: ' + nyt_data[1]
#print 'Preprocessed document: ' + str(texts[1])
#print 'Matrix Market format: ' + str(corpus[1])
#print 'Topic probability mixture: ' + str(lda[corpus[1]])
#print 'Maximally probable topic: topic #' + str(max(lda[corpus[1]],key=itemgetter(1))[0])


