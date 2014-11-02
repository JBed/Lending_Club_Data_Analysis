Analysis of the Lending Club data set. 
===

See my blog post at http://jbedford.net/p2plending/


The original data set can be downloaded from [here](https://www.lendingclub.com/info/download-data.action)



###Part1-LASSO

Used LASSO in the "glmnet" package in R to build a predictor of loan success. 



###Part2-LDA

used Latent Dirichlet allocation (LDA) in the gensim package in python to analyse the reasons people are borrowing money. 


###Part 3-Final

Used the LDA result as covariates in a new LASSO model. This seems to improve prediction accuracy.



