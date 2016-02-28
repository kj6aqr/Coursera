library(ElemStatLearn)

data(vowel.train)
data(vowel.test) 
vowel.train$y<-as.factor(vowel.train$y)
vowel.test$y<-as.factor(vowel.test$y)

set.seed(33833)

allowParallel=TRUE
modFit<-train(y ~ .,data=vowel.train,method="rf",prox=TRUE)
print(varImp(modFit))