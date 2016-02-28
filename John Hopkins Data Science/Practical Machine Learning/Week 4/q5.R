set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

library(e1071)
set.seed(325)
svm.model <- svm(CompressiveStrength ~ ., data = training)
svm.pred  <- predict(svm.model, testing)
rmse<-sqrt(mean((svm.pred-testing$CompressiveStrength)^2))