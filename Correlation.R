library(corrplot)

data <-iris
corrMatrix <- cor(data[,1:4])
corrplot(corrMatrix, method = "circle")