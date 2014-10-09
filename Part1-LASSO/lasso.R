
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

yreg <- cbind(loans$loan_amnt,loans$term,loans$last_fico_range_high,loans$installment,loans$home_ownership,loans$annual_inc,loans$is_inc_v)

x <- data.matrix(loans$current)
y <- data.matrix(yreg)

library(glmnet)
fit1=glmnet(y,x , family = "binomial")

plot(fit1, xvar = "dev", label = TRUE)

cvfit = cv.glmnet(y, x, family = "binomial", type.measure = "class")
plot(cvfit)

cvfit$lambda.min
coef(cvfit, s = "lambda.min")








