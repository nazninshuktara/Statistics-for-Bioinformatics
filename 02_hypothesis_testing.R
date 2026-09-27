# Hypothesis Testing
# Hypothesis testing is used to evaluate evidence about a population using sample data.


# What is Hypothesis Testing?

# A hypothesis is a statement about a population or biological process.
# Hypothesis testing provides a statistical framework for evaluating that statement.

# Example biological question:
# Is the mean expression level different between two biological conditions?

# We use sample data to evaluate evidence against a null hypothesis.


# Null and Alternative Hypotheses

# Null hypothesis (H0): assumes no difference, effect, or association.
# Alternative hypothesis (H1): proposes that a difference, effect, or association exists.

# Example:
# H0: Mean expression is the same between Control and Disease.
# H1: Mean expression is different between Control and Disease.


# Example Data

control <- c(10, 11, 12, 13, 14)
disease <- c(16, 18, 19, 20, 21)

mean(control)
mean(disease)


# Difference Between Group Means

# Calculate the observed difference between group means.

mean(disease) - mean(control)

# This is an observed difference in the sample.
# Hypothesis testing evaluates how compatible this difference is with H0.


# Statistical Significance

# Statistical significance asks whether the observed data provide
# sufficient evidence against the null hypothesis.

# A statistical test produces a test statistic and a p-value.


# Significance Level

# Alpha is the threshold used to define statistical significance.

alpha <- 0.05

alpha

# A commonly used significance level is 0.05.
# The significance level should be selected before interpreting the result.


# P-value

# A p-value measures how compatible the observed data are with H0.
# A small p-value indicates stronger evidence against H0.

# Important:
# A p-value is not the probability that H0 is true.
# A p-value is not the probability that the result occurred by chance.
# A p-value does not measure biological importance.


# Basic Interpretation of P-value

p_value <- 0.03

if (p_value < alpha) {
  print("Evidence against the null hypothesis")
} else {
  print("Insufficient evidence against the null hypothesis")
}

# If p < alpha, the result is commonly called statistically significant.
# If p >= alpha, we do not reject H0.


# Reject or Fail to Reject

# Statistical testing usually uses the following language:
# Reject H0 when the evidence is sufficiently strong.
# Fail to reject H0 when the evidence is not sufficiently strong.

# Avoid saying:
# "H0 is proven true."

# Failing to reject H0 does not prove that H0 is true.


# One-tailed and Two-tailed Tests

# Two-tailed test:
# Tests whether a parameter is different in either direction.

# H0: mean = reference value
# H1: mean != reference value


# One-tailed test:
# Tests for a difference in a specific direction.

# H0: mean >= reference value
# H1: mean < reference value

# Or:

# H0: mean <= reference value
# H1: mean > reference value


# Two-tailed tests are commonly used when both directions are scientifically relevant.


# Example: One-sample Hypothesis

# Suppose the reference population mean is 15.

x <- c(10, 12, 14, 15, 16, 18, 20)

mean(x)

# H0: population mean = 15
# H1: population mean != 15


# One-sample t-test

t.test(
  x,
  mu = 15
)


# Store the Test Result

test_result <- t.test(
  x,
  mu = 15
)

test_result


# Extract the P-value

test_result$p.value


# Extract the Confidence Interval

test_result$conf.int


# Extract the Estimated Mean

test_result$estimate


# Extract the Test Statistic

test_result$statistic


# Interpret the P-value

p_value <- test_result$p.value

if (p_value < alpha) {
  print("Reject H0")
} else {
  print("Fail to reject H0")
}


# Test Statistic

# A test statistic summarizes how far the observed result is
# from what would be expected under H0.

# For a one-sample t-test:
# t = (sample mean - hypothesized mean) / standard error

mean_x <- mean(x)
mu <- 15
se_x <- sd(x) / sqrt(length(x))

t_manual <- (mean_x - mu) / se_x

t_manual

# This should be close to the t statistic returned by t.test().


# Degrees of Freedom

# Degrees of freedom depend on the amount of independent information
# available for estimating variability.

# For a one-sample t-test:
# df = n - 1

n <- length(x)

df <- n - 1

df


# Type I Error

# Type I error occurs when H0 is rejected even though H0 is true.

# Example:
# Concluding that two biological groups differ when they actually do not.

# Alpha controls the maximum long-run Type I error rate under the test assumptions.


# Type II Error

# Type II error occurs when H0 is not rejected even though a real effect exists.

# Example:
# Failing to detect a real biological difference.

# Type II error is related to statistical power.


# Statistical Power

# Power is the probability of detecting an effect when a real effect exists.

# Power generally increases with:
# Larger sample size
# Larger effect size
# Lower variability
# Higher significance level


# Statistical Significance vs Biological Significance

# Statistical significance does not automatically mean biological importance.

# Example:
# A very small expression difference may produce a small p-value
# when the sample size is very large.

# A biologically meaningful effect may fail to reach statistical significance
# when the sample size is small or variability is high.

# Interpretation should consider:
# Effect size
# Confidence interval
# P-value
# Sample size
# Biological context


# Example: Small Difference

group_a <- c(100, 101, 100, 102, 101)
group_b <- c(103, 104, 103, 105, 104)

mean(group_a)
mean(group_b)

# The mean difference should always be considered alongside statistical evidence.


# Example: Larger Difference

group_a <- c(10, 11, 12, 10, 11)
group_b <- c(20, 21, 19, 22, 20)

mean(group_a)
mean(group_b)


# Confidence Interval and Hypothesis Testing

# A confidence interval provides information about the uncertainty
# around an estimated parameter.

test_result <- t.test(
  x,
  mu = 15
)

test_result$conf.int

# A confidence interval that excludes the null value is consistent
# with statistical significance in the corresponding two-sided test.


# Hypothesis Testing Workflow

# A simple hypothesis testing workflow:

# 1. Define the biological question.
# 2. Define H0.
# 3. Define H1.
# 4. Choose the significance level.
# 5. Select an appropriate statistical test.
# 6. Calculate the test statistic.
# 7. Obtain the p-value.
# 8. Examine the confidence interval.
# 9. Evaluate the effect size.
# 10. Interpret the result in biological context.


# Example Workflow

control <- c(10, 11, 12, 13, 14)
disease <- c(16, 18, 19, 20, 21)

# Step 1: Define the question
# Are the group means different?

# Step 2: Define H0
# H0: The population means are equal.

# Step 3: Define H1
# H1: The population means are different.

# Step 4: Choose alpha

alpha <- 0.05

# Step 5: Perform an appropriate test

result <- t.test(
  control,
  disease
)

result


# Step 6: Extract the p-value

result$p.value


# Step 7: Compare p-value with alpha

if (result$p.value < alpha) {
  print("Reject H0")
} else {
  print("Fail to reject H0")
}


# Step 8: Examine the confidence interval

result$conf.int


# Step 9: Examine group means

mean(control)
mean(disease)

# Statistical evidence should be interpreted together with the
# magnitude and direction of the observed difference.


# Important Statistical Terms

# Parameter:
# A numerical characteristic of a population.

# Statistic:
# A numerical characteristic calculated from a sample.

# Hypothesis:
# A statement about a population parameter.

# Null hypothesis:
# The hypothesis representing no difference or no effect.

# Alternative hypothesis:
# The hypothesis representing a difference or effect.

# Alpha:
# Predefined significance threshold.

# P-value:
# Measures compatibility of the observed data with H0.

# Test statistic:
# Numerical quantity used to evaluate evidence against H0.

# Confidence interval:
# Range describing uncertainty around an estimated parameter.

# Power:
# Probability of detecting a specified effect when it exists.


# Common Interpretation Mistakes

# Mistake 1:
# "p = 0.03 means there is a 3% probability that H0 is true."

# This interpretation is incorrect.

# Mistake 2:
# "p > 0.05 means there is no difference."

# This is too strong.
# It means that the data did not provide sufficient evidence to reject H0
# under the chosen test and assumptions.

# Mistake 3:
# "Statistically significant means biologically important."

# Statistical significance and biological importance are different concepts.

# Mistake 4:
# "A non-significant result proves there is no effect."

# A non-significant result does not prove that the effect is absent.


# Final Concept

# Hypothesis testing is a framework for evaluating evidence.
# It does not prove that a biological hypothesis is absolutely true or false.

# Good statistical interpretation combines:
# P-value
# Effect size
# Confidence interval
# Sample size
# Variability
# Experimental design
# Biological context
