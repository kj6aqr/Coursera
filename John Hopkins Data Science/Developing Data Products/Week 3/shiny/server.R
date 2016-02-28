library(UsingR)
library(caret)
library(gbm)
library(AppliedPredictiveModeling)
library(scales)
library(e1071)
library(randomForest)

set.seed(3433)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
ctrl <- trainControl(method="cv")

#inTrain = createDataPartition(adData$diagnosis, p = 0.2)[[1]]
#training = adData[ inTrain,]
#testing = adData[-inTrain,]

shinyServer(
  
  function(input, output) {
    
    runtime<-0
    
    selModel<-reactive({
      if(input$train == '0') {
        trainPct <- 0.2
      } else if(input$train == '1') {
        trainPct <- 0.5
      } else if(input$train == '2') {
        trainPct <- 0.8
      }
      
      inTrain = createDataPartition(adData$diagnosis, p = trainPct)[[1]]
      training = adData[ inTrain,]
      testing = adData[-inTrain,]
      
      if(input$model == '0') {
        runtime<-system.time(modFit<-NULL)
      } else if(input$model == '1') {
        runtime<-system.time(modFit <- train(diagnosis ~ ., data=training, method="rf", trControl=ctrl, number=3))
      } else if (input$model == '2') {
        runtime<-system.time(modFit <- train(diagnosis ~ ., data=training, method="lda", trControl=ctrl))
      } else if (input$model == '3') {
        runtime<-system.time(modFit <- train(diagnosis ~ ., data=training, method="gbm", trControl=ctrl))
      }
      testPred <- predict(modFit, newdata=testing)
      
      print(runtime[1])
      
      cm<-confusionMatrix(testPred, testing$diagnosis)
      
      list("cm"=cm,"runtime"=runtime)
    })
    
    output$ffp <- renderPlot({  
      if(input$model != '0') {
        ctable <- as.table(matrix(c(selModel()$cm$table), nrow = 2, byrow = TRUE)) 
        fourfoldplot(ctable, color = c("#CC6666", "#99CC99"), conf.level = 0, margin = 1, main = "Confusion Matrix")
      }
    })
    
    output$accuracy <- renderText({
      if(input$model != '0') {
        paste("Overall accuracy = ",percent(selModel()$cm$overall['Accuracy']))
      }
    })
    
    output$time <- renderText({
      if(input$model != '0') {
        paste("Time elapsed = ",round(selModel()$runtime[1],digits=3),"s")
      }
    })
    
  }
)