# Multiple Testing and FDR
# Multiple testing methods help control false positive findings when many hypotheses are tested.


# What is Multiple Testing?

# A statistical test usually evaluates one hypothesis at a time.

# In bioinformatics, we often test thousands of hypotheses simultaneously.
# For example, RNA-seq analysis may test one hypothesis for each gene.

# Testing many hypotheses increases the probability of obtaining
# statistically significant results by chance.


# Simple Example

# Suppose we test 1 hypothesis using alpha = 0.05.

alpha <- 0.05

# If H0 is actually true, there is a 5% Type I error rate under the test assumptions.


# What Happens When We Test Many Hypotheses?

# Suppose 100 independent hypotheses are tested.

number_of_tests <- 100

# Expected number of false positives when all null hypotheses are true
expected_false_positives <- number_of_tests * alpha

expected_false_positives

# With 100 tests and alpha = 0.05,
# about 5 false positives can occur on average when all null hypotheses are true.

# With thousands of tests, the problem becomes much larger.


# Example: 20 Hypotheses

set.seed(123)

# Generate 20 example p-values
p_values <- runif(20)

p_values


# Count significant p-values before adjustment

sum(p_values < 0.05)


# Important Concept

# A raw p-value evaluates one hypothesis.
# When many hypotheses are tested, raw p-values may produce many false positives.

# Multiple-testing correction adjusts the evidence threshold
# to account for the number of statistical tests.


# Family-wise Error Rate

# Family-wise error rate (FWER) is the probability of making
# at least one Type I error among a family of tests.

# Bonferroni correction controls the FWER.


# Bonferroni Correction

# Bonferroni adjusts the significance threshold.

alpha <- 0.05
number_of_tests <- 20

bonferroni_alpha <- alpha / number_of_tests

bonferroni_alpha


# For 20 tests:
# 0.05 / 20 = 0.0025


# Bonferroni-adjusted P-values

# Another way to apply Bonferroni correction is to multiply
# each p-value by the number of tests.

bonferroni_p <- p.adjust(
  p_values,
  method = "bonferroni"
)

bonferroni_p


# Compare Raw and Adjusted P-values

results <- data.frame(
  raw_p = p_values,
  bonferroni_p = bonferroni_p
)

results


# Significant Results

# Raw p-values below 0.05
sum(results$raw_p < 0.05)

# Bonferroni-adjusted p-values below 0.05
sum(results$bonferroni_p < 0.05)


# Holm Correction

# Holm's method also controls the family-wise error rate.
# It is generally less conservative than simple Bonferroni correction.

holm_p <- p.adjust(
  p_values,
  method = "holm"
)

holm_p


# Compare Bonferroni and Holm

results$holm_p <- holm_p

results


# False Discovery Rate

# False Discovery Rate (FDR) controls the expected proportion of
# false discoveries among the rejected hypotheses.

# FDR is particularly useful when many hypotheses are tested,
# such as in genomics and transcriptomics.


# Benjamini-Hochberg Method

# The Benjamini-Hochberg method is commonly used to control FDR.

bh_p <- p.adjust(
  p_values,
  method = "BH"
)

bh_p


# Add BH-adjusted P-values

results$FDR <- bh_p

results


# Identify FDR-significant Results

# Select hypotheses with FDR below 0.05.

significant_fdr <- results[
  results$FDR < 0.05,
]

significant_fdr


# Count FDR-significant Results

sum(results$FDR < 0.05)


# Comparing Correction Methods

results <- data.frame(
  raw_p = p_values,
  bonferroni = p.adjust(p_values, method = "bonferroni"),
  holm = p.adjust(p_values, method = "holm"),
  FDR = p.adjust(p_values, method = "BH")
)

results


# Number of Significant Results

sum(results$raw_p < 0.05)

sum(results$bonferroni < 0.05)

sum(results$holm < 0.05)

sum(results$FDR < 0.05)


# Why Are Adjusted P-values Usually Larger?

# Multiple-testing correction makes statistical evidence more conservative.
# Adjusted p-values account for the fact that many hypotheses were tested.

# Therefore:
# Adjusted p-value >= raw p-value


# Simple Visualization

plot(
  results$raw_p,
  results$FDR,
  xlab = "Raw P-value",
  ylab = "FDR-adjusted P-value"
)

abline(
  a = 0,
  b = 1
)


# Simulated Gene Expression Results

# Imagine that each row represents one gene.

gene <- paste0(
  "Gene_",
  1:20
)

gene_pvalues <- c(
  0.0001,
  0.0005,
  0.001,
  0.002,
  0.004,
  0.008,
  0.012,
  0.018,
  0.025,
  0.031,
  0.041,
  0.049,
  0.12,
  0.21,
  0.35,
  0.44,
  0.58,
  0.67,
  0.81,
  0.92
)


# Create Gene-level Results

gene_results <- data.frame(
  gene = gene,
  p_value = gene_pvalues
)

gene_results


# Calculate FDR

gene_results$FDR <- p.adjust(
  gene_results$p_value,
  method = "BH"
)

gene_results


# Identify Significant Genes

significant_genes <- gene_results[
  gene_results$FDR < 0.05,
]

significant_genes


# Number of Significant Genes

sum(gene_results$FDR < 0.05)


# Sort Genes by P-value

gene_results[
  order(gene_results$p_value),
]


# Sort Genes by FDR

gene_results[
  order(gene_results$FDR),
]


# Raw P-value vs FDR

# A gene may have a raw p-value below 0.05
# but an FDR-adjusted p-value above 0.05.

gene_results$significant_raw <- (
  gene_results$p_value < 0.05
)

gene_results$significant_FDR <- (
  gene_results$FDR < 0.05
)

gene_results


# Why FDR is Important in RNA-seq

# RNA-seq experiments may test thousands of genes simultaneously.

# For example:
# Gene 1 -> test
# Gene 2 -> test
# Gene 3 -> test
# ...
# Gene 20,000 -> test

# If every gene is evaluated using p < 0.05 without correction,
# many genes may appear significant simply because of multiple testing.

# FDR correction helps control the expected proportion of false discoveries
# among the genes called significant.


# Example RNA-seq Result Table

rna_seq_results <- data.frame(
  gene = c(
    "GeneA",
    "GeneB",
    "GeneC",
    "GeneD",
    "GeneE"
  ),
  log2FC = c(
    2.1,
    -1.8,
    0.5,
    3.2,
    -0.3
  ),
  p_value = c(
    0.0001,
    0.001,
    0.02,
    0.04,
    0.60
  )
)

rna_seq_results


# Add FDR

rna_seq_results$FDR <- p.adjust(
  rna_seq_results$p_value,
  method = "BH"
)

rna_seq_results


# Biological Interpretation

# Statistical significance should not be evaluated using FDR alone.

# In differential expression analysis, interpretation often considers:
# Adjusted p-value
# Effect size such as log2 fold change
# Biological function
# Experimental design
# Sample size
# Data quality


# Example:

# A gene can have:
# Very small FDR
# Very small log2 fold change

# Such a gene may be statistically significant
# but have a small observed expression change.

# Conversely, a gene may have:
# Large biological effect
# But insufficient statistical evidence

# Therefore, statistical significance and biological relevance
# should be evaluated together.


# FDR Threshold

# A commonly used threshold is FDR < 0.05.

fdr_threshold <- 0.05

fdr_threshold


# Identify FDR-significant Genes

rna_seq_results[
  rna_seq_results$FDR < fdr_threshold,
]


# Different FDR Thresholds

# Explore how the number of discoveries changes with the threshold.

sum(rna_seq_results$FDR < 0.01)

sum(rna_seq_results$FDR < 0.05)

sum(rna_seq_results$FDR < 0.10)


# Bonferroni vs FDR

# Bonferroni:
# Controls the probability of making at least one Type I error.

# FDR:
# Controls the expected proportion of false discoveries among discoveries.

# Bonferroni is usually more conservative.
# FDR generally allows more discoveries while controlling the expected
# false-discovery proportion.


# Choosing a Correction Method

# Use the correction method according to the scientific question.

# FWER methods such as Bonferroni are useful when even one false positive
# is considered especially problematic.

# FDR methods are useful when many discoveries are expected
# and controlling the proportion of false discoveries is appropriate.


# Multiple Testing Workflow

# 1. Perform the individual statistical tests.
# 2. Collect the raw p-values.
# 3. Determine the appropriate multiple-testing strategy.
# 4. Adjust the p-values.
# 5. Define an appropriate significance threshold.
# 6. Identify statistically supported findings.
# 7. Examine effect sizes and biological relevance.


# Common Mistakes

# Mistake 1:
# Using raw p < 0.05 for thousands of genes without correction.

# Mistake 2:
# Assuming FDR is the same as the raw p-value.

# Mistake 3:
# Treating FDR < 0.05 as proof of biological importance.

# Mistake 4:
# Assuming Bonferroni and FDR control the same error concept.

# Mistake 5:
# Reporting only significant genes without reporting
# the multiple-testing method used.


# Key Takeaways

# Multiple testing increases the risk of false positive findings.
# Bonferroni controls the family-wise error rate.
# Holm is another family-wise error rate correction.
# FDR controls the expected proportion of false discoveries among discoveries.
# Benjamini-Hochberg is a common FDR procedure.
# Adjusted p-values should be used when many hypotheses are tested.
# FDR is especially important for high-throughput bioinformatics analyses.
# Statistical significance should be interpreted together with effect size
# and biological context.