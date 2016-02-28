library(ElemStatLearn)
library(caret)
library(doMC)

registerDoMC(cores = 4)
suppressMessages(library(caret))

set.seed(33833)

data(vowel.train)
data(vowel.test) 
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y  <- as.factor(vowel.test$y)

ctrl <- trainControl(method="cv")

# Random Forest
modFitRf <- train(y ~ .,data=vowel.train,method="rf",trControl=ctrl,number=3)
testPredRf <- predict(modFitRf,newdata=vowel.test)
print(confusionMatrix(testPredRf,vowel.test$y)$overall['Accuracy'])

# Boosted trees
modFitGbm <- suppressMessages(train(y ~ .,data=vowel.train,method="gbm",trControl=ctrl))
testPredGbm <- predict(modFitGbm,newdata=vowel.test)
print(confusionMatrix(testPredGbm,vowel.test$y)$overall['Accuracy'])

# Combined
qplot(testPredRf,testPredGbm,color=y,data=vowel.test)

both <- (testPredRf == testPredGbm)
print(confusionMatrix(testPredGbm[both],vowel.test$y[both])$overall['Accuracy'])
