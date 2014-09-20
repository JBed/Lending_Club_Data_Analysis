

#load the data 
setwd("~/1.WebSite/8.DataSci/LendingClub/2007-2011")
loans <- read.csv("LoanData-Small.csv", header=TRUE, stringsAsFactors=TRUE)

#make the factors

loans$term <- as.factor(loans$term)
loans$int_rate <- as.factor(loans$int_rate)
loans$grade <- as.factor(loans$grade)

loans$emp_length <- as.factor(loans$emp_length)
loans$is_inc_v <- as.factor(loans$is_inc_v)
loans$grade <- as.factor(loans$grade)

typeof(loans$int_rate)
