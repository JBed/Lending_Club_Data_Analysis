
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

summary(loans$last_fico_range_high)
summary(loans$loan_status)
summary(loans$current)

summary(loans$term)

# build logistic regression model using the glm
glm.1 <- glm(current ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, data=loans, family=binomial(link=logit))
summary(glm.1) # show results

# using log-log link
glm.2 <- glm(current ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, data=loans, family=binomial(link=cloglog))
summary(glm.2) # show results

# compair them 
anova(glm.1,glm.2,test="Chi")

#stepwise regresssion for model selection
model1 <- step(glm.1)
medel2 <- step(glm.2)
summary(model2)
summary(model1)

plot(model2)

#Let's plot a ROC curve to compair the two models

prob=predict(model2,type=c("response"))
loans$prob=prob
library(pROC)
g <- roc(current ~ prob, data = loans)
plot(g)    
#Area under the curve: 0.649


prob2=predict(glm.2,type=c("response"))
loans$prob2=prob2
library(pROC)
g <- roc(current ~ prob2, data = loans)
plot(g)    
#Area under the curve: 0.7379


#I think that we should keep the full model

#let's try boosting glmboost

library(mboost)
glm.boost.1 <- glmboost(current ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, data=loans, family = Binomial(),center = TRUE)

prob3=predict(glm.boost.1,type=c("response"))
loans$prob3=prob3
library(pROC)
g <- roc(current ~ prob3, data = loans)
plot(g)    
# Area under the curve: 0.6586, not so good


#---

#let;s try random forrst. 


#split the data 

splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

splits <- splitdf(loans, seed=808)

training <- splits$trainset
testing <- splits$testset

test.current <- testing$current

drops <- c("current")
testing[,!(names(testing) %in% drops)]


#let's random forrest
library(randomForest)
library(randomForest)
library(ROCR)

#train it
rf1 <- randomForest(current ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, training, keep.forest=TRUE,importance=TRUE)

per.rf = predict(rf1,type="prob",newdata=testing)[,2]

pred.rf = prediction(per.rf, test.current)

perf.rf = performance(pred.rf ,"tpr","fpr")

plot(perf.rf,main="ROC Curve for Random Forest",col=2,lwd=2)

abline(a=0,b=1,lwd=2,lty=2,col="gray")


importance(rf1)
varImpPlot(rf1)


