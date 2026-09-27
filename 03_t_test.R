# t-test
# t-tests are used to compare means and evaluate evidence for differences.


# What is a t-test?

# A t-test compares a sample mean or two group means.
# It is commonly used when the outcome is numerical.

# Common types:
# One-sample t-test
# Independent two-sample t-test
# Paired t-test


# Example Data

control <- c(10, 11, 12, 13, 14)
disease <- c(16, 18, 19, 20, 21)

# Calculate group means
mean(control)
mean(disease)

# Calculate group standard deviations
sd(control)
sd(disease)

# Calculate sample sizes
length(control)
length(disease)


# One-sample t-test

# A one-sample t-test compares a sample mean with a reference value.

x <- c(10, 12, 14, 15, 16, 18, 20)

# Question:
# Is the population mean different from 15?

# H0: population mean = 15
# H1: population mean != 15

one_sample_test <- t.test(
  x,
  mu = 15
)

one_sample_test


# Extract Results

# Extract the t statistic
one_sample_test$statistic

# Extract degrees of freedom
one_sample_test$parameter

# Extract p-value
one_sample_test$p.value

# Extract confidence interval
one_sample_test$conf.int

# Extract estimated mean
one_sample_test$estimate


# One-sample t-test Interpretation

# A small p-value provides evidence that the population mean
# differs from the reference value.

# The confidence interval describes uncertainty around the estimated mean.


# One-sided One-sample t-test

# Test whether the mean is greater than 15.

t.test(
  x,
  mu = 15,
  alternative = "greater"
)

# Test whether the mean is less than 15.

t.test(
  x,
  mu = 15,
  alternative = "less"
)


# Two-sided Test

# By default, t.test() performs a two-sided test.

t.test(
  x,
  mu = 15,
  alternative = "two.sided"
)


# Independent Two-sample t-test

# An independent t-test compares the means of two independent groups.

control <- c(10, 11, 12, 13, 14)
disease <- c(16, 18, 19, 20, 21)

# Biological question:
# Is the mean measurement different between Control and Disease?

# H0: population means are equal.
# H1: population means are different.


# Welch Two-sample t-test

# Welch's t-test does not assume equal population variances.

two_sample_test <- t.test(
  control,
  disease
)

two_sample_test


# Extract the p-value

two_sample_test$p.value


# Extract the confidence interval

two_sample_test$conf.int


# Extract group means

mean(control)
mean(disease)


# Difference in Means

# Calculate the observed difference between group means.

mean(disease) - mean(control)


# Confidence Interval for Difference

# t.test() provides a confidence interval for the difference in means.

two_sample_test$conf.int


# Direction of Difference

# A positive difference means Disease has a larger sample mean.
# A negative difference means Disease has a smaller sample mean.

mean(disease) - mean(control)


# Equal Variance t-test

# var.equal = TRUE assumes equal population variances.

equal_variance_test <- t.test(
  control,
  disease,
  var.equal = TRUE
)

equal_variance_test


# Welch vs Equal-variance Test

# Welch's test is the default in R.
# Welch's test is generally useful when equal variance cannot be assumed.

t.test(
  control,
  disease
)

t.test(
  control,
  disease,
  var.equal = TRUE
)


# Paired t-test

# A paired t-test compares two measurements from the same subjects.

# Example:
# Gene expression measured before and after treatment.

before <- c(10, 12, 11, 14, 13, 15)
after  <- c(12, 15, 13, 17, 16, 18)

# The observations are paired by subject.

paired_data <- data.frame(
  subject = 1:6,
  before = before,
  after = after
)

paired_data


# Calculate individual differences

difference <- after - before

difference

# Mean change
mean(difference)

# Standard deviation of change
sd(difference)


# Paired t-test

paired_test <- t.test(
  before,
  after,
  paired = TRUE
)

paired_test


# Extract p-value

paired_test$p.value


# Extract confidence interval

paired_test$conf.int


# Extract mean difference

paired_test$estimate


# Paired vs Independent

# Paired test:
# Same subjects are measured twice.

# Independent test:
# Observations come from separate independent groups.

# Choosing the wrong structure can lead to incorrect inference.


# Visualizing Group Differences

# Boxplot for independent groups

boxplot(
  control,
  disease,
  names = c("Control", "Disease"),
  ylab = "Measurement"
)


# Boxplot for paired measurements

boxplot(
  before,
  after,
  names = c("Before", "After"),
  ylab = "Measurement"
)


# Connecting Paired Observations

plot(
  1:2,
  c(before[1], after[1]),
  type = "o",
  xaxt = "n",
  xlab = "",
  ylab = "Measurement"
)

axis(
  1,
  at = 1:2,
  labels = c("Before", "After")
)


# t-test Assumptions

# t-tests rely on assumptions about the data and study design.

# Important assumptions include:
# Numerical outcome
# Independent observations for independent-group tests
# Appropriate pairing for paired tests
# Approximate normality of the relevant data or differences
# No extreme influential outliers


# Checking Distribution

# Histogram for Control

hist(control)


# Histogram for Disease

hist(disease)


# Boxplot for Control

boxplot(control)


# Boxplot for Disease

boxplot(disease)


# Normality Test

# Shapiro-Wilk test evaluates evidence against normality.

shapiro.test(control)

shapiro.test(disease)


# Important:
# A normality test should not be the only basis for deciding whether
# a t-test is appropriate.

# Sample size, plots, outliers, study design, and scientific context
# should also be considered.


# Normality of Paired Differences

# For a paired t-test, the differences are the key quantity.

shapiro.test(difference)

hist(difference)

boxplot(difference)


# Effect Size

# Statistical significance does not describe the magnitude of a difference.

# Mean difference is a simple effect-size measure.

mean(disease) - mean(control)


# Cohen's d

# Cohen's d expresses the difference between means
# relative to the pooled standard deviation.

n1 <- length(control)
n2 <- length(disease)

s1 <- sd(control)
s2 <- sd(disease)

pooled_sd <- sqrt(
  ((n1 - 1) * s1^2 + (n2 - 1) * s2^2) /
    (n1 + n2 - 2)
)

cohens_d <- (mean(disease) - mean(control)) / pooled_sd

cohens_d


# Effect Size Interpretation

# Cohen's d describes the standardized magnitude of the difference.
# Its interpretation depends on the scientific context and study design.

# A statistically significant result can have a small effect size.
# A non-significant result can still have a potentially meaningful effect size.


# t-statistic

# The t-statistic describes the observed difference
# relative to its estimated standard error.

two_sample_test$statistic


# Degrees of Freedom

# Degrees of freedom depend on the test and variance assumptions.

two_sample_test$parameter


# Confidence Interval

# Confidence intervals show the range of values compatible
# with the estimated difference under the model.

two_sample_test$conf.int


# Statistical Decision

alpha <- 0.05

if (two_sample_test$p.value < alpha) {
  print("Reject H0")
} else {
  print("Fail to reject H0")
}


# Complete Independent t-test Workflow

control <- c(10, 11, 12, 13, 14)
disease <- c(16, 18, 19, 20, 21)

# Step 1: Define the biological question.
# Are the mean measurements different?

# Step 2: Define H0.
# H0: population means are equal.

# Step 3: Define H1.
# H1: population means are different.

# Step 4: Explore the data.

summary(control)
summary(disease)

boxplot(
  control,
  disease,
  names = c("Control", "Disease")
)

# Step 5: Perform the test.

result <- t.test(
  control,
  disease
)

result

# Step 6: Examine p-value.

result$p.value

# Step 7: Examine confidence interval.

result$conf.int

# Step 8: Calculate effect size.

mean(disease) - mean(control)


# Example with More Biological Data

# Simulated expression measurements for two conditions.

control_expression <- c(
  5.1, 5.4, 5.7, 5.8, 6.0,
  6.1, 6.3, 6.5, 6.7, 6.8
)

disease_expression <- c(
  6.5, 6.8, 7.0, 7.2, 7.4,
  7.6, 7.8, 8.0, 8.2, 8.5
)


# Explore the data

mean(control_expression)
mean(disease_expression)

sd(control_expression)
sd(disease_expression)

summary(control_expression)
summary(disease_expression)


# Visualize the data

boxplot(
  control_expression,
  disease_expression,
  names = c("Control", "Disease"),
  ylab = "Expression"
)


# Perform the t-test

expression_test <- t.test(
  control_expression,
  disease_expression
)

expression_test


# Extract important results

expression_test$estimate
expression_test$p.value
expression_test$conf.int
expression_test$statistic


# Report the Result

# A statistical report should include:
# Group means
# Mean difference
# Confidence interval
# Test statistic
# Degrees of freedom
# P-value
# Statistical test used


# Example reporting structure:
# "The mean measurement was higher in the Disease group than in the
# Control group. A Welch two-sample t-test was used to compare the groups.
# The estimated mean difference, confidence interval, and p-value should
# be reported together."


# Important Interpretation

# A t-test answers a specific statistical question about means.
# It does not establish biological causation.

# Statistical significance should be interpreted together with:
# Effect size
# Confidence interval
# Sample size
# Variability
# Experimental design
# Biological context


# Common Mistakes

# Mistake 1:
# Using an independent t-test for paired observations.

# Mistake 2:
# Treating repeated measurements from the same subject as independent.

# Mistake 3:
# Choosing a one-sided test after seeing the data.

# Mistake 4:
# Interpreting p < 0.05 as proof of biological importance.

# Mistake 5:
# Reporting only the p-value without the effect size.

# Mistake 6:
# Ignoring extreme observations and study design.


# Key Takeaways

# One-sample t-test compares one sample mean with a reference value.
# Independent t-test compares means from independent groups.
# Paired t-test compares measurements from matched observations.
# Welch's t-test does not require equal population variances.
# P-value measures evidence against the null hypothesis.
# Confidence intervals describe uncertainty around the estimated difference.
# Effect size describes the magnitude of a difference.
# Statistical significance and biological importance are not the same.