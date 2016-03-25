set.seed(123)

data<-iris

trainSetSize <- floor(0.75 * nrow(data))
trainIndex <- sample(seq_len(nrow(data)), size = trainSetSize)

trainingSet <- data[trainIndex, ]
testingSet <- data[-trainIndex, ]

testingSet$prediction <- knn(trainingSet[,1:4], testingSet[,1:4], trainingSet[,5], k=5)
realVsPredicted<-table(testingSet$Species,testingSet$prediction)

rfConfusionMatrix<-confusionMatrix(realVsPredicted)
print(rfConfusionMatrix)
