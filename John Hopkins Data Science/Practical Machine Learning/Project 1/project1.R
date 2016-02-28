pmlTrainRaw<-read.csv("pml-training.csv",na.strings=c("NA",""))
pmlTest<-read.csv("pml-testing.csv",na.strings=c("NA",""))

# Remove tagging data
pmlTrainRaw<-pmlTrainRaw[,8:160]
pmlTest<-pmlTest[,8:160]

# Rows have either 19216 NAs or none
#sapply(pmlTrainRaw,function(x)sum(is.na(x)))
nona<-apply(is.na(pmlTrainRaw),2,sum)==0
pmlTrainRaw<-pmlTrainRaw[,nona]
pmlTest<-pmlTest[,nona]

# Make separate training and validation sets
inTrain<-createDataPartition(pmlTrainRaw$classe,p=0.1,list=FALSE)
pmlTrain<-pmlTrainRaw[inTrain,]
pmlValidate<-pmlTrainRaw[-inTrain,]

set.seed(42)

#fitControl <- trainControl(method="repeatedcv",number=5,repeats=1)
#tgrid<-expand.grid(mtry=c(6))
#modFit<-train(classe ~ .,data=pmlTrain,method="rf",prox=TRUE,trControl=fitControl,tuneGrid=tgrid)
modFit<-train(classe ~ .,data=pmlTrain,method="rpart")

predTrain<-predict(modFit,newdata=pmlTrain)
confusionMatrix(predTrain,pmlTrain$classe)$overall[1]

predValidate<-predict(modFit,newdata=pmlValidate)
confusionMatrix(predValidate,pmlValidate$classe)$overall[1]