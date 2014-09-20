

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

#PART1 try to perdic who pays

# take a look at what we are trying to perdict
summary(loans$loan_status)

# build logistic regression model using the glm
fit <- glm(loan_status ~  loan_amnt + term + int_rate + installment + home_ownership + annual_inc + is_inc_v + purpose , data=loans, family=binomial())
summary(fit) # show results
plot(fit)


