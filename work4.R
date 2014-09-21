

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

#PART1 try to perdic who pays

# take a look at what we are trying to perdict
summary(loans$loan_status)

# build logistic regression model using the glm
fit <- glm(loan_status ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, data=loans, family=binomial(link=logit))
summary(fit) # show results

anova(fit)

vcov(fit)

layout(1) 
plot(fit)


#now let's compute some bic
library("BMA")

output <- bic.glm(loan_status ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, data=loans, glm.family="binomial")

summary(output)
imageplot.bma(output)

output$postprob
output$mle
output$label

###cross validating
library("boot")

outcv <- cv.glm(loans, fit)

outcv.6 <- cv.glm(loans, fit,K=6)

summary(outcv.6)

plot(outcv.6)

##

library(rms)
lrmMode <- lrm(loan_status ~  loan_amnt + term + last_fico_range_high + installment + home_ownership + annual_inc + is_inc_v, data=loans)

plot(lrmMode)

outa <- roc(lrmMode)

?pROC

#nwo let's say that we have a new model




#now let's also make a random forrest, which is uninformative but we'll do it  anyway



#now let's compair



#and were good. 






