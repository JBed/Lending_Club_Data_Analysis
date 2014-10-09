
##LDA stuff 

##install using 
##http://stackoverflow.com/questions/24172188/how-can-i-install-topicmodels-package-in-r/24245311#24245311

install.packages(c("RTextTools","topicmodels"))
library(RTextTools)
library(topicmodels)

install.packages('/Users/jason/Downloads/topicmodels_0.2-1.tar.gz',type="source")

##example of lda in R

library(lda)
text <- scan("http://www.gutenberg.org/cache/epub/2701/pg2701.txt", what = "character", 
             sep = "\n")
class(text)  # text is a character vector


head(text)
start <- 408
end <- 18577
novel.lines <- text[start:(end - 1)]  # why the -1
novel <- paste(novel.lines, collapse = " ")
length(novel)

novel.lower <- tolower(novel)
moby.words <- strsplit(novel.lower, "\\W")

moby.word.vector <- unlist(moby.words)
chunk.size <- 1000  # set a chunk variable
num.chunks <- length(moby.word.vector)/chunk.size

mywhich <- function(word.vector, stoplist) {
  word.vector[!(word.vector %in% stoplist)]
}

chunk.size <- 1000  # set a chunk variable
num.chunks <- length(moby.word.vector)/chunk.size
num.chunks
## [1] 214.9
x <- seq_along(moby.word.vector)
# create a list where each item is a chunk vector
chunks <- split(moby.word.vector, ceiling(x/chunk.size))
# What have we done here? ceiling is a rounding function.

chunks.as.strings <- lapply(chunks, paste, collapse = " ")

chunk.vector <- unlist(chunks.as.strings)




doclines <- lexicalize(chunk.vector)
set.seed(8675309)  # Jenny's number
K <- 5
num.iterations <- 250
result <- lda.collapsed.gibbs.sampler(doclines$documents, K, doclines$vocab, num.iterations, 0.1, 0.1, compute.log.likelihood = TRUE)


top.words <- top.topic.words(result$topics, 25, by.score = TRUE)
# let's see what we've got
print(top.words)

install.packages("wordcloud")
library(wordcloud)

i <- 1
cloud.data <- sort(result$topics[i, ], decreasing = TRUE)[1:50]
wordcloud(names(cloud.data), freq = cloud.data, scale = c(4, 0.1), min.freq = 1, rot.per = 0, random.order = FALSE)



i <- 4
cloud.data <- sort(result$topics[i, ], decreasing = TRUE)[1:50]
wordcloud(names(cloud.data), freq = cloud.data, scale = c(4, 0.1), min.freq = 1, rot.per = 0, random.order = FALSE)
