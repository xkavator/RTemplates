library(xgboost)
library(Ckmeans.1d.dp)

set.seed(123)

data<-iris

classificationClasses <- levels(data$Species)
nClasses <- length(classificationClasses)

trainSetSize <- floor(0.75 * nrow(data))
trainIndex <- sample(seq_len(nrow(data)), size = trainSetSize)

trainingSet <- data[trainIndex, ]
testingSet <- data[-trainIndex, ]

trainingClassValues <- as.integer(trainingSet$Species)-1

trainMatrix <- xgb.DMatrix(as.matrix(trainingSet[,1:4]), label=trainingClassValues)
testMatrix <- xgb.DMatrix(as.matrix(testingSet[,1:4]))

param <- list("objective" = "multi:softprob",
              "eval_metric" = "mlogloss",
              "num_class" = nClasses)

nround <- 200
model <- xgboost(data = trainMatrix, param=param, nrounds=nround)

rawPrediction <- predict(model, testMatrix)
predictionMatrix <- t(matrix(rawPrediction, nrow=nClasses))
mostProbPrediction <- factor(apply(predictionMatrix, 1, which.max)-1, labels=classificationClasses)

outputData <-data.frame(testingSet, predictionMatrix, mostProbPrediction)
colnames(outputData)<-c(colnames(testingSet),classificationClasses, "prediction")

realVsPredicted<-table(outputData$Species,outputData$prediction)
xgbConfusionMatrix<-confusionMatrix(realVsPredicted)
print(xgbConfusionMatrix)

importanceMatrix <- xgb.importance(colnames(trainingSet[1:4]), model = model)
plot(xgb.plot.importance(importanceMatrix))
