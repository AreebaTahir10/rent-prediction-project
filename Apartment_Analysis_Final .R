
install.packages(c("dplyr","caret", "tidyr", "ggplot2", "VIM", "mice"))


# Load them
#library(caret)
library(dplyr)
library(tidyr)
library(ggplot2)
library(VIM)
library(mice)
library(corrplot)
library(randomForest)


setwd("C:/Users/ifrah/Downloads/r proj")



# Check the current working directory 
getwd()



# Load CSV into R
df <- read.csv("apartments.csv", sep = ";", stringsAsFactors = FALSE)



# View the first few rows
head(df)



# View the structure of the dataset
str(df)



# Column names
names(df)
VIM::aggr(df)



# Summary statistics
summary(df)



# Clean 'price' column: remove $ and , and convert to numeric
df$price <- gsub("[$,]", "", df$price)
df$price <- as.numeric(df$price)



# Clean 'square_feet' column if needed 
df$square_feet <- as.numeric(df$square_feet)

# Show rows where price couldn't be converted
df[is.na(df$price), "price_display"]

# Show rows where square_feet failed
df[is.na(df$square_feet), "square_feet"]


df$bedrooms <- as.numeric(df$bedrooms)
df$bathrooms <- as.numeric(df$bathrooms)
# -----------------------------

#1 Handle Missing Values

# Check how many missing (NA) values are in each column
colSums(is.na(df))

# Remove all rows that have any missing values
df <- na.omit(df)  # Removes rows with even one NA value

# 2 Remove Duplicate Rows 

# Remove duplicate rows if they exist
df <- df[!duplicated(df), ]

#  3: Detect and remove Outliers
boxplot(df$price, main = "Price Boxplot")
boxplot(df$square_feet, main = "Square Feet Boxplot")


# Outliers in 'price' column

#gets the 25th and 75th percentiles
Q1_price <- quantile(df$price, 0.25)
Q3_price <- quantile(df$price, 0.75)

# for calculating IQR
IQR_price <- Q3_price - Q1_price

# defines upper and lower bounds 

lower_price <- Q1_price - 1.5 * IQR_price
upper_price <- Q3_price + 1.5 * IQR_price

# Cap values below or above the bounds

df$price[df$price < lower_price] <- lower_price
df$price[df$price > upper_price] <- upper_price


# Outliers in sqft column

# Repeat the same process for square_feet

Q1_sqft <- quantile(df$square_feet, 0.25)
Q3_sqft <- quantile(df$square_feet, 0.75)
IQR_sqft <- Q3_sqft - Q1_sqft
lower_sqft <- Q1_sqft - 1.5 * IQR_sqft
upper_sqft <- Q3_sqft + 1.5 * IQR_sqft


df$square_feet[df$square_feet < lower_sqft] <- lower_sqft
df$square_feet[df$square_feet > upper_sqft] <- upper_sqft


# 4 Encode Categorical Variables

# Convert character/text columns to categorical (factors)

df$category <- as.factor(df$category)
df$currency <- as.factor(df$currency)
df$fee <- as.factor(df$fee)
df$has_photo <- as.factor(df$has_photo)
df$pets_allowed <- as.factor(df$pets_allowed)
df$price_type <- as.factor(df$price_type)
df$source <- as.factor(df$source)
df$state <- as.factor(df$state)
df$cityname <- as.factor(df$cityname)

#5: Scale Numerical Variables 

#  Manually scale square_feet using min-max

min_sqft <- min(df$square_feet)
max_sqft <- max(df$square_feet)

# This scales values between 0 and 1

df$square_feet_scaled <- (df$square_feet - min_sqft) / (max_sqft - min_sqft)

# built-in scale() function 

df$price_zscore <- scale(df$price)  
# Part 4 

# FEATURE SELECTION: RFE


# Define control method
control <- rfeControl(functions = lmFuncs, method = "cv", number = 5)

# rfe on numeric + some categorical 
rfe_result <- rfe(
  df[, c("square_feet", "bedrooms", "bathrooms")],
  df$price,
  sizes = c(1, 2, 3),
  rfeControl = control
)

# View selected features
print(rfe_result)
selected_features <- predictors(rfe_result)
print(selected_features)


#                           UNIVARIATE ANALYSIS 

# 1. Distribution of Rent Prices

ggplot(df, aes(x = price)) +geom_histogram(bins = 30) + labs(title = "Rent Price Distribution", x = "Price", y = "Frequency")

# 2. Distribution of Apartment Sizes

ggplot(df, aes(x = square_feet)) +geom_histogram(bins = 30) +labs(title = "Square Footage Distribution", x = "Square Feet", y = "Frequency")


# 3. Count of Listings per City (Top 10 only)

top_cities <- df %>% count(cityname, sort = TRUE) %>%head(10)

ggplot(top_cities, aes(x = cityname, y = n)) +geom_bar(stat = "identity") +labs(title = "Top 10 Cities by Number of Listings", x = "City", y = "Count")

#                           MULTIVARIATE ANALYSIS 

# 4. Relationship between Price and Size

ggplot(df, aes(x = square_feet, y = price)) +geom_point() +labs(title = "Price vs Square Feet", x = "Square Feet", y = "Price")


# 5. Price comparison based on Pet Policy


ggplot(df, aes(x = pets_allowed, y = price)) +geom_boxplot() +labs(title = "Price by Pet Policy", x = "Pets Allowed", y = "Price")
df %>%group_by(pets_allowed) %>%summarise(
    median_price = median(price),
    count = n()
  ) %>%
  arrange(desc(median_price))

# 6. Average Rent per State (Top 10)

avg_price_state <- df %>%
  filter(!is.na(state), state != "null") %>%   # This line handles BOTH cases
  group_by(state) %>%
  summarise(avg_price = mean(price)) %>%
  slice_max(avg_price, n = 10)

ggplot(avg_price_state, aes(x = reorder(state, avg_price), y = avg_price)) +geom_bar(stat = "identity", fill = "steelblue") +coord_flip() +
  labs(
    title = "Top 10 States by Average Rent",
    x = "State",
    y = "Average Rent"
  )

#                          CORRELATION ANALYSIS 

numeric_columns <- df %>%select(price, square_feet, bedrooms, bathrooms)

correlation_matrix <- cor(numeric_columns)

print(correlation_matrix)

corrplot(correlation_matrix, method = "color", addCoef.col = "black", tl.col = "black", tl.srt = 45, number.cex = 0.8)


# PART 5: PREDICTIVE MODELING 


# Step 1: Limit categories to top 10 to fix RF >53 levels error
top_cities <- names(sort(table(df$cityname), decreasing = TRUE))[1:10]
df$cityname <- ifelse(df$cityname %in% top_cities, df$cityname, "Other")
df$cityname <- as.factor(df$cityname)

top_states <- names(sort(table(df$state), decreasing = TRUE))[1:10]
df$state <- ifelse(df$state %in% top_states, df$state, "Other")
df$state <- as.factor(df$state)

top_categories <- names(sort(table(df$category), decreasing = TRUE))[1:10]
df$category <- ifelse(df$category %in% top_categories, df$category, "Other")
df$category <- as.factor(df$category)

top_fees <- names(sort(table(df$fee), decreasing = TRUE))[1:10]
df$fee <- ifelse(df$fee %in% top_fees, df$fee, "Other")
df$fee <- as.factor(df$fee)

# Step 2: Ensure required columns are factors
df$pets_allowed <- as.factor(df$pets_allowed)
df$has_photo <- as.factor(df$has_photo)

# Step 3: Split data
set.seed(42)
train_indices <- sample(1:nrow(df), 0.8 * nrow(df))
train_rf <- df[train_indices, ]
test_rf <- df[-train_indices, ]


# PART 5A: LINEAR REGRESSION


# Create dummy variables
dummy_vars <- model.matrix(
  price ~ square_feet + bedrooms + bathrooms + pets_allowed + state + has_photo + cityname + fee + category,
  data = df
)[, -1]

df_lm <- data.frame(price = df$price, dummy_vars)
train_lm <- df_lm[train_indices, ]
test_lm <- df_lm[-train_indices, ]

# Train linear model
model_lm <- lm(price ~ ., data = train_lm)
lm_predictions <- predict(model_lm, newdata = test_lm)
lm_rmse <- sqrt(mean((test_lm$price - lm_predictions)^2))

cat("Linear Regression RMSE:", round(lm_rmse, 2), "\n")

# Plot Linear Regression Actual vs Predicted
library(ggplot2)
ggplot(data.frame(Actual = test_lm$price, Predicted = lm_predictions), aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5, color = "green") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Linear Regression: Actual vs Predicted", x = "Actual Price", y = "Predicted Price") +
  theme_minimal()

# PART 5B: RANDOM FOREST 

# Check structure first
str(train_rf$price)             # should be numeric
summary(is.na(train_rf))        # make sure no NAs

# Run random forest
library(randomForest)
set.seed(101)
rf_model <- randomForest(
  price ~ square_feet + bedrooms + bathrooms + pets_allowed + state + has_photo + cityname + fee + category,
  data = train_rf,
  ntree = 100,
  na.action = na.omit
)

# Predictions
rf_predictions <- predict(rf_model, newdata = test_rf)

# Evaluate RMSE
rf_rmse <- sqrt(mean((test_rf$price - rf_predictions)^2))

cat("Random Forest RMSE:", round(rf_rmse, 2), "\n")

# -----------------------------
# Visualizations
# -----------------------------

# Actual vs Predicted
library(ggplot2)
ggplot(data.frame(Actual = test_rf$price, Predicted = rf_predictions), aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_abline(color = "red", linetype = "dashed") +
  labs(title = "Random Forest: Actual vs Predicted", x = "Actual Price", y = "Predicted Price") +
  theme_minimal()

# Residuals
residuals_rf <- test_rf$price - rf_predictions
ggplot(data.frame(Predicted = rf_predictions, Residuals = residuals_rf), aes(x = Predicted, y = Residuals)) +
  geom_point(alpha = 0.5, color = "purple") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Random Forest Residuals", x = "Predicted Price", y = "Residuals") +
  theme_minimal()

# Feature Importance
varImpPlot(rf_model, main = "Random Forest Feature Importance")



# PART 5C: CLASSIFICATION MODEL

# Create price category based on quantiles
price_quantiles <- quantile(df$price, probs = c(0.33, 0.66), na.rm = TRUE)
df$price_category <- cut(df$price,
                         breaks = c(-Inf, price_quantiles[1], price_quantiles[2], Inf),
                         labels = c("Low", "Medium", "High"))
df$price_category <- as.factor(df$price_category)

# Train-test split for classification
set.seed(123)
train_indices_cls <- sample(1:nrow(df), 0.8 * nrow(df))
train_cls <- df[train_indices_cls, ]
test_cls <- df[-train_indices_cls, ]

# Random Forest classification model
library(randomForest)
rf_classifier <- randomForest(
  price_category ~ square_feet + bedrooms + bathrooms + pets_allowed + state + has_photo +cityname +fee+category,
  data = train_cls,
  ntree = 100,
  na.action = na.omit
)

# Predictions and Evaluation
cls_predictions <- predict(rf_classifier, newdata = test_cls)
conf_mat <- table(Predicted = cls_predictions, Actual = test_cls$price_category)
accuracy <- sum(diag(conf_mat)) / sum(conf_mat)

cat("\nClassification Accuracy:", round(accuracy * 100, 2), "%\n")
cat("Confusion Matrix:\n")
print(conf_mat)

# Confusion Matrix Plot
library(ggplot2)
conf_mat_df <- as.data.frame(conf_mat)
names(conf_mat_df) <- c("Predicted", "Actual", "Freq")

ggplot(conf_mat_df, aes(x = Actual, y = Predicted, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 5) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title = "Confusion Matrix (Random Forest Classification)", x = "Actual", y = "Predicted") +
  theme_minimal()




# PART 5D: MODEL COMPARISON


# Print side-by-side
cat("\nModel RMSE Comparison:\n")
cat("-----------------------------\n")
cat("Linear Regression RMSE :", round(lm_rmse, 2), "\n")
cat("Random Forest RMSE     :", round(rf_rmse, 2), "\n")

# Visual comparison bar chart
rmse_df <- data.frame(
  Model = c("Linear Regression", "Random Forest"),
  RMSE = c(lm_rmse, rf_rmse)
)

ggplot(rmse_df, aes(x = Model, y = RMSE, fill = Model)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_fill_manual(values = c("Linear Regression" = "green", "Random Forest" = "blue")) +
  labs(title = "Model Comparison (RMSE)", x = "Model", y = "Root Mean Squared Error") +
  theme_minimal()
