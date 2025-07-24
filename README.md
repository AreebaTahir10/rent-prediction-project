# 🏠 Rent Price Prediction using Machine Learning

This project analyzes apartment listings to predict monthly rent prices and categorize rental affordability levels (low/medium/high) using machine learning. The project includes preprocessing, exploratory data analysis (EDA), regression, and classification modeling.

---

## 📋 Table of Contents

- [Problem Statement](#problem-statement)
- [Dataset Overview](#dataset-overview)
- [Preprocessing Steps](#preprocessing-steps)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
- [Modeling](#modeling)
- [Conclusion](#conclusion)
- [Recommendations](#recommendations)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [How to Run](#how-to-run)

---

## 📌 Problem Statement

This project aims to solve key housing market challenges using data-driven insights:

- **Regression**: Predict actual monthly rent using apartment features (area, bedrooms, amenities, etc.)
- **Classification**: Categorize listings into rent tiers (Low, Medium, High)
- **Clustering (Future work)**: Group listings for market segmentation

---

## 🧾 Dataset Overview

- **Source**: UCI ML Repository - “Apartments for Rent Classifieds”
- **Size**: ~10,000 listings × 22 columns
- **Key Features**:
  - `price`, `square_feet`, `bedrooms`, `bathrooms`, `pets_allowed`, `amenities`
  - Geolocation: `latitude`, `longitude`
  - Categorical: `cityname`, `state`, `category`

---

## 🧹 Preprocessing Steps

1. **Missing Values**: Removed rows with missing entries
2. **Outliers**: Handled using IQR method for `price` and `square_feet`
3. **Categorical Encoding**: Converted text categories to factors
4. **Scaling**:
   - Min-Max Scaling for `square_feet`
   - Z-score Normalization for `price`

---

## 📊 Exploratory Data Analysis (EDA)

### 🔹 Univariate Analysis:
- Histograms for rent price and apartment sizes
- City-wise listing counts

### 🔸 Multivariate Analysis:
- Price vs Square Feet scatter plot
- Price distribution by Pet Policy
- Top cities by number of listings

### 🔗 Correlation Analysis:
- `price` correlated moderately with `square_feet` (0.38)
- Weaker correlation with `bedrooms` and `bathrooms`

---

## 🤖 Modeling

### 1. **Linear Regression**
- One-hot encoded categorical variables
- Used as baseline model
- Evaluated using RMSE

### 2. **Random Forest Regression**
- Handled non-linearities & interactions
- Showed better performance than linear regression
- Provided feature importance ranking

### 3. **Random Forest Classification**
- Predicted rent tiers (Low/Medium/High) based on price quantiles
- Evaluated using confusion matrix and accuracy

---

## ✅ Conclusion

- **Data Cleaning** improved model input quality
- **EDA** revealed patterns in rent price, location, and pet policies
- **Random Forest Regression** outperformed Linear Regression
- **Classification model** helped identify affordability categories

---

## 💡 Recommendations

- Use Random Forest for both regression and classification tasks
- Introduce more features like:
  - Proximity to metro/public transport
  - Neighborhood safety
  - Building age
- Use imputation methods instead of row deletion for missing data
- Build a future **web app** to allow user-based rent predictions

---

## ⚙️ Technologies Used

- **Language**: R / Python (depending on your environment)
- **Libraries**:
  - `ggplot2`, `dplyr`, `randomForest`, `caret`
  - or `pandas`, `sklearn`, `seaborn` (if Python)
- **Tools**: Jupyter / RStudio

---


