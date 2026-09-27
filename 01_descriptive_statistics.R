# Descriptive Statistics

# What is Descriptive Statistics?
# Descriptive statistics are used to organize, summarize, and describe data.
# They help us understand the center, spread, and distribution of observations.

# Main components:
# Central tendency: mean, median, and mode
# Variability: range, variance, standard deviation, and IQR
# Position: quantiles and percentiles
# Distribution: histogram and boxplot


# Example numerical data
x <- c(10, 12, 15, 18, 20, 22, 25, 30, 35, 40)

# View the data
x

# Number of observations
length(x)


# Central Tendency
# Central tendency describes the typical or central value of a dataset.


# Mean

# Mean is the arithmetic average of all observations.
# Formula: mean = sum of observations / number of observations

mean(x)

# Mean is useful when the data are reasonably symmetric.
# Extreme values can strongly affect the mean.


# Median

# Median is the middle value after sorting the observations.
# For an even number of observations, it is the average of the two middle values.

median(x)

# Median is less affected by extreme values than the mean.
# It is useful for skewed data.


# Mode

# Mode is the most frequently occurring value.
# A dataset can have more than one mode.

x_mode <- c(10, 12, 12, 15, 18, 18, 18, 20)

table(x_mode)

# Identify the value with the highest frequency
names(which.max(table(x_mode)))

# Mode is mainly useful for understanding the most common observation.
# It is especially useful for categorical or discrete data.


# Comparing Mean and Median

# Mean and median can provide information about the shape of a distribution.

x_normal <- c(10, 11, 12, 13, 14, 15, 16)

mean(x_normal)
median(x_normal)

# Similar mean and median can occur in approximately symmetric data.


# Effect of an Extreme Value

# Create data with an extreme observation
x_outlier <- c(10, 11, 12, 13, 14, 15, 16, 100)

mean(x_outlier)
median(x_outlier)

# The extreme value increases the mean much more than the median.
# This demonstrates why median can be useful for skewed data.


# Measures of Variability

# Variability describes how spread out observations are around the center.


# Minimum

# Minimum is the smallest observation in the dataset.

min(x)


# Maximum

# Maximum is the largest observation in the dataset.

max(x)


# Range

# Range describes the distance between the minimum and maximum values.
# Formula: range = maximum - minimum

max(x) - min(x)

# R can also return the minimum and maximum directly.

range(x)


# Variance

# Variance measures the average squared deviation from the mean.
# Larger variance indicates greater variability.

var(x)


# Standard Deviation

# Standard deviation measures the typical spread around the mean.
# It is the square root of variance.

sd(x)

# Standard deviation is expressed in the same unit as the original data.
# A larger SD means observations are more spread out.


# Relationship Between Variance and Standard Deviation

# Variance is the square of standard deviation.

var(x)

sd(x)^2

# These two values should be approximately equal.


# Quantiles

# Quantiles divide ordered data into defined proportions.
# Common quantiles are the minimum, Q1, median, Q3, and maximum.

quantile(x)


# Quartiles

# Q1 represents the 25th percentile.
# Q2 represents the 50th percentile or median.
# Q3 represents the 75th percentile.

quantile(x, probs = c(0.25, 0.50, 0.75))


# Percentiles

# Percentiles indicate the position of an observation within the dataset.

quantile(
  x,
  probs = c(0.10, 0.25, 0.50, 0.75, 0.90)
)


# Interquartile Range

# IQR is the distance between Q1 and Q3.
# Formula: IQR = Q3 - Q1

IQR(x)

# IQR represents the spread of the middle 50% of observations.
# It is less affected by extreme values than the range.


# Five-number Summary

# Five-number summary contains minimum, Q1, median, Q3, and maximum.

fivenum(x)


# Summary Function

# summary() provides a quick descriptive overview.

summary(x)

# For numerical data, summary() reports:
# Minimum
# First quartile
# Median
# Mean
# Third quartile
# Maximum


# Comparing Measures of Variability

# Range uses only the minimum and maximum.
# IQR describes the middle 50% of observations.
# Standard deviation measures spread around the mean.

range(x)
IQR(x)
sd(x)


# Coefficient of Variation

# Coefficient of variation measures relative variability.
# Formula: CV = standard deviation / mean × 100

cv <- (sd(x) / mean(x)) * 100

cv

# CV is useful when comparing variability between measurements
# with different scales or means.


# Standard Error

# Standard error describes the uncertainty of the sample mean.
# Formula: SE = standard deviation / square root of sample size

n <- length(x)

se <- sd(x) / sqrt(n)

se

# Larger sample sizes generally produce smaller standard errors.
# SE is different from standard deviation.
# SD describes variability among observations.
# SE describes uncertainty in the estimated mean.


# Confidence Interval

# A confidence interval gives a range of plausible values for a population parameter.

mean_x <- mean(x)
se <- sd(x) / sqrt(length(x))

# Approximate 95% confidence interval
lower <- mean_x - 1.96 * se
upper <- mean_x + 1.96 * se

c(lower, upper)

# The interval becomes narrower when the standard error becomes smaller.
# This calculation is a basic normal-approximation approach.


# Missing Values

# Biological datasets often contain missing observations.

x_missing <- c(10, 12, 15, NA, 20, 22, NA, 30)

x_missing

# Check for missing values
is.na(x_missing)

# Count missing values
sum(is.na(x_missing))

# Count observed values
sum(!is.na(x_missing))

# Calculate mean while ignoring missing values
mean(x_missing, na.rm = TRUE)

# Calculate standard deviation while ignoring missing values
sd(x_missing, na.rm = TRUE)

# Summary also shows the number of missing observations
summary(x_missing)


# Group-wise Descriptive Statistics

# Biological studies often compare measurements between groups.

group <- c(
  "Control", "Control", "Control",
  "Disease", "Disease", "Disease"
)

value <- c(10, 12, 11, 18, 20, 22)

group_data <- data.frame(
  group,
  value
)

group_data


# Sample Size by Group

# Count observations in each group.

table(group_data$group)


# Mean by Group

# Calculate the mean for each group.

aggregate(
  value ~ group,
  data = group_data,
  FUN = mean
)


# Median by Group

# Calculate the median for each group.

aggregate(
  value ~ group,
  data = group_data,
  FUN = median
)


# Standard Deviation by Group

# Calculate SD for each group.

aggregate(
  value ~ group,
  data = group_data,
  FUN = sd
)


# IQR by Group

# Calculate IQR for each group.

aggregate(
  value ~ group,
  data = group_data,
  FUN = IQR
)


# Minimum and Maximum by Group

# Calculate minimum for each group.

aggregate(
  value ~ group,
  data = group_data,
  FUN = min
)

# Calculate maximum for each group.

aggregate(
  value ~ group,
  data = group_data,
  FUN = max
)


# Complete Group-wise Summary

# Generate a summary for each group.

by(
  group_data$value,
  group_data$group,
  summary
)


# Distribution of Data

# Distribution describes how observations are spread across possible values.

# Histogram: shows the frequency distribution of numerical data.

hist(x)


# Boxplot

# Boxplot summarizes the center, spread, and potential outliers.

boxplot(x)


# Boxplot Components

# The center line represents the median.
# The box represents the middle 50% of observations.
# The lower and upper edges represent Q1 and Q3.
# Whiskers show the main range of the data.
# Points beyond the whiskers may represent potential outliers.


# Group-wise Boxplot

# Compare the distribution of values between groups.

boxplot(
  value ~ group,
  data = group_data
)


# Descriptive Statistics for Biological Measurements

# Example gene expression measurements.

expression <- c(
  5.2, 5.8, 6.1, 6.4, 7.0,
  7.3, 7.8, 8.1, 8.5, 9.0
)

# Number of observations
length(expression)

# Mean expression
mean(expression)

# Median expression
median(expression)

# Standard deviation
sd(expression)

# Variance
var(expression)

# Interquartile range
IQR(expression)

# Summary statistics
summary(expression)


# Correlation Foundation

# Descriptive analysis can also explore relationships between variables.
# Detailed correlation analysis will be covered separately.

y <- c(
  11, 13, 16, 19, 21,
  24, 26, 31, 34, 39
)

# Pearson correlation measures the strength and direction of a linear relationship.

cor(x, y)

# Correlation test evaluates evidence for a non-zero population correlation.

cor.test(x, y)


# Important Interpretation Points

# Mean describes the average value.
# Median describes the central value of ordered observations.
# Mode describes the most frequent value.
# Range describes the full distance between minimum and maximum.
# Variance measures squared variability around the mean.
# SD describes spread in the original measurement unit.
# IQR describes the middle 50% of observations.
# SE describes uncertainty in the estimated mean.
# CI provides a range of plausible values for a population parameter.
# Histograms help examine the shape of a distribution.
# Boxplots help summarize spread and identify potential outliers.
# Group-wise statistics describe patterns within different biological groups.


# Statistical vs Biological Meaning

# A statistical summary describes the data but does not automatically explain
# whether a difference is biologically important.

# Biological interpretation should consider:
# Effect size
# Variability
# Sample size
# Experimental design
# Biological context
