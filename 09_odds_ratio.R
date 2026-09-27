# Odds Ratio
# Odds ratio measures the strength of association between two categorical variables.


# What is an Odds Ratio?

# Odds ratio compares the odds of an outcome between two groups.

# It is commonly used in:
# Clinical studies
# Case-control studies
# Epidemiology
# Genetic association studies
# Bioinformatics


# Probability vs Odds

# Probability:
# Probability = number of events / total number of observations

# Odds:
# Odds = probability of event / probability of non-event


# Simple Example

probability <- 0.8

odds <- probability / (1 - probability)

probability
odds


# Convert Odds to Probability

odds <- 4

probability <- odds / (1 + odds)

probability


# 2 × 2 Contingency Table

# A common structure is:

#                 Outcome+
#                 Outcome-
#
# Exposed         a        b
# Unexposed       c        d


# Example

table_data <- matrix(
  c(40, 10,
    20, 30),
  nrow = 2,
  byrow = TRUE
)

rownames(table_data) <- c(
  "Exposed",
  "Unexposed"
)

colnames(table_data) <- c(
  "Outcome_Positive",
  "Outcome_Negative"
)

table_data


# Extract Cells

a <- table_data[1, 1]
b <- table_data[1, 2]
c <- table_data[2, 1]
d <- table_data[2, 2]

a
b
c
d


# Calculate Odds in the Exposed Group

odds_exposed <- a / b

odds_exposed


# Calculate Odds in the Unexposed Group

odds_unexposed <- c / d

odds_unexposed


# Calculate Odds Ratio

OR <- odds_exposed / odds_unexposed

OR


# Direct Formula

OR_formula <- (a * d) / (b * c)

OR_formula


# Both Methods Should Match

OR
OR_formula


# Interpretation of Odds Ratio

# OR = 1:
# No association between exposure and outcome.

# OR > 1:
# Higher odds of the outcome in the exposed group.

# OR < 1:
# Lower odds of the outcome in the exposed group.


# Example Interpretation

# If OR = 2:
# The odds of the outcome are twice as high
# in the exposed group compared with the unexposed group.

# If OR = 0.5:
# The odds of the outcome are half as high
# in the exposed group compared with the unexposed group.


# Important:
# Odds ratio compares odds, not probabilities.


# Example with Disease and Mutation

disease <- c(
  "Disease", "Disease", "Disease", "Disease",
  "Disease", "Disease",
  "Control", "Control", "Control", "Control",
  "Control", "Control"
)

mutation <- c(
  "Mutated", "Mutated", "Mutated",
  "Mutated", "Wild-type", "Wild-type",
  "Mutated", "Wild-type", "Wild-type",
  "Wild-type", "Wild-type", "Wild-type"
)

mutation_data <- data.frame(
  disease,
  mutation
)

mutation_data


# Create Contingency Table

mutation_table <- table(
  mutation_data$disease,
  mutation_data$mutation
)

mutation_table


# Reorder the Table if Needed

mutation_table <- mutation_table[
  c("Disease", "Control"),
  c("Mutated", "Wild-type")
]

mutation_table


# Calculate Odds

disease_odds <- mutation_table[
  "Disease",
  "Mutated"
] / mutation_table[
  "Disease",
  "Wild-type"
]

control_odds <- mutation_table[
  "Control",
  "Mutated"
] / mutation_table[
  "Control",
  "Wild-type"
]

disease_odds
control_odds


# Calculate Odds Ratio

OR_mutation <- disease_odds / control_odds

OR_mutation


# Direct Calculation

a <- mutation_table["Disease", "Mutated"]
b <- mutation_table["Disease", "Wild-type"]
c <- mutation_table["Control", "Mutated"]
d <- mutation_table["Control", "Wild-type"]

OR_mutation_formula <- (a * d) / (b * c)

OR_mutation_formula


# Odds Ratio Using Fisher's Exact Test

fisher_result <- fisher.test(
  mutation_table
)

fisher_result


# Fisher's Exact Test Odds Ratio

fisher_result$estimate


# Fisher's Exact Test Confidence Interval

fisher_result$conf.int


# Fisher's Exact Test P-value

fisher_result$p.value


# Why Use Fisher's Exact Test?

# Fisher's exact test is useful when:
# Sample size is small.
# Expected counts are small.
# The contingency table is sparse.

# It provides:
# Odds ratio estimate
# Confidence interval
# P-value


# Confidence Interval for Odds Ratio

# A confidence interval provides a range of plausible values
# for the population odds ratio.

fisher_result$conf.int


# Interpreting the Confidence Interval

# If the confidence interval includes 1:
# The data do not provide strong evidence against
# an odds ratio of 1 at the corresponding confidence level.

# If the entire confidence interval is above 1:
# The association is consistent with higher odds.

# If the entire confidence interval is below 1:
# The association is consistent with lower odds.


# Why is 1 Important?

# For odds ratios:
# OR = 1 represents no association.

# Therefore:
# OR > 1 indicates positive association.
# OR < 1 indicates negative association.


# Log Odds Ratio

# Odds ratios are often analyzed on the log scale.

log_OR <- log(OR_mutation)

log_OR


# Why Use Log Odds?

# The log transforms the OR scale:

# OR = 1 becomes log(OR) = 0
# OR > 1 becomes positive
# OR < 1 becomes negative


# Recover the Odds Ratio

exp(log_OR)


# Confidence Interval on Log Scale

log_CI <- log(
  fisher_result$conf.int
)

log_CI


# Recover the Original Scale

exp(log_CI)


# Odds Ratio vs Risk Ratio

# Odds ratio and risk ratio are different measures.

# Risk:
# Probability of an outcome.

# Odds:
# Probability of outcome divided by probability of non-outcome.

# Odds ratio:
# Ratio of odds between two groups.

# Risk ratio:
# Ratio of probabilities between two groups.


# Calculate Risks

risk_exposed <- a / (a + b)

risk_unexposed <- c / (c + d)

risk_exposed
risk_unexposed


# Risk Ratio

risk_ratio <- risk_exposed / risk_unexposed

risk_ratio


# Compare OR and RR

OR_formula
risk_ratio


# Important Interpretation

# When the outcome is uncommon,
# odds ratios and risk ratios can be numerically similar.

# When the outcome is common,
# the odds ratio can differ substantially from the risk ratio.


# Odds Ratio Is Not Always a Risk Ratio

# Do not write:
# "OR = 2 means twice the risk."

# More accurately:
# "OR = 2 means the odds are twice as high."


# Case-Control Studies

# Odds ratios are especially important in case-control studies.

# In a case-control study:
# Participants are selected based on outcome status.

# The odds ratio can be used to quantify the association
# between an exposure and the outcome.


# Genetic Association Example

# Suppose:
# Exposure = presence of a genetic variant
# Outcome = disease status

genetic_table <- matrix(
  c(
    80, 120,
    40, 160
  ),
  nrow = 2,
  byrow = TRUE
)

rownames(genetic_table) <- c(
  "Variant",
  "No_Variant"
)

colnames(genetic_table) <- c(
  "Disease",
  "Control"
)

genetic_table


# Fisher's Exact Test

genetic_fisher <- fisher.test(
  genetic_table
)

genetic_fisher


# Odds Ratio

genetic_fisher$estimate


# Confidence Interval

genetic_fisher$conf.int


# P-value

genetic_fisher$p.value


# Biological Interpretation

# Suppose OR > 1:
# The genetic variant is associated with higher odds
# of the disease in this dataset.

# Suppose OR < 1:
# The genetic variant is associated with lower odds
# of the disease in this dataset.

# This does not automatically establish:
# Causation
# Biological mechanism
# Clinical usefulness


# Statistical vs Biological Significance

# A large OR can have a wide confidence interval
# when the sample size is small.

# A small OR can be statistically significant
# in a very large dataset.

# Therefore consider:
# Effect size
# Confidence interval
# P-value
# Sample size
# Study design
# Biological context


# Association vs Causation

# An odds ratio describes an association.

# It does not automatically prove that
# the exposure causes the outcome.

# Possible explanations include:
# Confounding
# Selection bias
# Measurement bias
# Reverse causation
# Chance


# Confounding Example

# Suppose a biomarker is associated with disease.

# Age may be related to both:
# Biomarker level
# Disease status

# The observed odds ratio may partly reflect age.

# Additional statistical adjustment may be needed.


# Multiple Testing

# In bioinformatics, thousands of associations may be tested.

# Example:
# One genetic variant × one disease
# Many genetic variants × one disease

# If many tests are performed,
# p-values may need multiple-testing correction.


# Example Multiple Testing

p_values <- c(
  0.001,
  0.02,
  0.04,
  0.20,
  0.50
)

adjusted_p <- p.adjust(
  p_values,
  method = "BH"
)

data.frame(
  p_value = p_values,
  FDR = adjusted_p
)


# Reporting an Odds Ratio

# A useful report includes:

# Odds ratio
# Confidence interval
# P-value
# Sample size
# Definition of exposure
# Definition of outcome


# Example Reporting Structure

# "The exposure was associated with higher odds
# of the outcome (OR = X, 95% CI = X-X, p = X)."


# Do Not Overinterpret

# Avoid:
# "The exposure causes the disease."

# Prefer:
# "The exposure was associated with higher odds of the disease."


# Visualization

# Simple odds ratio visualization

OR_values <- c(
  0.5,
  1,
  2,
  4
)

plot(
  OR_values,
  rep(1, length(OR_values)),
  log = "x",
  pch = 19,
  xlab = "Odds Ratio",
  ylab = "",
  yaxt = "n",
  main = "Odds Ratio Scale"
)

abline(
  v = 1,
  lty = 2
)


# Interpretation of the OR Plot

# The vertical line at OR = 1 represents no association.

# Values to the right:
# Higher odds.

# Values to the left:
# Lower odds.


# Odds Ratio Workflow

# 1. Define the exposure.
# 2. Define the outcome.
# 3. Create a 2 × 2 contingency table.
# 4. Check the table orientation.
# 5. Calculate the odds in each group.
# 6. Calculate the odds ratio.
# 7. Obtain a confidence interval.
# 8. Perform an appropriate statistical test.
# 9. Examine the p-value.
# 10. Consider study design and possible confounding.
# 11. Interpret the OR in biological context.


# Common Mistakes

# Mistake 1:
# Confusing odds with probability.

# Mistake 2:
# Interpreting OR as risk ratio.

# Mistake 3:
# Forgetting that OR = 1 represents no association.

# Mistake 4:
# Ignoring the confidence interval.

# Mistake 5:
# Interpreting association as causation.

# Mistake 6:
# Ignoring the orientation of the 2 × 2 table.

# Mistake 7:
# Reporting only the p-value.

# Mistake 8:
# Ignoring confounding and study design.

# Mistake 9:
# Ignoring multiple testing in large-scale bioinformatics analyses.


# Key Takeaways

# Odds describe the ratio of an event probability
# to a non-event probability.

# Odds ratio compares odds between two groups.

# OR = 1 indicates no association.

# OR > 1 indicates higher odds in the exposed group.

# OR < 1 indicates lower odds in the exposed group.

# Confidence intervals show uncertainty around the OR.

# Fisher's exact test can provide an OR, confidence interval, and p-value.

# Odds ratio is especially important in case-control studies.

# OR is not the same as risk ratio.

# An odds ratio describes association and does not by itself establish causation.