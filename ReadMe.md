Analysis of the Lending Club data sets. 
===


The [Lending Club](www.lendingclub.com) (TLC) is an online lending marketplace that matches borrowers and lenders. Borrowers apply to TLC and, if accepted, their application will be listed for investors to review. Anyone with money can sign up to fund these loans.

TLC makes almost all of the data from their applicants publicly available. This included comments left my applicants regarding why they want to borrow money. This repo contains my code for exploring this data set.

### The Method

LDA posits that the collection of words that make up a document each belong to a small number of "topics". The algorithms takes an as input a set of documents and outputs the topics and the words belonging to each "topic".

### Results and Discussion

After removing stop words, the topics are:

```sh
Topic #1: loan, APR, bankruptcy, credit, pay, cards, interest, cards, bills, minimum.
Topic #2: Student, debt, consolidating, payment, working, school, unemployed, job
Topic #3: medical, scare, death, debt, sickness, health, heart, bankruptcies, disease
Topic #4: home, office, improvement, car, motorcycle, repairs, chrysler 
Topic #5: Christmas, time, ASAP, holidays, engagement, life, trust
Topic #6: legal, run, simplify, jail, incarcerated, life, help.
```

I decided to stop after six topics as the topics stated to become much more noise after this. The terms ranked according to how well they represent the their category. 

Overall, we find that almost a quarter of people borrowing money from the lending club are doing so because of unforeseen expenses (topic 3 and 6). Reguarding the medical debts, this is a well [known](http://www.theatlantic.com/health/archive/2014/10/why-americans-are-drowning-in-medical-debt/381163/) problem in the US and not suprizing it shows up here.


### Future work

A natural and very useful way to extract this work would be to quantify the correlation between applicants clustered as unforeseen expenses (topic 3 and 6) and their ability to ultimately repay their loans.



