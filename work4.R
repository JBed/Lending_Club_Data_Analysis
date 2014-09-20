

#load the data 
setwd("~/1.WebSite/8.DataSci/LendingClub/2014-Now")
loans <- read.csv("LoanStats3c_securev1.csv", header=TRUE, stringsAsFactors=TRUE, skip=1)

#make the factors
loans$term <- as.factor(loans$term)
loans$int_rate <- as.factor(loans$int_rate)
loans$grade <- as.factor(loans$grade)
loans$sub_grade <- as.factor(loans$sub_grade)
loans$home_ownership <- as.factor(loans$home_ownership)
loans$loan_status <- as.factor(loans$loan_status)
loans$purpose <- as.factor(loans$purpose)
is.factor(loans$is_inc_v) #stringsAsFactor worked



# build logistic regression model using the glm

fit <- glm(  , data=loans, family=binomial())


summary(fit) # show results


