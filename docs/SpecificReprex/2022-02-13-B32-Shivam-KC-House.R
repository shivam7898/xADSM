  # #Data: KC House: Decision Trees: 2022-Feb-13
  #install.packages("dplyr", dependencies = TRUE)
  # #Load Packages (Install Packages if there is any error when loading the packages)
  library("dplyr")
  library("tibble")
  library("readr")
  library("tidyr")
  library("lubridate")
  library("fastDummies")
  library("rpart")
  library("rpart.plot")
  library("rattle")
  library("randomForest")
  library("caret")
  #
  # #Import from Clipboard - KC House Data - [21613 x 21]
  xxKC <- read_delim(clipboard())
  #
  # #Drop NA | Get Age | Dummy | Rename | Filter | Factor | Relevel Most Frequent Reference | 
  # #Drop | Relocate |
  xfw <- xxKC %>% 
    drop_na() %>% 
    #mutate(across(date, as_date)) %>% 
    mutate(sold = year(date), age = sold - yr_built) %>% 
    mutate(iRenew = ifelse(yr_renovated == 0, 0, 1)) %>% 
    rename(beds = bedrooms, baths = bathrooms, sqAbove = sqft_above, sqLot = sqft_lot, 
           iWater = waterfront, iView = view) %>% 
    filter(beds != 33) %>% 
    mutate(across(c(beds, baths, floors, iWater, iView, condition, grade, iRenew), factor)) %>% 
    mutate(across(c(zipcode), factor)) %>% 
    mutate(across(beds, relevel, ref = "3")) %>% 
    mutate(across(baths, relevel, ref = "2")) %>% 
    mutate(across(floors, relevel, ref = "1")) %>% 
    mutate(across(condition, relevel, ref = "3")) %>% 
    mutate(across(grade, relevel, ref = "7")) %>% 
    mutate(across(zipcode, relevel, ref = "98103")) %>% 
    select(-c(id, lat, long, date, sold, yr_renovated, yr_built, sqft_living, sqft_living15, sqft_lot15)) %>% 
    select(-c(zipcode)) %>% 
    relocate(price)
  #
  # #Structure: tibble [21,610 x 13]
  str(xfw)
  #
  # #Partition Data
  #
  # #Set Seed
  set.seed(3)
  #
  # #Create Dummies | Replaced All NA in original data so no replacement in dummy columns |
  dum_xfw <- dummy_cols(xfw, remove_first_dummy = TRUE, remove_selected_columns = TRUE) 
  idx_xfw <- sample.int(n = nrow(dum_xfw), size = floor(0.8 * nrow(dum_xfw)), replace = FALSE)
  train_xfw <- dum_xfw[idx_xfw, ] 
  test_xfw  <- dum_xfw[-idx_xfw, ]
  #
  # #Structure: tibble [17,288 x 50]
  #str(train_xfw)
  dim(train_xfw)
  #
  # #Decision Trees: Convert Dummy Variables to Factor Variables of two levels "0", "1"
  train_xfw_ii <- train_xfw %>% mutate(across(starts_with(c(
    "beds_", "baths_", "floors_", "iWater_", "iView_", "condition_", "grade_", "iRenew_")), factor))
  test_xfw_ii <- test_xfw %>% mutate(across(starts_with(c(
    "beds_", "baths_", "floors_", "iWater_", "iView_", "condition_", "grade_", "iRenew_")), factor))
  #
  # #Decision Tree Model
  mod_tree <- rpart(price ~ ., data = train_xfw_ii, method = 'anova')
  #
  # #Print Model - Long Text so not executed here.
  #mod_tree
  #summary(mod_tree)
  #
  # #Plot Tree
  #fancyRpartPlot(mod_tree, cex = .5)
  #
  # #Predict
  res_tree <- test_xfw_ii %>% 
    mutate(CalY = predict(mod_tree, ., type  = "vector"), Y_Yc = price - CalY, MAPE = Y_Yc / price)
  #
  ii <- res_tree
  summary(ii$Y_Yc)
  #
  # #Correlation beween Actual and Predicted #70.2%
  cor(ii$price, ii$CalY)
  #
  # #RMSE: Root Mean Squared Error
  sqrt(mean((ii$Y_Yc)^2))
  #
  # #MAE: Mean Absolute Error (MAE)
  mean(abs(ii$Y_Yc))
  #
  # #MAPE: Mean Absolute Percentage Error
  mean(abs(ii$MAPE))
  #
  # #Accuracy 63.4%
  1 - mean(abs(ii$MAPE))
  #
  # #Setup Parallel Crossvalidation
  cv <- trainControl(method = "repeatedcv", number = 10, repeats = 5, allowParallel = TRUE)
  #
  # #Decision Tree Model with Crossvalidation
  # #Ignore the Warning message: 
  # #In nominalTrainWorkflow ... : There were missing values in resampled performance measures.
  mod_cv <- suppressWarnings(train(price ~ ., data = train_xfw_ii, method = 'rpart', 
                  trControl = cv, tuneLength = 10))
  #
  # #Print Model
  #mod_cv
  #
  # #Best Tuning Cp value = 0.01111514
  mod_cv$bestTune
  #
  # #Predict
  res_cv <- test_xfw_ii %>% 
    mutate(CalY = predict(mod_cv, ., type  = "raw"), Y_Yc = price - CalY, MAPE = Y_Yc / price)
  #
  ii <- res_cv
  summary(ii$Y_Yc)
  #
  # #Correlation 66.8% (decreased from 70.2 of mod_tree)
  cor(ii$price, ii$CalY)
  #
  # #RMSE: Root Mean Squared Error
  sqrt(mean((ii$Y_Yc)^2))
  #
  # #MAE: Mean Absolute Error (MAE)
  mean(abs(ii$Y_Yc))
  #
  # #MAPE: Mean Absolute Percentage Error
  mean(abs(ii$MAPE))
  #
  # #Accuracy 63.2% (decreased from 63.4% of mod_tree)
  1 - mean(abs(ii$MAPE))
  #
  # #Random Forest 
  if(FALSE) {# Random Forest is Horribly Slow. Run this code only if you hate your computer.
  # #NOTE: Following Parameter values are not too slow and explain 68.8% Var
    mod_frst <- randomForest(price ~ ., data = train_xfw_ii, ntrees = 500, sampsize = 5000, mtry = 8, nodesize = 10)
    print(mod_frst)
  #Call:
  # randomForest(formula = price ~ ., data = train_xfw_ii, ntrees = 500,      sampsize = 5000, mtry = 8, nodesize = 10) 
  #               Type of random forest: regression
  #                     Number of trees: 500
  #No. of variables tried at each split: 8
  #
  #          Mean of squared residuals: 41840392284
  #                    % Var explained: 68.85
  }
  #
  if(FALSE) {# Execute this code if you are trying to run the model on Test and following ERROR is observed
  # #ERROR: Type of predictors in new data do not match that of the training data.
    common <- intersect(names(train_xfw_ii), names(test_xfw_ii)) 
    for (p in common) { 
      if (class(train_xfw_ii[[p]]) == "factor") { 
        levels(test_xfw_ii[[p]]) <- levels(train_xfw_ii[[p]]) 
      } 
    }
  }
  #
  # #Accuracy of Random Forest
  if(FALSE){# Run This if mod_frst has been created
    res_frst <- test_xfw_ii %>% 
    mutate(CalY = predict(mod_frst, ., type  = "response"), Y_Yc = price - CalY, MAPE = Y_Yc / price)
  #
  summary(res_frst$Y_Yc)
  sqrt(mean((res_frst$Y_Yc)^2)) # 211970.5
  mean(abs(res_frst$Y_Yc))      # 127049.8
  mean(abs(res_frst$MAPE))      # 0.2690059
  #
  # #Accuracy 73.2% (increased from 63.4% of mod_tree and 63.2% of mod_cv)
  1 - mean(abs(res_frst$MAPE))  # 0.7309941
  }
  #
  if(FALSE) {# #Variable Importance
    randomForest::importance(mod_frst)
    varImpPlot(mod_frst, sort = TRUE, n.var = 20, main = 'Top 20 Variables')
    # how many times these variables are used in building the trees
    #varUsed(mod_frst) 
  }
  #
  # #Model Performance on Test Data
  # #mod_tree : 63.4%
  # #mod_cv   : 63.2%
  # #mod_frst : 73.1%
