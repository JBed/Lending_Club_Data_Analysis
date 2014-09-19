
#set the working dir
setwd("~/1.WebSite/1.Data_Posts/3.Lending_club")

#laod some packages
library(ggplot2)
library(maps)

#load some data
loans <- read.csv("SmallLoan.csv", header=TRUE, skip = 1)

#get a summery
summary(loans)
library(Hmisc)
describe(loans) 
library(pastecs)
stat.desc(loans) 


#Funded amount seems ot be close to loan amout
plot(data.frame(loans$loan_amnt,loans$funded_amnt_inv))


#term vs funded amout
plot(data.frame(loans$term , loans$funded_amnt_inv))


#it looks like 60 months were for more money.
#but let's compute a P-value to check the significatch. 

t.test(loans$funded_amnt_inv~loans$term)
#p-value = 0.005345

#Chi-squared test is really what we should be doing
wald.test(b = coef(mylogit), Sigma = vcov(mylogit), Terms = 4:6)

#let;s do some logistic regression for fun

#-----looking at fuding amt and interest rate

# note interst rate is carigorical!!! I think

#first let's plot 
plot(data.frame(loans$int_rate , loans$funded_amnt_inv))

#now let's do some statistics




#-----looking at intereste rate and grade

#first let's plot 
plot(data.frame(loans$grade , loans$funded_amnt_inv))


#let's do some stats


#------home_ownership





# then at the end let's build this crazy model for 










