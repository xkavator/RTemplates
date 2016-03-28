library(caret)

data <- iris
features <- data[-5]

features$linearCombination <- 2*features$Sepal.Width + 3*features$Sepal.Length
features$correlatedFeature <- 2*features$Sepal.Width
features$constant <- 2

linearCombinatinations <- findLinearCombos(features)
highlyCorrelatedFeatures <- findCorrelation(cor(features[1:6]), cutoff = 0.9, verbose = TRUE)
nearZeroVarianceFeatures <- nearZeroVar(features, saveMetrics = FALSE)
