library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)
modelFit <- train(as.factor(chd) ~ age + alcohol + obesity + tobacco + typea + ldl, method = "glm", data = trainSA)

missClass = function(values,prediction){
  sum(((prediction > 0.5)*1) != values)/length(values)
}

predictedTrain<-predict(modelFit,newdata=trainSA)
print(1-confusionMatrix(trainSA$chd, predictedTrain)$overall[1])

predictedTest<-predict(modelFit,newdata=testSA)
print(1-confusionMatrix(testSA$chd, predictedTest)$overall[1])

#missClass(testSA,modelFit)
