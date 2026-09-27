# Correlation
# Correlation measures the strength and direction of association between variables.


# What is Correlation?

# Correlation describes how two numerical variables change together.

# Example biological questions:
# Does gene expression increase when another gene's expression increases?
# Is age associated with a clinical measurement?
# Is sequencing depth related to detected gene count?

# Correlation describes association.
# It does not establish causation.


# Example Data

x <- c(10, 12, 15, 18, 20, 22, 25, 30, 35, 40)

y <- c(11, 13, 16, 19, 21, 24, 26, 31, 34, 39)

# View the data

x
y


# Scatter Plot

# Scatter plot shows the relationship between two numerical variables.

plot(
  x,
  y,
  xlab = "X",
  ylab = "Y",
  main = "Relationship Between X and Y"
)


# Pearson Correlation

# Pearson correlation measures the strength and direction
# of a linear relationship between two numerical variables.

cor(
  x,
  y,
  method = "pearson"
)


# Pearson Correlation Coefficient

# Pearson correlation ranges from -1 to +1.

# r = +1:
# Perfect positive linear relationship.

# r = 0:
# No linear correlation.

# r = -1:
# Perfect negative linear relationship.


# Positive Correlation

x_positive <- c(1, 2, 3, 4, 5)
y_positive <- c(2, 4, 6, 8, 10)

cor(
  x_positive,
  y_positive
)

plot(
  x_positive,
  y_positive,
  xlab = "X",
  ylab = "Y",
  main = "Positive Correlation"
)


# Negative Correlation

x_negative <- c(1, 2, 3, 4, 5)
y_negative <- c(10, 8, 6, 4, 2)

cor(
  x_negative,
  y_negative
)

plot(
  x_negative,
  y_negative,
  xlab = "X",
  ylab = "Y",
  main = "Negative Correlation"
)


# Weak Correlation

set.seed(123)

x_weak <- 1:20
y_weak <- rnorm(
  20,
  mean = 10,
  sd = 3
)

cor(
  x_weak,
  y_weak
)

plot(
  x_weak,
  y_weak,
  xlab = "X",
  ylab = "Y",
  main = "Weak Correlation"
)


# Interpreting Correlation

# The sign describes direction.
# Positive: variables tend to increase together.
# Negative: one tends to increase as the other decreases.

# The absolute value describes the strength of linear association.

# Values closer to 1 or -1 indicate stronger linear association.
# Values closer to 0 indicate weaker linear association.

# There is no universal cutoff that defines a "strong" correlation.
# Interpretation depends on the scientific context.


# Pearson Correlation Test

# cor.test() tests whether the population correlation
# differs from zero.

cor.test(
  x,
  y,
  method = "pearson"
)


# Store the Test Result

pearson_test <- cor.test(
  x,
  y,
  method = "pearson"
)

pearson_test


# Extract Correlation Coefficient

pearson_test$estimate


# Extract P-value

pearson_test$p.value


# Extract Confidence Interval

pearson_test$conf.int


# Extract Test Statistic

pearson_test$statistic


# Extract Degrees of Freedom

pearson_test$parameter


# P-value Interpretation

# A small p-value provides evidence against the null hypothesis
# that the population correlation is zero.

# A significant correlation does not necessarily mean
# that the correlation is biologically important.


# Confidence Interval

# The confidence interval describes uncertainty around
# the estimated population correlation.

pearson_test$conf.int


# Pearson Correlation Assumptions

# Important considerations include:
# Numerical variables
# Independent observations
# Approximately linear relationship
# Extreme outliers can strongly influence Pearson correlation

# Always inspect the data visually before interpreting correlation.


# Checking Linearity

plot(
  x,
  y,
  xlab = "X",
  ylab = "Y"
)

# A roughly straight-line pattern supports the use of Pearson correlation.


# Outliers and Correlation

x_outlier <- c(
  1, 2, 3, 4, 5,
  6, 7, 8, 9, 20
)

y_outlier <- c(
  1, 2, 3, 4, 5,
  6, 7, 8, 9, 2
)

cor(
  x_outlier,
  y_outlier
)

plot(
  x_outlier,
  y_outlier,
  xlab = "X",
  ylab = "Y",
  main = "Potential Influence of an Outlier"
)


# Outliers can substantially change the correlation coefficient.
# Therefore, correlation should not be interpreted without inspecting the data.


# Spearman Correlation

# Spearman correlation measures the strength and direction
# of a monotonic relationship using ranked data.

cor(
  x,
  y,
  method = "spearman"
)


# Spearman Correlation Test

spearman_test <- cor.test(
  x,
  y,
  method = "spearman"
)

spearman_test


# Pearson vs Spearman

# Pearson:
# Measures linear association.

# Spearman:
# Measures monotonic association based on ranks.

# Spearman can be useful when:
# Data are not normally distributed.
# The relationship is monotonic but not linear.
# Variables are ordinal or ranks are meaningful.


# Linear vs Monotonic Relationship

# A linear relationship follows an approximately straight line.

# A monotonic relationship consistently moves in one direction,
# but the rate of change does not have to be constant.


# Example of a Monotonic but Nonlinear Relationship

x_curve <- 1:10

y_curve <- x_curve^2

plot(
  x_curve,
  y_curve,
  xlab = "X",
  ylab = "Y",
  main = "Monotonic Nonlinear Relationship"
)

# Pearson correlation

cor(
  x_curve,
  y_curve,
  method = "pearson"
)

# Spearman correlation

cor(
  x_curve,
  y_curve,
  method = "spearman"
)


# Correlation Matrix

# A correlation matrix contains correlations between multiple variables.

data_matrix <- data.frame(
  gene_A = c(10, 12, 15, 18, 20),
  gene_B = c(11, 13, 16, 19, 21),
  gene_C = c(20, 18, 15, 12, 10),
  gene_D = c(5, 7, 8, 10, 12)
)

data_matrix


# Calculate Pearson correlation matrix

cor(
  data_matrix,
  method = "pearson"
)


# Calculate Spearman correlation matrix

cor(
  data_matrix,
  method = "spearman"
)


# Missing Values in Correlation

data_missing <- data.frame(
  x = c(10, 12, 15, NA, 20),
  y = c(11, 13, 16, 18, NA)
)

data_missing


# Correlation with complete observations only

cor(
  data_missing$x,
  data_missing$y,
  use = "complete.obs"
)


# Pairwise Complete Observations

cor(
  data_missing,
  use = "pairwise.complete.obs"
)


# Important:
# Missing-value handling should be considered carefully.
# Different missing-data strategies can produce different results.


# Correlation and Covariance

# Covariance describes how two variables vary together.

cov(
  x,
  y
)


# Correlation standardizes covariance to a range from -1 to +1.

cor(
  x,
  y
)


# Correlation vs Covariance

# Covariance depends on the units of measurement.
# Correlation is unitless and easier to compare across variables.


# Correlation Does Not Mean Causation

# A correlation between two variables does not prove that
# one variable causes the other.

# Possible explanations include:
# Direct causal relationship
# Reverse causation
# Confounding variable
# Shared underlying process
# Coincidental association


# Example of Confounding

# Suppose gene expression is correlated with disease severity.

# Possible explanation:
# Disease severity may be associated with another biological process
# that affects both measurements.

# Therefore, correlation alone cannot establish the causal mechanism.


# Example Biological Data

# Example expression measurements for two genes.

gene_A <- c(
  5.1, 5.4, 5.7, 6.0, 6.3,
  6.7, 7.0, 7.4, 7.8, 8.1
)

gene_B <- c(
  4.8, 5.2, 5.5, 5.9, 6.1,
  6.5, 6.9, 7.2, 7.5, 7.9
)


# Explore the data

summary(gene_A)
summary(gene_B)


# Visualize the relationship

plot(
  gene_A,
  gene_B,
  xlab = "Gene A Expression",
  ylab = "Gene B Expression",
  main = "Gene Expression Correlation"
)


# Pearson correlation

gene_pearson <- cor.test(
  gene_A,
  gene_B,
  method = "pearson"
)

gene_pearson


# Spearman correlation

gene_spearman <- cor.test(
  gene_A,
  gene_B,
  method = "spearman"
)

gene_spearman


# Extract Results

gene_pearson$estimate
gene_pearson$p.value
gene_pearson$conf.int


# Biological Interpretation

# A positive correlation means that higher values of one measurement
# tend to occur with higher values of the other.

# A negative correlation means that higher values of one measurement
# tend to occur with lower values of the other.

# Correlation does not tell us whether one gene regulates another.


# Comparing Pearson and Spearman

cor(
  gene_A,
  gene_B,
  method = "pearson"
)

cor(
  gene_A,
  gene_B,
  method = "spearman"
)


# Multiple Correlations

# In bioinformatics, we may calculate correlations between many genes
# or between genes and clinical variables.

# When many correlation tests are performed,
# multiple-testing correction becomes important.

# Example p-values from multiple correlation tests

cor_pvalues <- c(
  0.001,
  0.003,
  0.01,
  0.02,
  0.04,
  0.08,
  0.12,
  0.30
)

# Adjust for multiple testing

p.adjust(
  cor_pvalues,
  method = "BH"
)


# Correlation Workflow

# 1. Define the scientific question.
# 2. Identify the two variables.
# 3. Explore the data.
# 4. Visualize the relationship.
# 5. Check for outliers.
# 6. Assess whether the relationship is linear or monotonic.
# 7. Choose Pearson or Spearman correlation.
# 8. Calculate the correlation coefficient.
# 9. Examine the confidence interval and p-value.
# 10. Apply multiple-testing correction when many correlations are tested.
# 11. Interpret the association in biological context.


# Common Mistakes

# Mistake 1:
# Assuming correlation proves causation.

# Mistake 2:
# Using Pearson correlation without checking the relationship visually.

# Mistake 3:
# Ignoring influential outliers.

# Mistake 4:
# Interpreting a small p-value as a strong correlation.

# Mistake 5:
# Interpreting a strong correlation as biological causation.

# Mistake 6:
# Ignoring multiple testing when thousands of correlations are evaluated.


# Key Takeaways

# Correlation measures association between variables.
# Pearson correlation measures linear association.
# Spearman correlation measures monotonic association using ranks.
# Correlation coefficients range from -1 to +1.
# The sign indicates direction.
# The absolute value indicates strength of association.
# cor.test() provides a statistical test and confidence interval.
# Outliers can strongly influence correlation.
# Correlation does not establish causation.
# Multiple-testing correction is important when many correlations are tested.