# Categorical Data
# Categorical data represent observations that belong to distinct groups or categories.


# What is Categorical Data?

# Categorical variables describe groups or categories rather than continuous measurements.

# Examples in bioinformatics and biomedical research:
# Disease status: Control, COVID-19
# Sex: Female, Male
# Treatment: Control, Drug
# Response: Responder, Non-responder
# Mutation status: Mutated, Wild-type


# Types of Categorical Variables

# Nominal:
# Categories have no natural order.
# Example: Blood group, treatment group, disease status.

# Ordinal:
# Categories have a meaningful order.
# Example: Mild, Moderate, Severe.


# Example Categorical Data

disease_status <- c(
  "Control", "Control", "Control", "Control",
  "Disease", "Disease", "Disease", "Disease",
  "Disease", "Control"
)

disease_status


# Convert to Factor

disease_status <- factor(disease_status)

disease_status


# Examine Levels

levels(disease_status)


# Number of Categories

nlevels(disease_status)


# Frequency Table

table(disease_status)


# Proportion Table

prop.table(
  table(disease_status)
)


# Percentage

prop.table(
  table(disease_status)
) * 100


# Frequency and Percentage Together

freq <- table(disease_status)

result <- data.frame(
  Count = as.vector(freq),
  Percentage = as.vector(prop.table(freq) * 100)
)

result


# Two Categorical Variables

# Example:
# Disease status and treatment response.

disease <- c(
  "Control", "Control", "Control", "Control",
  "Disease", "Disease", "Disease", "Disease",
  "Disease", "Disease"
)

response <- c(
  "Responder", "Non-responder",
  "Responder", "Responder",
  "Responder", "Responder",
  "Non-responder", "Responder",
  "Non-responder", "Responder"
)

data <- data.frame(
  disease,
  response
)

data


# Contingency Table

table(
  data$disease,
  data$response
)


# Save the Contingency Table

contingency_table <- table(
  data$disease,
  data$response
)

contingency_table


# Row Percentages

prop.table(
  contingency_table,
  margin = 1
)


# Convert to Percentage

prop.table(
  contingency_table,
  margin = 1
) * 100


# Column Percentages

prop.table(
  contingency_table,
  margin = 2
) * 100


# Overall Percentages

prop.table(
  contingency_table
) * 100


# Understanding Margins

# margin = 1:
# Proportions are calculated within rows.

# margin = 2:
# Proportions are calculated within columns.

# No margin:
# Proportions are calculated across the entire table.


# Example Interpretation

# Row percentages answer:
# Within each disease group, what proportion are responders?

# Column percentages answer:
# Among responders, what proportion belong to each disease group?


# Chi-square Test

# The Chi-square test evaluates whether two categorical variables
# are statistically associated.

chisq.test(
  contingency_table
)


# Save the Chi-square Result

chi_test <- chisq.test(
  contingency_table
)

chi_test


# P-value

chi_test$p.value


# Chi-square Statistic

chi_test$statistic


# Degrees of Freedom

chi_test$parameter


# Expected Counts

chi_test$expected


# Observed Counts

chi_test$observed


# Observed vs Expected Counts

chi_test$observed
chi_test$expected


# Hypotheses

# Null hypothesis:
# The two categorical variables are independent.

# Alternative hypothesis:
# The two categorical variables are associated.


# Interpretation

# If p < 0.05:
# There is evidence of an association between the variables.

# If p >= 0.05:
# There is insufficient evidence of an association.

# A non-significant result does not prove that the variables are independent.


# Chi-square Test Manually

# The Chi-square statistic is based on:

# Sum of:
# (Observed - Expected)^2 / Expected

observed <- chi_test$observed
expected <- chi_test$expected

chi_manual <- sum(
  (observed - expected)^2 / expected
)

chi_manual


# Compare with R

chi_test$statistic


# Expected Counts

# Expected counts are calculated under the assumption
# that the variables are independent.

chi_test$expected


# Expected Count Assumption

# Chi-square approximation works best when expected counts
# are sufficiently large.

# Very small expected counts can make the Chi-square approximation unreliable.


# Fisher's Exact Test

# Fisher's exact test is useful for small sample categorical data,
# especially when expected counts are small.

fisher.test(
  contingency_table
)


# Save Fisher's Test

fisher_result <- fisher.test(
  contingency_table
)

fisher_result


# Fisher's Exact Test P-value

fisher_result$p.value


# Chi-square vs Fisher's Exact Test

# Chi-square:
# Uses a statistical approximation.
# Commonly used for larger samples with adequate expected counts.

# Fisher's exact test:
# Calculates an exact probability.
# Useful for small samples or sparse contingency tables.


# A 2 × 2 Example

treatment <- c(
  "Control", "Control", "Control", "Control",
  "Treatment", "Treatment", "Treatment", "Treatment"
)

response <- c(
  "No", "No", "Yes", "No",
  "Yes", "Yes", "Yes", "No"
)

small_data <- data.frame(
  treatment,
  response
)

small_table <- table(
  small_data$treatment,
  small_data$response
)

small_table


# Chi-square Test

chisq.test(
  small_table
)


# Fisher's Exact Test

fisher.test(
  small_table
)


# Odds Ratio

# For a 2 × 2 table, Fisher's exact test also provides
# an estimate related to the odds ratio.

fisher.test(
  small_table
)$estimate


# Risk and Proportion

# Categorical data are often summarized using proportions.

treatment_table <- table(
  small_data$treatment,
  small_data$response
)

treatment_table


# Response proportion within each treatment group

prop.table(
  treatment_table,
  margin = 1
)


# Response percentage

prop.table(
  treatment_table,
  margin = 1
) * 100


# Bioinformatics Example

# Suppose we want to examine whether mutation status
# is associated with disease status.

disease_status <- c(
  "Control", "Control", "Control", "Control",
  "Control", "Disease", "Disease", "Disease",
  "Disease", "Disease"
)

mutation_status <- c(
  "Wild-type", "Wild-type", "Wild-type",
  "Mutated", "Wild-type",
  "Mutated", "Mutated", "Mutated",
  "Wild-type", "Mutated"
)

mutation_data <- data.frame(
  disease_status,
  mutation_status
)

mutation_table <- table(
  mutation_data$disease_status,
  mutation_data$mutation_status
)

mutation_table


# Mutation Proportions by Disease Group

prop.table(
  mutation_table,
  margin = 1
) * 100


# Chi-square Test

mutation_chi <- chisq.test(
  mutation_table
)

mutation_chi


# Expected Counts

mutation_chi$expected


# Fisher's Exact Test

mutation_fisher <- fisher.test(
  mutation_table
)

mutation_fisher


# Visualizing Categorical Data

barplot(
  table(disease_status),
  main = "Disease Status",
  xlab = "Group",
  ylab = "Count"
)


# Grouped Bar Plot

barplot(
  mutation_table,
  beside = TRUE,
  main = "Mutation Status by Disease Group",
  xlab = "Disease Group",
  ylab = "Count",
  legend.text = TRUE
)


# Stacked Bar Plot

barplot(
  mutation_table,
  beside = FALSE,
  main = "Mutation Status by Disease Group",
  xlab = "Disease Group",
  ylab = "Count",
  legend.text = TRUE
)


# Proportion Bar Plot

mutation_proportion <- prop.table(
  mutation_table,
  margin = 1
)

barplot(
  t(mutation_proportion),
  beside = FALSE,
  main = "Mutation Proportion by Disease Group",
  xlab = "Disease Group",
  ylab = "Proportion",
  legend.text = TRUE
)


# Chi-square Test and Biological Interpretation

# A statistically significant Chi-square test indicates
# evidence of association between the categorical variables.

# It does not tell us:
# Which category causes the other
# Whether the association is biologically important
# How large the biological effect is

# Effect size should also be considered.


# Chi-square Effect Size: Phi

# Phi is commonly used as an effect-size measure for a 2 × 2 table.

phi <- sqrt(
  as.numeric(chi_test$statistic) / sum(contingency_table)
)

phi


# Interpretation of Phi

# Phi is based on the strength of association.

# A larger absolute value indicates stronger association.

# Effect-size interpretation should depend on
# the research field and study context.


# Cramer's V

# Cramer's V is commonly used for larger contingency tables.

cramers_v <- sqrt(
  as.numeric(chi_test$statistic) /
    (sum(contingency_table) *
       min(
         nrow(contingency_table) - 1,
         ncol(contingency_table) - 1
       ))
)

cramers_v


# Ordinal Data

# Some categorical variables have an order.

severity <- factor(
  c(
    "Mild", "Moderate", "Severe",
    "Mild", "Severe", "Moderate",
    "Mild", "Moderate"
  ),
  levels = c(
    "Mild",
    "Moderate",
    "Severe"
  ),
  ordered = TRUE
)

severity


# Check Order

levels(severity)


# Ordered Factors

# Ordered categorical variables contain information about ranking.

# However, treating ordinal categories as numerical values
# requires additional assumptions.


# Categorical Data with Missing Values

category_data <- c(
  "Control",
  "Control",
  "Disease",
  NA,
  "Disease",
  "Control"
)

category_data


# Identify Missing Values

is.na(category_data)


# Count Missing Values

sum(
  is.na(category_data)
)


# Frequency Table with Missing Values

table(
  category_data,
  useNA = "ifany"
)


# Removing Missing Values

table(
  category_data,
  useNA = "no"
)


# Common Mistakes

# Mistake 1:
# Treating categorical variables as continuous without justification.

# Mistake 2:
# Using Chi-square when expected counts are very small.

# Mistake 3:
# Reporting only a p-value.

# Mistake 4:
# Confusing statistical association with causation.

# Mistake 5:
# Ignoring the direction and size of an association.

# Mistake 6:
# Using the wrong percentage denominator.

# Mistake 7:
# Ignoring missing observations.

# Mistake 8:
# Assuming a non-significant result proves independence.


# Choosing a Test

# Two categorical variables with adequate expected counts:
# Chi-square test.

# Small sample or sparse contingency table:
# Fisher's exact test.

# 2 × 2 table:
# Chi-square or Fisher's exact test depending on expected counts
# and study context.


# Categorical Data Workflow

# 1. Identify the categorical variables.
# 2. Check categories and missing values.
# 3. Create frequency tables.
# 4. Calculate appropriate proportions.
# 5. Create a contingency table.
# 6. Examine observed and expected counts.
# 7. Choose Chi-square or Fisher's exact test.
# 8. Examine the p-value.
# 9. Report effect size when appropriate.
# 10. Interpret the result in biological context.


# Example Reporting

# A Chi-square test was used to evaluate the association
# between disease status and mutation status.

# Report:
# Observed counts
# Percentages
# Chi-square statistic
# Degrees of freedom
# P-value
# Effect size when appropriate


# Key Takeaways

# Categorical variables represent groups or categories.
# Frequency tables summarize categorical variables.
# Contingency tables summarize combinations of categories.
# Chi-square tests evaluate association between categorical variables.
# Fisher's exact test is useful for small or sparse tables.
# Expected counts are important when choosing a test.
# Statistical significance does not measure biological importance.
# Proportions and effect sizes should be considered alongside p-values.
# Association does not establish causation.
