# library(googlesheets4)
# library(googledrive)
# 
# drive_get("Бритье (Ответы)") %>%    read_sheet()
library(openxlsx)
input <- read.xlsx("shaving.xlsx")
data <- input[,c(2:5,9,10)]
names(data) <- c("y", "electric", "foam", "aftershave", "bladeuse", "times_in_row")
library(dplyr)
data <- data %>% mutate(electric = if_else(electric == "Электробритва роторная", TRUE, FALSE), foam = if_else(foam == "Да", TRUE, FALSE), aftershave = if_else(aftershave == "Да", TRUE, FALSE))

library(party)
fit <- ctree(y~., data = data, controls=ctree_control(mincriterion = 0.2, minsplit = 5, minbucket = 5))
plot(fit)
library(caret)
library(mlbench)

rpartFit <- train(data[1:35, -1],
                  data$y[1:35], 
                  "rpart", tuneLength = 9)
plsFit <- train(data[1:35, -1],
                data$y[1:35],
                "pls")
fit <- train(data[1:35, -1],
                data$y[1:35],
                "ctree")
rff <- train(data[1:35, -1],
             data$y[1:35],
             "rf")

predVals <- extractPrediction(list(rpartFit, plsFit, fit,rff), 
                              testX = data[1:35, -1],
                              testY = data$y[1:35], 
                              unkX = data[36:48, -1])

plotObsVsPred(predVals)
