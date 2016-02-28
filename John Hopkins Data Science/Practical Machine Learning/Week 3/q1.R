library(AppliedPredictiveModeling)
library(caret)

# Get data, separate into training and testing
data(segmentationOriginal)
training<-segmentationOriginal[segmentationOriginal$Case=="Train",]
testing<-segmentationOriginal[segmentationOriginal$Case=="Test",]

set.seed(125)

modFit<-train(Class ~ .,method="rpart",data=training)
print(modFit$finalModel)
plot(modFit$finalModel, uniform=TRUE, main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=0.5)