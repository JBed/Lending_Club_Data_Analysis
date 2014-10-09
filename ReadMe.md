Analysis of the Lending Club data set. 
===

See my blog post at http://jbedford.net/credit


The original data set can be downloaded from [here](https://www.lendingclub.com/info/download-data.action)



###Part1-LASSO

Used LASSO in the glmnet package in R to build a perdictor of loan sucess. 



###Part2-LDA

used Latent Dirichlet allocation (LDA) in the gensim package in pyhon to analyse the reasons people are borrowing money. 


###Part3-Final

Used the LDA result as covariates in a new LASSO model. This seems to considerably improve prediction accuracy.


