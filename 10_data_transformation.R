# Data Transformation
# Data transformation changes the scale or distribution of variables.


# What is Data Transformation?

# Data transformation applies a mathematical operation
# to change the representation of data.

# Common reasons:
# Reduce skewness
# Stabilize variance
# Make relationships more linear
# Improve visualization
# Meet assumptions of some statistical methods
# Put variables on comparable scales


# Important:

# Transformation should be guided by:
# Data distribution
# Scientific context
# Statistical method
# Interpretation

# Transformation is not automatically required for every dataset.


# Example Data

x <- c(
  1, 2, 3, 4, 5,
  6, 8, 10, 15, 25
)

x


# Summary

summary(x)


# Mean and Median

mean(x)
median(x)


# Histogram

hist(
  x,
  main = "Original Data",
  xlab = "Value"
)


# Skewness

# A distribution is right-skewed when
# a small number of large values extend the right tail.

# Biological measurements can often be right-skewed.


# Example of Strongly Skewed Data

expression <- c(
  1, 2, 2, 3, 3, 4,
  5, 7, 10, 15, 25, 50,
  100, 200
)

summary(expression)

hist(
  expression,
  main = "Skewed Expression Data",
  xlab = "Expression"
)


# Log Transformation

# Log transformation compresses large values
# more strongly than small values.

log_expression <- log(expression)

log_expression


# Histogram After Log Transformation

hist(
  log_expression,
  main = "Log-transformed Data",
  xlab = "log(Expression)"
)


# Compare Before and After

summary(expression)
summary(log_expression)


# Mean and Median Before Transformation

mean(expression)
median(expression)


# Mean and Median After Transformation

mean(log_expression)
median(log_expression)


# Natural Log

# log() uses the natural logarithm.

log(
  expression
)


# Log2 Transformation

# log2 is commonly used in biological data analysis.

log2_expression <- log2(expression)

log2_expression


# Histogram of log2-transformed Data

hist(
  log2_expression,
  main = "Log2-transformed Expression",
  xlab = "log2(Expression)"
)


# Log10 Transformation

log10_expression <- log10(expression)

log10_expression


# Compare Log Scales

log(expression)
log2(expression)
log10(expression)


# When Values Include Zero

# log(0) is undefined.

log(0)


# This produces:
# -Inf

# Therefore, a direct log transformation cannot be applied
# to data containing zero.


# Log1p Transformation

# log1p(x) calculates log(1 + x).

zero_data <- c(
  0, 1, 2, 5, 10, 20
)

log1p_data <- log1p(
  zero_data
)

log1p_data


# log1p is useful when zeros are present.

# However, adding a constant is not automatically appropriate
# for every biological dataset.

# The transformation should match the data-generating process.


# Negative Values

negative_data <- c(
  -5, -2, 0, 2, 5
)

negative_data


# Log transformation cannot directly be applied
# to negative values.

log(
  negative_data
)


# Do not simply add an arbitrary constant
# without understanding the meaning of the data.


# Square Root Transformation

# Square root transformation can reduce skewness,
# especially for count-like data.

count_data <- c(
  1, 2, 3, 5, 8,
  13, 20, 30, 45, 70
)

sqrt_count <- sqrt(
  count_data
)

sqrt_count


# Compare Distribution

hist(
  count_data,
  main = "Original Count Data",
  xlab = "Count"
)

hist(
  sqrt_count,
  main = "Square-root Transformed Data",
  xlab = "sqrt(Count)"
)


# Cube Root Transformation

cube_root_count <- count_data^(1 / 3)

cube_root_count


# Choosing a Transformation

# Common transformations:

# Log:
# Useful for strongly right-skewed positive data.

# Square root:
# Often useful for count-like data.

# Cube root:
# Can be useful for strongly skewed count-like data.

# Standardization:
# Useful when variables need a common scale.

# The appropriate transformation depends on the data
# and statistical objective.


# Standardization

# Standardization converts values into z-scores.

# Formula:
# z = (x - mean) / standard deviation


# Example

x <- c(
  10, 12, 15, 18, 20,
  22, 25, 30
)

mean_x <- mean(x)
sd_x <- sd(x)

z <- (x - mean_x) / sd_x

z


# Mean of Z-scores

mean(z)


# Standard Deviation of Z-scores

sd(z)


# R's scale() Function

z_scaled <- scale(x)

z_scaled


# Convert Matrix to Vector

as.vector(
  z_scaled
)


# Check Mean and SD

mean(
  as.vector(z_scaled)
)

sd(
  as.vector(z_scaled)
)


# Interpretation of Z-score

# z = 0:
# Value is at the mean.

# Positive z:
# Value is above the mean.

# Negative z:
# Value is below the mean.

# z = 2:
# Value is two standard deviations above the mean.

# z = -2:
# Value is two standard deviations below the mean.


# Why Standardize?

# Standardization is useful when variables
# are measured on different scales.

# Example:
# Age measured in years
# Biomarker measured in mg/dL
# Gene expression measured on another scale


# Example Variables

age <- c(
  20, 25, 30, 35, 40
)

biomarker <- c(
  100, 250, 400, 550, 700
)

z_age <- scale(age)
z_biomarker <- scale(biomarker)

z_age
z_biomarker


# Standardization Does Not Remove Biological Information

# Standardization changes the scale.

# It does not automatically:
# Remove outliers
# Make data normally distributed
# Remove batch effects
# Remove biological variation


# Min-Max Scaling

# Min-max scaling transforms values to a fixed range,
# commonly 0 to 1.

# Formula:
# x_scaled = (x - min(x)) / (max(x) - min(x))


x <- c(
  10, 20, 30, 40, 50
)

x_min <- min(x)
x_max <- max(x)

x_minmax <- (
  x - x_min
) / (
  x_max - x_min
)

x_minmax


# Check Range

min(x_minmax)
max(x_minmax)


# Manual Min-Max Scaling

minmax_scale <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

minmax_scale(x)


# Compare Standardization and Min-Max Scaling

z_scaled <- as.vector(
  scale(x)
)

minmax_scaled <- minmax_scale(x)

z_scaled
minmax_scaled


# Standardization vs Min-Max Scaling

# Standardization:
# Mean approximately 0
# Standard deviation approximately 1

# Min-max scaling:
# Minimum = 0
# Maximum = 1


# Scaling Does Not Mean Normalization

# Scaling changes the numerical range.

# Transformation can change the distribution.

# These concepts should not be treated as identical.


# Transformation and Regression

# Consider a skewed predictor.

x <- c(
  1, 2, 3, 5, 8,
  13, 21, 34, 55, 89
)

y <- c(
  2, 3, 4, 5,
  7, 8, 10, 13, 18, 25
)

plot(
  x,
  y,
  main = "Original Relationship",
  xlab = "X",
  ylab = "Y"
)


# Fit a Linear Model

model_original <- lm(
  y ~ x
)

summary(model_original)


# Transform Predictor

log_x <- log(x)

plot(
  log_x,
  y,
  main = "Log-transformed Predictor",
  xlab = "log(X)",
  ylab = "Y"
)


# Fit Regression with Transformed Predictor

model_log <- lm(
  y ~ log_x
)

summary(model_log)


# Transformation can sometimes make a relationship
# more suitable for a linear model.


# Transformation and Variance

# Some biological measurements show increasing variability
# as the mean increases.

# A transformation may help stabilize variance.

# Always examine residual plots after fitting the model.


# Transformation Before Statistical Testing

# Some statistical methods have assumptions about:
# Distribution
# Variance
# Linearity
# Residuals

# Transformation may sometimes help satisfy these assumptions.

# However, transformation should not be used simply
# to obtain a statistically significant p-value.


# Example: t-test Before Transformation

group1 <- c(
  10, 12, 15, 18, 20
)

group2 <- c(
  15, 20, 25, 30, 40
)

t.test(
  group1,
  group2
)


# Log Transformation

group1_log <- log(
  group1
)

group2_log <- log(
  group2
)

t.test(
  group1_log,
  group2_log
)


# Important:

# The interpretation changes after transformation.

# A difference on the log scale
# is not interpreted exactly like a difference
# on the original scale.


# Back Transformation

# For log-transformed data,
# exp() converts natural-log values back to the original scale.

log_value <- log(20)

log_value

exp(log_value)


# For log2:

log2_value <- log2(20)

log2_value

2^log2_value


# Biological Interpretation of Log2

# A difference of:
# +1 on log2 scale = 2-fold increase
# +2 on log2 scale = 4-fold increase
# -1 on log2 scale = 2-fold decrease


# Example

log2_fold_change <- 2

fold_change <- 2^log2_fold_change

fold_change


# Negative Log2 Fold Change

log2_fold_change <- -1

fold_change <- 2^log2_fold_change

fold_change


# Log Transformation in Gene Expression

# Gene expression values can span a large range.

expression <- c(
  2, 4, 8, 16,
  32, 64, 128
)

log2_expression <- log2(
  expression
)

expression
log2_expression


# Original Scale

plot(
  expression,
  main = "Gene Expression",
  ylab = "Expression",
  xlab = "Sample"
)


# Log2 Scale

plot(
  log2_expression,
  main = "Log2-transformed Expression",
  ylab = "log2(Expression)",
  xlab = "Sample"
)


# Important RNA-seq Note

# Raw RNA-seq count data should not simply be log-transformed
# and treated as normally distributed for every analysis.

# RNA-seq count data have specific statistical properties.

# Specialized methods such as DESeq2 or edgeR
# model count data using appropriate distributions.

# Transformation methods such as:
# VST
# rlog
# log-CPM

# may be used for visualization or exploratory analysis,
# depending on the workflow.


# Normalization vs Transformation

# Normalization aims to make measurements comparable
# across samples or observations.

# Transformation changes the mathematical representation
# or distribution of the data.

# These are different concepts.


# Example of Sample Scaling

sample_A <- c(
  10, 20, 30, 40
)

sample_B <- c(
  20, 40, 60, 80
)

sample_A
sample_B


# The second sample has approximately twice
# the values of the first sample.

# Scaling or normalization may be needed
# depending on why the difference exists.


# Batch Effects

# Transformation does NOT automatically remove batch effects.

# Batch effects may arise from:
# Different sequencing runs
# Different laboratories
# Different dates
# Different library preparation procedures
# Different instruments


# Batch effects require appropriate experimental design
# and statistical correction methods.


# Missing Values

x_missing <- c(
  10, 20, NA, 40, 50
)

x_missing


# Log transformation preserves NA values.

log(
  x_missing
)


# Scaling with Missing Values

scale(
  x_missing
)


# Always understand how missing values
# are handled before transformation.


# Compare Original and Transformed Summary

original <- expression

transformed <- log2(
  expression
)

summary(original)
summary(transformed)


# Compare Standard Deviation

sd(original)
sd(transformed)


# Compare Histograms

hist(
  original,
  main = "Original",
  xlab = "Expression"
)

hist(
  transformed,
  main = "Log2-transformed",
  xlab = "log2(Expression)"
)


# Choosing a Transformation

# Ask:

# 1. What type of data do I have?
# 2. Are values positive, zero, or negative?
# 3. Is the distribution strongly skewed?
# 4. Is variance related to the mean?
# 5. What statistical method will I use?
# 6. Does the transformation have biological meaning?
# 7. How will the transformed result be interpreted?


# Common Mistakes

# Mistake 1:
# Applying log transformation to zero or negative values
# without considering the consequences.

# Mistake 2:
# Assuming every dataset should be normally distributed.

# Mistake 3:
# Confusing normalization with transformation.

# Mistake 4:
# Standardizing data and assuming the distribution became normal.

# Mistake 5:
# Removing outliers simply because they look unusual.

# Mistake 6:
# Transforming data only because a p-value is not significant.

# Mistake 7:
# Forgetting that transformation changes interpretation.

# Mistake 8:
# Treating raw RNA-seq counts as ordinary continuous measurements
# without considering count-based methods.


# Data Transformation Workflow

# 1. Explore the original data.
# 2. Examine summary statistics.
# 3. Visualize the distribution.
# 4. Identify skewness and extreme values.
# 5. Understand the data-generating process.
# 6. Choose an appropriate transformation if needed.
# 7. Transform the data.
# 8. Re-examine the distribution.
# 9. Check statistical model assumptions.
# 10. Interpret results on the correct scale.
# 11. Back-transform results when appropriate.


# Key Takeaways

# Data transformation changes the representation of data.

# Log transformation can reduce right-skewness.

# log2 is commonly used in biological data analysis.

# log1p can handle zero values mathematically,
# but the scientific reason for the transformation still matters.

# Square-root transformation can be useful for some count-like data.

# Standardization converts observations to z-scores.

# Min-max scaling commonly converts values to the 0-1 range.

# Scaling and transformation are not the same thing.

# Transformation can affect statistical interpretation.

# RNA-seq count data require specialized statistical approaches.

# Transformation should be driven by the data,
# statistical method, and biological context.