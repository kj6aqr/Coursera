library(pgmm)
data(olive)
olive = olive[,-1]

set.seed(125)

modFit<-train(Area ~ .,method="rpart",data=olive)
print(modFit$finalModel)
plot(modFit$finalModel, uniform=TRUE, main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=0.5)

newdata = as.data.frame(t(colMeans(olive)))

print(predict(modFit,newdata=newdata))
