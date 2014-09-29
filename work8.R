
#load the data 
setwd("~/1.WebSite/8.DataSci/LendingClub/2014-Now")
loans <- read.csv("small.csv", header=TRUE, stringsAsFactors=TRUE, skip=1)

#make the factors
loans$term <- as.factor(loans$term)
loans$int_rate <- as.factor(loans$int_rate)
loans$grade <- as.factor(loans$grade)
loans$sub_grade <- as.factor(loans$sub_grade)
loans$home_ownership <- as.factor(loans$home_ownership)
loans$loan_status <- as.factor(loans$loan_status)
loans$purpose <- as.factor(loans$purpose)
is.factor(loans$is_inc_v) #stringsAsFactor worked
loans$sub_grade <- as.factor(loans$sub_grade)
loans$grade <- as.factor(loans$grade)

summary(loans$last_fico_range_high)
summary(loans$loan_status)
summary(loans$current)
summary(loans$term)


vector <-1
for (i in seq(loans$loan_status)) {
  if (loans$loan_status[i] == "Current") {
    vector[i]<- 1
  }
  else{
    vector[i]<- 0
  }
}


summary(as.factor(vector))
loans$current <- as.factor(vector)





#let's random forrest
library(randomForest)
library(ROCR)

#train it
rf1 <- randomForest(current ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, loans, keep.forest=TRUE,importance=TRUE)



importance(rf1)
varImpPlot(rf1)




rf2 <- randomForest(current ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v + int_rate + as.factor(loans$sub_grade) +  as.factor(loans$grade), loans, keep.forest=TRUE,importance=TRUE)

importance(rf2)
varImpPlot(rf2)


#i'm ready to start writing. 


## tring lasso 
install.packages("glmnet", repos = "http://cran.us.r-project.org")
library(glmnet)
load("QSExample.RData")


fit = glmnet(x, y)
plot(fit)
cvfit = cv.glmnet(x, y)

plot(cvfit)


cvfit$lambda.min

coef(cvfit, s = "lambda.min")


library(lars)
install.packages("lars")

model.lasso <- lars(x, y, type="lasso")

y <- as.numeric(train[,9])
x <- as.matrix(train[,1:8])




##glmmod<-glmnet(current,y=as.factor(asthma),alpha=1,family='binomial')



