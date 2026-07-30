<div align="center">

# 🏠 Rent Price Prediction

### Machine Learning Analysis of Apartment Rental Prices & Affordability

**Data Preprocessing • EDA • Regression • Classification • Rental Insights**

<br>

![R](https://img.shields.io/badge/R-4.x-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Machine Learning](https://img.shields.io/badge/Machine%20Learning-Regression%20%26%20Classification-6C63FF?style=for-the-badge)
![Random Forest](https://img.shields.io/badge/Random%20Forest-ML-2E8B57?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-2EA44F?style=for-the-badge)

</div>

---

## ⚡ Project at a Glance

| 🏠 Rental Data | 📊 Data Analysis | 🤖 Machine Learning |
|:---:|:---:|:---:|
| **~10,000 Listings** | **EDA & Visualization** | **Regression** |
| **22 Features** | **Correlation Analysis** | **Classification** |
| **Apartment Listings** | **City & Feature Analysis** | **Random Forest** |

---

## 📌 Overview

**Rent Price Prediction** is a machine learning project that analyzes apartment rental listings to understand the factors influencing monthly rent and predict rental prices.

The project uses the **UCI Machine Learning Repository — Apartments for Rent Classifieds** dataset and combines exploratory data analysis with both **regression** and **classification** approaches.

The complete workflow covers:

```text
📥 Dataset
    ↓
🧹 Data Preprocessing
    ↓
📊 Exploratory Data Analysis
    ↓
🔎 Feature Analysis
    ↓
🤖 Regression Modeling
    ↓
🏷️ Rent Classification
    ↓
💡 Rental Market Insights
```

---

# 🎯 Problem Statement

The project addresses several rental-market analysis problems using data-driven methods.

### 💰 01 — Rent Prediction

Predict the actual monthly rent of an apartment using characteristics such as:

- 📐 Square footage
- 🛏️ Bedrooms
- 🛁 Bathrooms
- 🐾 Pet policy
- 🏢 Apartment category
- 📍 Location
- 🌎 Latitude and longitude

### 🏷️ 02 — Rent Affordability Classification

Categorize apartment listings into:

```text
        Monthly Rent
             │
     ┌───────┼───────┐
     ▼       ▼       ▼
    LOW    MEDIUM   HIGH
```

The categories are created using rent-price quantiles.

### 🔮 03 — Future Market Segmentation

Clustering was identified as a potential future extension for grouping similar rental listings and discovering market segments.

---

# 🧾 Dataset Overview

### 📚 Dataset Source

**UCI Machine Learning Repository — Apartments for Rent Classifieds**

### 📊 Dataset Size

| Attribute | Details |
|---|---|
| 🏠 Listings | ~10,000 |
| 📋 Features | 22 columns |
| 🎯 Main Target | Monthly rent (`price`) |
| 📐 Property Information | Area, bedrooms, bathrooms |
| 🐾 Amenities | Pets, amenities |
| 📍 Location | Latitude, longitude |
| 🌎 Geographic Data | City and state |

---

## 🔑 Key Features

| Feature | Description |
|---|---|
| `price` | Monthly apartment rent |
| `square_feet` | Apartment size |
| `bedrooms` | Number of bedrooms |
| `bathrooms` | Number of bathrooms |
| `pets_allowed` | Pet policy |
| `amenities` | Available apartment amenities |
| `latitude` | Geographic latitude |
| `longitude` | Geographic longitude |
| `cityname` | City |
| `state` | State |
| `category` | Apartment/property category |

---

# 🧹 Data Preprocessing

Before modeling, the dataset was cleaned and transformed to improve the quality of the analysis.

### 🔧 Processing Steps

- 🗑️ Missing-value handling
- 📉 Outlier detection
- 📐 IQR-based outlier treatment
- 🔤 Categorical variable conversion
- 🔢 Numerical feature preparation
- ⚖️ Feature scaling
- 🧹 Dataset cleaning

### 📏 Scaling

Different transformations were applied to numerical variables:

- **Min-Max Scaling** → `square_feet`
- **Z-score Normalization** → `price`

### 🔄 Preprocessing Pipeline

```text
Raw Dataset
     │
     ▼
Missing Value Handling
     │
     ▼
Outlier Detection
     │
     ▼
IQR Treatment
     │
     ▼
Categorical Encoding
     │
     ▼
Feature Scaling
     │
     ▼
Clean Dataset
     │
     ▼
Machine Learning
```

---

# 📊 Exploratory Data Analysis

Exploratory analysis was performed to understand rental-price patterns and relationships between apartment characteristics.

## 🔹 Univariate Analysis

The analysis includes:

- 📈 Rent price distributions
- 📐 Apartment-size distributions
- 🏙️ City-wise listing counts
- 📊 Distribution of major apartment features

---

## 🔸 Multivariate Analysis

Relationships between multiple variables were explored through:

- 💰 Price vs Square Feet
- 🐾 Price distribution by pet policy
- 🏙️ Listing concentration by city
- 🛏️ Bedroom and bathroom relationships with rent

---

## 🔗 Correlation Analysis

The analysis found that:

> **Price showed a moderate positive correlation with square footage (~0.38).**

Bedrooms and bathrooms showed comparatively weaker relationships with price.

This indicates that **apartment size is an important factor in rental pricing**, while rent is influenced by multiple characteristics rather than a single variable.

---

# 🤖 Machine Learning

Two major machine learning tasks were implemented:

```text
                 🏠 APARTMENT DATA
                        │
              ┌─────────┴─────────┐
              ▼                   ▼
        💰 REGRESSION        🏷️ CLASSIFICATION
              │                   │
              ▼                   ▼
       Predict Rent          Rent Category
              │                   │
              ▼                   ▼
      Linear Regression     Random Forest
              │
              ▼
       Random Forest
```

---

# 💰 01 — Rent Price Regression

The regression models predict the actual monthly rent of an apartment.

## 📏 Linear Regression

Linear Regression was used as the baseline model.

### Approach

- One-hot encoding for categorical variables
- Numerical feature preprocessing
- Baseline rent prediction
- Evaluation using RMSE

---

## 🌲 Random Forest Regression

Random Forest Regression was used to capture non-linear relationships and interactions between apartment features.

### Advantages

- 🌳 Handles non-linear relationships
- 🔀 Captures feature interactions
- 📊 Provides feature importance
- 💪 More flexible than a basic linear model

### Result

**Random Forest Regression outperformed Linear Regression** in the project evaluation.

---

# 🏷️ 02 — Rent Classification

The classification task categorizes apartments into three affordability levels:

| Category | Description |
|---|---|
| 🟢 **Low** | Lower rent range |
| 🟡 **Medium** | Mid-range rent |
| 🔴 **High** | Higher rent range |

The categories are generated using **price quantiles**.

### 🌲 Random Forest Classification

Random Forest Classification was used to predict the rent category based on apartment characteristics.

The model was evaluated using:

- 🎯 Accuracy
- 🔲 Confusion Matrix
- 📊 Classification performance

---

# 📐 Model Evaluation

## Regression

The regression models were evaluated using:

| Metric | Purpose |
|---|---|
| **RMSE** | Measures average prediction error in the original scale |
| **Model Comparison** | Compares baseline and ensemble performance |

---

## Classification

The classification model was evaluated using:

| Metric | Purpose |
|---|---|
| **Accuracy** | Overall proportion of correct predictions |
| **Confusion Matrix** | Shows predicted vs actual categories |

---

# 🏆 Key Findings

### 💡 Finding 01 — Apartment Size Matters

Square footage showed a moderate positive relationship with rental price.

```text
More Square Feet
       │
       ▼
Higher Rental Price
```

---

### 💡 Finding 02 — Location Influences Rent

Rental prices vary across cities and geographic locations, demonstrating the importance of location-related features.

---

### 💡 Finding 03 — Random Forest Performs Better

Random Forest Regression provided better predictive performance than the baseline Linear Regression model.

---

### 💡 Finding 04 — Rent Categories Can Be Predicted

The classification model demonstrates that apartment characteristics can be used to categorize listings into different affordability levels.

---

# 📊 Feature Analysis

The project also explores which apartment characteristics contribute to rental pricing.

Key variables include:

```text
          🏠 RENT PRICE
               │
      ┌────────┼────────┐
      ▼        ▼        ▼
   📐 Area   🛏️ Beds  🛁 Baths
      │        │        │
      └────────┼────────┘
               │
       ┌───────┴───────┐
       ▼               ▼
   📍 Location     🐾 Amenities
```

---

# 💡 Recommendations

Based on the analysis, several improvements can strengthen future versions of the project.

### 🏙️ Add Location Features

Include:

- 🚇 Distance to public transport
- 🏫 Nearby schools
- 🏥 Nearby hospitals
- 🛍️ Nearby commercial areas
- 🛡️ Neighborhood safety

### 🏢 Add Property Features

Potential additions include:

- 🏗️ Building age
- 🏊 Swimming pool
- 🏋️ Gym
- 🚗 Parking availability
- 🌳 Outdoor facilities

### 🧹 Improve Missing-Value Handling

Instead of removing all rows containing missing values, future versions could explore:

- Mean/median imputation
- Mode imputation
- Model-based imputation
- Missing-value indicators

### 🌐 Future Application

A future version could integrate the trained model into a web application where users enter apartment characteristics and receive an estimated rental price.

---

# 🔮 Future Work

The project can be extended in several directions:

### 01 — 🧠 Advanced Models

Experiment with:

- XGBoost
- Gradient Boosting
- Support Vector Regression
- Neural Networks

### 02 — 🗺️ Geographic Analysis

Use latitude and longitude to build location-based rental insights.

### 03 — 🧩 Clustering

Apply unsupervised learning to discover apartment market segments.

```text
Apartment Listings
        │
        ▼
    Clustering
        │
   ┌────┼────┐
   ▼    ▼    ▼
Budget  Mid  Premium
Market  Market Market
```

### 04 — 🌐 Interactive Web Application

Develop a user-facing application for real-time rental price predictions.

---

# 🛠️ Technologies Used

| Category | Technologies |
|---|---|
| 💻 Language | R |
| 📊 Data Analysis | dplyr |
| 📈 Visualization | ggplot2 |
| 🌲 Machine Learning | randomForest |
| 🤖 Modeling | caret |
| 📓 Development | RStudio |
| 📚 Dataset | UCI ML Repository |

---

# 📁 Project Structure

<details>
<summary>📂 Click to expand</summary>

```text
rent-prediction-project/
│
├── 📄 Apartment_Analysis_Final.R
│       Main R analysis and modeling script
│
├── 📊 .RData
│       R workspace data
│
├── 📝 .Rhistory
│       R command history
│
└── 📖 README.md
        Project documentation
```

</details>

---

# 🚀 How to Run

## 1️⃣ Install R

Install **R** and optionally **RStudio**.

---

## 2️⃣ Install Required Packages

Run the following in R/RStudio:

```r
install.packages("ggplot2")
install.packages("dplyr")
install.packages("randomForest")
install.packages("caret")
```

---

## 3️⃣ Open the Project

Open:

```text
Apartment_Analysis_Final.R
```

in RStudio.

---

## 4️⃣ Run the Analysis

Execute the script to perform:

```text
📥 Data Loading
      ↓
🧹 Preprocessing
      ↓
📊 EDA
      ↓
🔎 Feature Analysis
      ↓
🤖 Model Training
      ↓
📈 Evaluation
      ↓
💡 Insights
```

---

# 📋 Project Checklist

- [x] 📥 Dataset exploration
- [x] 🧹 Data preprocessing
- [x] 📊 Exploratory data analysis
- [x] 🔗 Correlation analysis
- [x] 💰 Rent price regression
- [x] 🌲 Random Forest Regression
- [x] 🏷️ Rent classification
- [x] 🔲 Classification evaluation
- [x] 💡 Rental market insights
- [x] 🔮 Future-work recommendations

---

# 🎓 Learning Outcomes

This project provided practical experience with:

- 📊 Exploratory Data Analysis
- 🧹 Data preprocessing
- 🔤 Categorical variable handling
- 📐 Feature scaling
- 💰 Regression modeling
- 🏷️ Classification modeling
- 🌲 Random Forest algorithms
- 📈 Model evaluation
- 💡 Data-driven interpretation
- 🧠 Applying machine learning to real-world housing data

---

# 🏁 Conclusion

The **Rent Price Prediction** project demonstrates how machine learning can be applied to real-world apartment rental data to understand pricing patterns and build predictive models.

The analysis shows that rental prices are influenced by multiple factors, including **apartment size, location, and property characteristics**.

Random Forest provided stronger predictive performance than the baseline Linear Regression model, while classification demonstrated the potential to categorize listings into different affordability levels.

---

<div align="center">

## 🏠 Rent Price Prediction

### Turning Rental Data into Market Insights 📊🤖

**Explore → Clean → Analyze → Model → Predict**

<br>

⭐ **Built with R & Machine Learning**

</div>
