# ANOVA
# Analysis of Variance (ANOVA) is used to compare means across multiple groups.


# What is ANOVA?

# ANOVA tests whether the means of three or more groups are equal.

# Example biological question:
# Does gene expression differ among Control, Treatment1, and Treatment2?

# Null hypothesis:
# H0: All population group means are equal.

# Alternative hypothesis:
# H1: At least one population mean is different.


# Why Not Use Multiple t-tests?

# Suppose we have three groups:
# Control
# Treatment1
# Treatment2

# Pairwise comparisons would require:
# Control vs Treatment1
# Control vs Treatment2
# Treatment1 vs Treatment2

# Performing many separate tests increases the chance of Type I errors.

# ANOVA provides an overall test for differences among multiple groups.


# Example Data

control <- c(10, 11, 12, 13, 14)
treatment1 <- c(15, 16, 17, 18, 19)
treatment2 <- c(20, 21, 22, 23, 24)

# Calculate group means

mean(control)
mean(treatment1)
mean(treatment2)


# Combine the Data

value <- c(
  control,
  treatment1,
  treatment2
)

group <- factor(
  c(
    rep("Control", length(control)),
    rep("Treatment1", length(treatment1)),
    rep("Treatment2", length(treatment2))
  )
)

anova_data <- data.frame(
  group,
  value
)

anova_data


# Check Group Sizes

table(anova_data$group)


# Group-wise Summary

aggregate(
  value ~ group,
  data = anova_data,
  FUN = mean
)

aggregate(
  value ~ group,
  data = anova_data,
  FUN = sd
)

summary(anova_data$value)


# Visualize the Groups

boxplot(
  value ~ group,
  data = anova_data,
  xlab = "Group",
  ylab = "Measurement"
)


# One-way ANOVA

# One-way ANOVA examines one categorical explanatory variable.
# Here the explanatory variable is group.

anova_model <- aov(
  value ~ group,
  data = anova_data
)

anova_model


# ANOVA Table

summary(anova_model)


# Understanding the ANOVA Table

# The ANOVA table contains:
# Degrees of freedom
# Sum of squares
# Mean square
# F-statistic
# P-value


# Sum of Squares

# Total variation can be divided into:
# Between-group variation
# Within-group variation

# Between-group variation describes differences among group means.
# Within-group variation describes variation among observations within groups.


# F-statistic

# F-statistic compares between-group variation with within-group variation.

# F = between-group mean square / within-group mean square

anova_summary <- summary(anova_model)

anova_summary


# Extract F-statistic

anova_summary[[1]][["F value"]][1]


# Extract p-value

anova_summary[[1]][["Pr(>F)"]][1]


# Statistical Decision

alpha <- 0.05

anova_p <- anova_summary[[1]][["Pr(>F)"]][1]

if (anova_p < alpha) {
  print("Reject H0")
} else {
  print("Fail to reject H0")
}


# Important Interpretation

# A significant ANOVA indicates that at least one group mean differs.
# ANOVA does not tell us which specific groups are different.

# A significant ANOVA therefore requires further investigation
# when specific group comparisons are scientifically important.


# Post-hoc Testing

# Tukey's Honest Significant Difference test compares pairs of groups
# after a significant one-way ANOVA.

TukeyHSD(anova_model)


# Visualize Tukey Results

plot(
  TukeyHSD(anova_model)
)


# Pairwise Comparisons

# Pairwise t-tests can also be performed with multiple-testing adjustment.

pairwise.t.test(
  anova_data$value,
  anova_data$group,
  p.adjust.method = "bonferroni"
)


# Multiple Testing Adjustment

# Pairwise comparisons produce multiple p-values.
# Adjusted p-values help control the overall error rate.

# Bonferroni adjustment
pairwise.t.test(
  anova_data$value,
  anova_data$group,
  p.adjust.method = "bonferroni"
)

# Holm adjustment
pairwise.t.test(
  anova_data$value,
  anova_data$group,
  p.adjust.method = "holm"
)


# ANOVA Assumptions

# One-way ANOVA commonly assumes:
# Independent observations
# Approximately normally distributed residuals
# Similar variance across groups


# Check Residuals

residuals_anova <- residuals(anova_model)

residuals_anova


# Histogram of Residuals

hist(residuals_anova)


# Q-Q Plot

# Q-Q plot helps assess whether residuals are approximately normal.

qqnorm(residuals_anova)

qqline(residuals_anova)


# Shapiro-Wilk Test for Residuals

shapiro.test(residuals_anova)

# A large p-value does not prove normality.
# The test should be considered together with the Q-Q plot and study design.


# Check Variance Visually

boxplot(
  value ~ group,
  data = anova_data
)

# Similar spread across groups supports the equal-variance assumption.


# Bartlett's Test

# Bartlett's test evaluates evidence for unequal variances.

bartlett.test(
  value ~ group,
  data = anova_data
)

# Bartlett's test is sensitive to departures from normality.


# Fligner-Killeen Test

# Fligner-Killeen test is a more robust test for homogeneity of variances.

fligner.test(
  value ~ group,
  data = anova_data
)


# ANOVA with Unequal Variances

# When group variances are clearly different,
# Welch's one-way ANOVA can be considered.

oneway.test(
  value ~ group,
  data = anova_data,
  var.equal = FALSE
)


# Balanced and Unbalanced Designs

# Balanced design:
# Groups have equal or similar numbers of observations.

# Unbalanced design:
# Groups have different numbers of observations.

# ANOVA can be performed with unequal group sizes,
# but study design and variance assumptions become important.


# Example with Unequal Group Sizes

control2 <- c(10, 11, 12, 13)
treatment1_2 <- c(15, 16, 17, 18, 19, 20)
treatment2_2 <- c(21, 22, 23, 24, 25)

value2 <- c(
  control2,
  treatment1_2,
  treatment2_2
)

group2 <- factor(
  c(
    rep("Control", length(control2)),
    rep("Treatment1", length(treatment1_2)),
    rep("Treatment2", length(treatment2_2))
  )
)

anova_data2 <- data.frame(
  group = group2,
  value = value2
)

anova_model2 <- aov(
  value ~ group,
  data = anova_data2
)

summary(anova_model2)


# Effect Size

# A significant p-value does not describe the magnitude of group differences.

# Eta squared describes the proportion of total variation
# associated with the grouping factor.

anova_table <- summary(anova_model)[[1]]

ss_group <- anova_table[["Sum Sq"]][1]
ss_total <- sum(anova_table[["Sum Sq"]])

eta_squared <- ss_group / ss_total

eta_squared


# Eta squared interpretation should depend on the research context.
# It describes the proportion of observed variance associated with group.


# Mean Comparison

# View the group means directly.

aggregate(
  value ~ group,
  data = anova_data,
  FUN = mean
)


# Confidence Intervals for Group Means

# Calculate standard errors for each group.

group_summary <- aggregate(
  value ~ group,
  data = anova_data,
  FUN = function(x) {
    c(
      mean = mean(x),
      sd = sd(x),
      n = length(x),
      se = sd(x) / sqrt(length(x))
    )
  }
)

group_summary


# Example Biological Data

# Example expression values for three biological conditions.

control_expression <- c(
  5.1, 5.3, 5.5, 5.4, 5.6,
  5.2, 5.7, 5.5
)

treatment_a_expression <- c(
  6.2, 6.4, 6.5, 6.3, 6.6,
  6.7, 6.4, 6.5
)

treatment_b_expression <- c(
  7.1, 7.3, 7.4, 7.2, 7.5,
  7.6, 7.3, 7.4
)


# Create Biological Dataset

expression <- c(
  control_expression,
  treatment_a_expression,
  treatment_b_expression
)

condition <- factor(
  c(
    rep("Control", length(control_expression)),
    rep("Treatment_A", length(treatment_a_expression)),
    rep("Treatment_B", length(treatment_b_expression))
  )
)

expression_data <- data.frame(
  condition,
  expression
)

expression_data


# Explore the Data

aggregate(
  expression ~ condition,
  data = expression_data,
  FUN = mean
)

aggregate(
  expression ~ condition,
  data = expression_data,
  FUN = sd
)


# Visualize Expression

boxplot(
  expression ~ condition,
  data = expression_data,
  xlab = "Condition",
  ylab = "Gene Expression"
)


# Run ANOVA

expression_anova <- aov(
  expression ~ condition,
  data = expression_data
)

summary(expression_anova)


# Post-hoc Test

TukeyHSD(expression_anova)


# ANOVA Interpretation

# If the ANOVA p-value is significant:
# There is evidence that not all condition means are equal.

# Tukey's test can then identify which pairs differ.

# The magnitude of the differences should also be considered
# using group means and effect sizes.


# ANOVA Workflow

# 1. Define the biological question.
# 2. Identify the outcome variable.
# 3. Identify the categorical grouping variable.
# 4. Explore the data.
# 5. Visualize group distributions.
# 6. Check important assumptions.
# 7. Perform ANOVA.
# 8. Examine the F-statistic and p-value.
# 9. Perform post-hoc comparisons if appropriate.
# 10. Examine effect size and confidence intervals.
# 11. Interpret the findings biologically.


# Common Mistakes

# Mistake 1:
# Performing many unadjusted t-tests instead of an overall ANOVA.

# Mistake 2:
# Assuming a significant ANOVA identifies the specific groups that differ.

# Mistake 3:
# Reporting only the ANOVA p-value.

# Mistake 4:
# Ignoring unequal variances or non-independent observations.

# Mistake 5:
# Treating statistical significance as biological importance.

# Mistake 6:
# Performing post-hoc comparisons without considering multiple testing.


# ANOVA vs t-test

# t-test:
# Commonly compares one mean with a reference or two group means.

# ANOVA:
# Compares means across three or more groups.

# ANOVA can also be extended to more complex experimental designs.


# Key Takeaways

# ANOVA evaluates differences among multiple group means.
# The null hypothesis states that all group means are equal.
# The F-statistic compares between-group and within-group variation.
# A significant ANOVA indicates that at least one mean differs.
# ANOVA alone does not identify which groups differ.
# Post-hoc tests can identify specific group differences.
# Assumptions and study design are important for valid interpretation.
# Effect size provides information about the magnitude of group differences.
