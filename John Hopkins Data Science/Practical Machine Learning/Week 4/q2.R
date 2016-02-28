# Setup from question
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]


registerDoMC(cores = 4)
set.seed(62433)

ctrl <- trainControl(method="cv")

modFitRf <- train(diagnosis ~ ., data=training, method="rf", trControl=ctrl, number=3)
testPredRf <- predict(modFitRf, newdata=testing)
accRf <- confusionMatrix(testPredRf, testing$diagnosis)$overall['Accuracy']

modFitGbm <- train(diagnosis ~ ., data=training, method="gbm", trControl=ctrl)
testPredGbm <- predict(modFitGbm, newdata=testing)
accGbm <- confusionMatrix(testPredGbm, testing$diagnosis)$overall['Accuracy']

modFitLda <- train(diagnosis ~ ., data=training, method="lda", trControl=ctrl)
testPredLda <- predict(modFitLda, newdata=testing)
accLda <- confusionMatrix(testPredLda, testing$diagnosis)$overall['Accuracy']

predDf <- data.frame(testPredRf, testPredGbm, testPredLda, diagnosis=testing$diagnosis)
modFitComb <- train(diagnosis ~ ., data=predDf, method="rf", trControl=ctrl)
testPredComb <- predict(modFitComb, newdata=predDf)
accComb <- confusionMatrix(testPredComb, predDf$diagnosis)$overall['Accuracy']

#sprintf("Random forest: %f",accRf)
#sprintf("Gradient boosted tree: %f",accGbm)
#sprintf("LDA: %f",accLda)
#sprintf("Combined: %f",accComb)

print("Random forest")
print(accRf)
print("Gradient boosted trees")
print(accGbm)
print("LDA")
print(accLda)
print("Combined model")
print(accComb)
