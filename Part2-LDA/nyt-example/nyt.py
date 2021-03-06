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

trainset_size = int(round(len(nyt_data)*0.75)) # i chose this threshold arbitrarily...to discuss
print 'The training set size for this classifier is ' + str(trainset_size) + '\n'

X_train = np.array([''.join(el) for el in nyt_data[0:trainset_size]])
y_train = np.array([el for el in nyt_labels[0:trainset_size]])

X_test = np.array([''.join(el) for el in nyt_data[trainset_size+1:len(nyt_data)]]) 
y_test = np.array([el for el in nyt_labels[trainset_size+1:len(nyt_labels)]]) 

#print(X_train)

vectorizer = TfidfVectorizer(min_df=2, 
 ngram_range=(1, 2), 
 stop_words='english', 
 strip_accents='unicode', 
 norm='l2')
 
test_string = unicode(nyt_data[0])

print "Example string: " + test_string
print "Preprocessed string: " + vectorizer.build_preprocessor()(test_string)
print "Tokenized string:" + str(vectorizer.build_tokenizer()(test_string))
print "N-gram data string:" + str(vectorizer.build_analyzer()(test_string))
print "\n"
 
X_train = vectorizer.fit_transform(X_train)
X_test = vectorizer.transform(X_test)

nb_classifier = MultinomialNB().fit(X_train, y_train)

y_nb_predicted = nb_classifier.predict(X_test)

print "MODEL: Multinomial Naive Bayes\n"

print 'The precision for this classifier is ' + str(metrics.precision_score(y_test, y_nb_predicted))
print 'The recall for this classifier is ' + str(metrics.recall_score(y_test, y_nb_predicted))
print 'The f1 for this classifier is ' + str(metrics.f1_score(y_test, y_nb_predicted))
print 'The accuracy for this classifier is ' + str(metrics.accuracy_score(y_test, y_nb_predicted))

print '\nHere is the classification report:'
print classification_report(y_test, y_nb_predicted)

#simple thing to do would be to up the n-grams to bigrams; try varying ngram_range from (1, 1) to (1, 2)
#we could also modify the vectorizer to stem or lemmatize
print '\nHere is the confusion matrix:'
print metrics.confusion_matrix(y_test, y_nb_predicted, labels=unique(nyt_labels))


#What are the top N most predictive features per class?
N = 10
vocabulary = np.array([t for t, i in sorted(vectorizer.vocabulary_.iteritems(), key=itemgetter(1))])

for i, label in enumerate(nyt_labels):
 if i == 7: # hack...
 break
 topN = np.argsort(nb_classifier.coef_[i])[-N:]
 print "\nThe top %d most informative features for topic code %s: \n%s" % (N, label, " ".join(vocabulary[topN]))
 #print topN


 from sklearn.svm import LinearSVC

svm_classifier = LinearSVC().fit(X_train, y_train)

y_svm_predicted = svm_classifier.predict(X_test)
print "MODEL: Linear SVC\n"

print 'The precision for this classifier is ' + str(metrics.precision_score(y_test, y_svm_predicted))
print 'The recall for this classifier is ' + str(metrics.recall_score(y_test, y_svm_predicted))
print 'The f1 for this classifier is ' + str(metrics.f1_score(y_test, y_svm_predicted))
print 'The accuracy for this classifier is ' + str(metrics.accuracy_score(y_test, y_svm_predicted))

print '\nHere is the classification report:'
print classification_report(y_test, y_svm_predicted)

#simple thing to do would be to up the n-grams to bigrams; try varying ngram_range from (1, 1) to (1, 2)
#we could also modify the vectorizer to stem or lemmatize
print '\nHere is the confusion matrix:'
print metrics.confusion_matrix(y_test, y_svm_predicted, labels=unique(nyt_labels))


