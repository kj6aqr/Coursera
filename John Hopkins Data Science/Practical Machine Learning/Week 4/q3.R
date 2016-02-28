# Setup from question
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]


registerDoMC(cores = 4)
set.seed(233)

modFit <- train(CompressiveStrength ~ ., data=training, method="lasso")
pred <- predict(modFit, newdata=testing)

plot.enet(modFit$finalModel,xvar="penalty",use.color=TRUE)
predict.enet(modFit$finalModel, type="coefficients")$coefficients
