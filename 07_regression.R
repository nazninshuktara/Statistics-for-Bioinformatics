# Linear Regression
# Linear regression models the relationship between a numerical outcome and one or more predictors.


# What is Linear Regression?

# Linear regression is used to describe and quantify
# the relationship between variables.

# Example biological questions:
# Does gene expression change with age?
# Is disease severity associated with a biomarker?
# Can one measurement predict another measurement?


# Regression Variables

# Outcome variable:
# The variable we want to explain or predict.

# Predictor variable:
# The variable used to explain or predict the outcome.

# Example:
# Gene expression = outcome
# Age = predictor


# Example Data

age <- c(
  20, 25, 30, 35, 40,
  45, 50, 55, 60, 65
)

expression <- c(
  5.1, 5.4, 5.8, 6.0, 6.4,
  6.7, 7.0, 7.3, 7.7, 8.0
)

data <- data.frame(
  age,
  expression
)

data


# Explore the Data

summary(data)

# Scatter plot

plot(
  age,
  expression,
  xlab = "Age",
  ylab = "Gene Expression",
  main = "Gene Expression and Age"
)


# Correlation Before Regression

# Correlation describes the strength of linear association.

cor(
  age,
  expression
)


# Simple Linear Regression

# A simple linear regression contains one predictor.

# Model:
# Y = intercept + slope × X + error

# Y = outcome
# X = predictor
# intercept = expected Y when X = 0
# slope = expected change in Y for a one-unit increase in X


# Fit the Model

model <- lm(
  expression ~ age,
  data = data
)

model


# Model Summary

summary(model)


# Understanding the Regression Output

# The output contains:
# Coefficients
# Standard errors
# t-statistics
# P-values
# Residual standard error
# R-squared
# Adjusted R-squared
# F-statistic


# Regression Coefficients

# Extract all coefficients.

coef(model)


# Extract the intercept

coef(model)[1]


# Extract the slope

coef(model)[2]


# Interpretation of the Slope

# The slope represents the expected change in the outcome
# for a one-unit increase in the predictor.

# Example:
# If slope = 0.06,
# expression is expected to increase by 0.06 units
# for each one-unit increase in age.


# Interpretation of the Intercept

# The intercept is the predicted outcome when the predictor equals zero.

# The intercept may not always have a meaningful biological interpretation
# if zero is outside the observed range or has no biological meaning.


# Regression Equation

intercept <- coef(model)[1]
slope <- coef(model)[2]

intercept
slope


# Predicted Expression

# Calculate fitted values from the model.

predicted <- predict(model)

predicted


# Add Predictions to the Data

data$predicted_expression <- predicted

data


# Residuals

# Residual = observed value - predicted value

residuals_model <- residuals(model)

residuals_model


# Add Residuals to the Data

data$residuals <- residuals_model

data


# Residual Sum

# Residuals should sum approximately to zero
# in ordinary least squares regression with an intercept.

sum(residuals_model)


# Plot Regression Line

plot(
  age,
  expression,
  xlab = "Age",
  ylab = "Gene Expression",
  main = "Linear Regression"
)

abline(
  model
)


# Confidence Interval for Regression Coefficients

confint(model)


# Confidence Interval for Slope

confint(
  model,
  "age"
)


# Confidence Interval for Intercept

confint(
  model,
  "(Intercept)"
)


# Statistical Test for the Slope

# The coefficient p-value tests:
# H0: slope = 0
# H1: slope != 0

summary(model)$coefficients


# Extract Slope P-value

slope_p <- summary(model)$coefficients[
  "age",
  "Pr(>|t|)"
]

slope_p


# Statistical Decision

alpha <- 0.05

if (slope_p < alpha) {
  print("Evidence of an association between age and expression")
} else {
  print("Insufficient evidence of an association")
}


# Important:
# A significant slope indicates evidence of association under the model.
# It does not establish causation.


# R-squared

# R-squared describes the proportion of outcome variation
# explained by the model.

summary(model)$r.squared


# Adjusted R-squared

# Adjusted R-squared accounts for the number of predictors in the model.

summary(model)$adj.r.squared


# R-squared Interpretation

# R-squared ranges from 0 to 1 in ordinary linear regression.

# R-squared closer to 1:
# More variation in the outcome is explained by the model.

# R-squared closer to 0:
# Less variation is explained by the model.

# A high R-squared does not prove that the model is biologically correct.


# F-statistic

# The F-test evaluates whether the regression model
# explains more variation than a model with no predictors.

summary(model)$fstatistic


# Overall Model P-value

# Extract the overall F-test p-value.

model_summary <- summary(model)

f_stat <- model_summary$fstatistic

model_p <- pf(
  f_stat[1],
  f_stat[2],
  f_stat[3],
  lower.tail = FALSE
)

model_p


# Simple Regression and Correlation

# In simple linear regression with one predictor,
# the test of the slope is closely related to the Pearson correlation test.

cor.test(
  age,
  expression
)

summary(model)


# Predictions

# Predict the expression value for a new age.

new_data <- data.frame(
  age = c(30, 50, 70)
)

predict(
  model,
  newdata = new_data
)


# Prediction with Confidence Interval

# Confidence interval for the mean predicted outcome.

predict(
  model,
  newdata = new_data,
  interval = "confidence"
)


# Prediction Interval

# Prediction interval describes uncertainty for an individual future observation.

predict(
  model,
  newdata = new_data,
  interval = "prediction"
)


# Confidence Interval vs Prediction Interval

# Confidence interval:
# Uncertainty around the mean response.

# Prediction interval:
# Uncertainty around an individual future observation.

# Prediction intervals are generally wider.


# Regression Assumptions

# Important assumptions include:
# Linear relationship
# Independent observations
# Constant variance of residuals
# Approximately normal residuals
# No highly influential observations


# Checking Linearity

# Plot the observed data and regression line.

plot(
  age,
  expression
)

abline(
  model
)

# The relationship should be reasonably described by a straight line.


# Residual vs Fitted Plot

# This plot helps assess linearity and constant variance.

plot(
  model,
  which = 1
)


# What to Look For

# Residuals should generally be scattered around zero.
# Strong curves may indicate non-linearity.
# Increasing or decreasing spread may indicate non-constant variance.


# Normal Q-Q Plot

# Q-Q plot assesses whether residuals are approximately normal.

plot(
  model,
  which = 2
)


# Residual Histogram

hist(
  residuals(model)
)


# Normality Test

# Shapiro-Wilk test evaluates evidence against normality.

shapiro.test(
  residuals(model)
)

# The test should not be used alone.
# Examine the Q-Q plot and study context as well.


# Scale-Location Plot

# This plot helps assess whether residual variability is approximately constant.

plot(
  model,
  which = 3
)


# Residuals vs Leverage

# This plot helps identify potentially influential observations.

plot(
  model,
  which = 5
)


# Influence Measures

# Cook's distance identifies observations that may strongly influence the model.

cooks_distance <- cooks.distance(model)

cooks_distance


# Plot Cook's Distance

plot(
  cooks_distance,
  type = "h",
  xlab = "Observation",
  ylab = "Cook's Distance"
)


# Influential Observations

# Potentially influential observations should be investigated.
# They should not automatically be removed.


# Example with a Potential Outlier

age_outlier <- c(
  20, 25, 30, 35, 40,
  45, 50, 55, 60, 65
)

expression_outlier <- c(
  5.1, 5.4, 5.8, 6.0, 6.4,
  6.7, 7.0, 7.3, 7.7, 12
)

outlier_data <- data.frame(
  age = age_outlier,
  expression = expression_outlier
)

outlier_model <- lm(
  expression ~ age,
  data = outlier_data
)

summary(outlier_model)

plot(
  age_outlier,
  expression_outlier
)

abline(
  outlier_model
)


# Do Not Automatically Remove Outliers

# An unusual observation may represent:
# Measurement error
# Data-entry error
# Technical problem
# Biological variation
# A real extreme biological observation

# Investigate the observation before deciding how to handle it.


# Multiple Linear Regression

# Multiple regression uses more than one predictor.

# Example:
# Gene expression may depend on age and disease status.

age <- c(
  20, 25, 30, 35, 40,
  45, 50, 55, 60, 65
)

expression <- c(
  5.1, 5.4, 5.8, 6.0, 6.4,
  6.7, 7.0, 7.3, 7.7, 8.0
)

sex <- factor(
  c(
    "F", "M", "F", "M", "F",
    "M", "F", "M", "F", "M"
  )
)

multiple_data <- data.frame(
  age,
  sex,
  expression
)

multiple_data


# Fit a Multiple Regression Model

multiple_model <- lm(
  expression ~ age + sex,
  data = multiple_data
)

summary(multiple_model)


# Interpretation

# The age coefficient represents the expected change in expression
# per unit increase in age while accounting for sex in the model.

# The sex coefficient represents the expected difference between
# the reference group and the other sex category while accounting for age.


# Categorical Predictors

# R automatically creates indicator variables for factor predictors.

levels(sex)


# Change the Reference Category

multiple_data$sex <- relevel(
  multiple_data$sex,
  ref = "M"
)

multiple_model_reference <- lm(
  expression ~ age + sex,
  data = multiple_data
)

summary(multiple_model_reference)


# Continuous and Categorical Predictors

# Regression can combine numerical and categorical predictors.

# Example:
# expression ~ age + sex


# Confounding

# A confounder is a variable related to both the predictor
# and the outcome that can distort their observed association.

# Including relevant confounders in a regression model
# can help estimate an association while accounting for them.

# Statistical adjustment does not automatically prove causality.


# Interaction

# An interaction occurs when the association between one predictor
# and the outcome depends on another variable.

# Example:
# The effect of treatment may differ by sex.

# Interaction model:
# outcome ~ treatment + sex + treatment:sex


# Example Interaction Model

treatment <- factor(
  c(
    "Control", "Control", "Control", "Control", "Control",
    "Treatment", "Treatment", "Treatment", "Treatment", "Treatment"
  )
)

sex <- factor(
  c(
    "F", "M", "F", "M", "F",
    "F", "M", "F", "M", "F"
  )
)

expression <- c(
  5.0, 5.2, 5.1, 5.3, 5.2,
  6.0, 6.8, 6.2, 7.0, 6.4
)

interaction_data <- data.frame(
  treatment,
  sex,
  expression
)


# Fit Interaction Model

interaction_model <- lm(
  expression ~ treatment * sex,
  data = interaction_data
)

summary(interaction_model)


# The * operator includes:
# Main effect of treatment
# Main effect of sex
# Treatment × sex interaction


# Model Comparison

# Compare a model with and without an interaction.

model_without_interaction <- lm(
  expression ~ treatment + sex,
  data = interaction_data
)

model_with_interaction <- lm(
  expression ~ treatment * sex,
  data = interaction_data
)

anova(
  model_without_interaction,
  model_with_interaction
)


# Regression and Biological Interpretation

# Regression can quantify associations between biological variables.

# Example:
# A positive age coefficient indicates that the predicted outcome
# increases as age increases, after accounting for other predictors.

# The coefficient alone should not be interpreted without considering:
# Units
# Confidence interval
# P-value
# Model assumptions
# Study design
# Confounding
# Biological context


# Statistical vs Biological Significance

# A statistically significant coefficient may represent
# a very small biological effect.

# A biologically meaningful association may be uncertain
# when the sample size is small or variability is high.

# Always consider effect size and confidence interval alongside p-value.


# Regression Workflow

# 1. Define the scientific question.
# 2. Define the outcome variable.
# 3. Identify the predictor variables.
# 4. Explore the data.
# 5. Visualize relationships.
# 6. Fit the regression model.
# 7. Examine coefficients.
# 8. Examine confidence intervals and p-values.
# 9. Evaluate R-squared when appropriate.
# 10. Check model assumptions.
# 11. Investigate influential observations.
# 12. Consider confounding and interactions.
# 13. Interpret results in biological context.


# Common Mistakes

# Mistake 1:
# Assuming regression proves causation.

# Mistake 2:
# Ignoring non-linearity.

# Mistake 3:
# Ignoring influential observations.

# Mistake 4:
# Reporting only the p-value.

# Mistake 5:
# Interpreting the intercept without considering whether
# the predictor value of zero is meaningful.

# Mistake 6:
# Including many predictors without considering study design
# or sample size.

# Mistake 7:
# Treating a high R-squared as proof of a good biological model.


# Key Takeaways

# Linear regression quantifies relationships between variables.
# The outcome is modeled as a function of predictor variables.
# The slope describes the expected change in the outcome per unit change
# in a predictor.
# The intercept is the predicted outcome when predictors equal zero.
# R-squared describes the proportion of outcome variation explained by the model.
# Confidence intervals describe uncertainty around coefficients.
# P-values evaluate evidence against a zero coefficient.
# Residual diagnostics help assess model assumptions.
# Multiple regression allows adjustment for additional predictors.
# Interaction terms test whether an association differs across groups.
# Regression describes statistical associations and does not by itself establish causation.