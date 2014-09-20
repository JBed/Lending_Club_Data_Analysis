
#set the working dir
setwd("~/2.Github/2.DataSci_Repos/1.Lending_Club/Lending_Club_Data_Analysis")

#laod some packages
library(ggplot2)
library(maps)

#load some data
loans <- read.csv("SmallLoan.csv", header=TRUE, stringsAsFactors=FALSE, skip = 1)

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

#> glm(formula, family, data, weights, subset, ...)


#-----looking at intereste rate and grade

#first let's plot 
plot(data.frame(loans$grade , loans$funded_amnt_inv))


#let's do some stats


#------home_ownership

plot(data.frame(loans$home_ownership , loans$funded_amnt_inv))
#does not look like much signal


#---annual_inc

plot(data.frame(loans$annual_inc , loans$funded_amnt_inv))
#deff signal here

#lets lm
linMod <- lm(loans$annual_inc ~ loans$funded_amnt_inv )
plot(linMod)


#let's random forrest
library(randomForest)
rf1 <- randomForest(loans$annual_inc ~ loans$funded_amnt_inv, loans, ntree=50, norm.votes=FALSE)
rf1
plot(rf1)

#wiht rpart
# Classification Tree with rpart
library(rpart)

# grow tree 
rf2 <- rpart(loans$annual_inc ~ loans$funded_amnt_inv, method="class", data=loans)

printcp(rf2) # display the results 
plotcp(rf2) # visualize cross-validation results 
summary(rf2) # detailed summary of splits

pfit<- prune(rf2, cp=0.01160389) # from cptable   
plot(pfit)

#I like party
library(party)
fit <- ctree(loans$annual_inc ~ loans$funded_amnt_inv)
plot(fit)




#---is_inc_v
#is income verifyed

plot(data.frame(loans$is_inc_v , loans$funded_amnt_inv))
#deff signal here

plot(data.frame(loans$is_inc_v , loans$loan_status))
#some signal


#---purpose


plot(data.frame(loans$purpose , loans$funded_amnt_inv))
plot(data.frame(loans$addr_state , loans$funded_amnt_inv))
#not what i was expecting

#--total_pymnt

plot(data.frame(loans$total_pymnt, loans$funded_amnt_inv))

lm(loans$total_pymnt~loans$funded_amnt_inv)



#---loan_status

plot(data.frame(loans$loan_status, loans$funded_amnt_inv))



#ok so we have explored the intersting perdicters
#now it's time to start asking some intesting quesitons

#Question #1: can we perdict 

#let's logistic regress 

#let's penalize regress

#let's random forest 


#Question #2: can we perdic the sucess of a loan


