library(randomForest)
library(class)

set.seed(123)

data<-iris

trainSetSize <- floor(0.75 * nrow(data))
trainIndex <- sample(seq_len(nrow(data)), size = trainSetSize)

trainingSet <- data[trainIndex, ]
testingSet <- data[-trainIndex, ]

model <- randomForest(Species~Petal.Length+Petal.Width+Sepal.Length+Sepal.Width, data=data, subset=trainIndex, ntree=100, importance=TRUE)
prediction <- predict(model, testingSet, type = "response")

#Confusion matrix
testingSet$prediction <- prediction
realVsPredicted<-table(testingSet$Species,testingSet$prediction)
rfConfusionMatrix<-confusionMatrix(realVsPredicted)
print(rfConfusionMatrix)

#Variable importance
importance  <- importance(model)
imoprtanceSorted <- importance[order(importance[,"MeanDecreaseGini"], decreasing = TRUE),]
print("---------------------------------------------------------------------------------")
print("Variable Importance")
print(imoprtanceSorted)
