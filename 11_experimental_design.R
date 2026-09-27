# Experimental Design
# Experimental design determines how data are collected before statistical analysis.


# What is Experimental Design?

# Experimental design is the process of planning
# how an experiment will be performed and how data will be collected.

# A good design helps us:
# Reduce bias
# Reduce unwanted variation
# Identify biological effects
# Choose appropriate statistical tests
# Make valid statistical conclusions


# Why Design Matters

# Statistical analysis cannot fully correct
# a poorly designed experiment.

# Example:
# If all Control samples are processed on one day
# and all Treatment samples on another day,
# treatment and batch effects become difficult to separate.


# Experimental Unit

# The experimental unit is the smallest unit
# that can independently receive a treatment.

# Examples:
# Individual patient
# Individual animal
# Cell culture dish
# Biological sample

# The experimental unit is important
# when determining the true sample size.


# Biological Replicates

# Biological replicates are independent biological samples
# representing the population of interest.

# Example:
# Blood collected from 5 different patients.

# These represent biological variation.


# Technical Replicates

# Technical replicates are repeated measurements
# from the same biological sample.

# Example:
# One RNA sample measured three times.

# Technical replicates measure technical variation.


# Biological vs Technical Replicates

# Biological replicates:
# Independent biological units.

# Technical replicates:
# Repeated measurements of the same biological unit.

# Technical replicates do not provide the same information
# as independent biological replicates.


# Example

# Five patients:
# Patient 1
# Patient 2
# Patient 3
# Patient 4
# Patient 5

# If each patient is measured three times:
# Biological replicates = 5
# Technical measurements = 15

# The independent biological sample size remains 5.


# Pseudoreplication

# Pseudoreplication occurs when non-independent observations
# are incorrectly treated as independent replicates.

# Example:
# 1 patient
# 10 technical measurements

# Treating these 10 measurements as 10 independent patients
# would inflate the apparent sample size.


# Controls

# A control group provides a reference for comparison.

# Examples:
# Untreated control
# Vehicle control
# Mock control
# Healthy control
# Wild-type control


# Treatment and Control

control <- c(
  10, 11, 12, 13, 14
)

treatment <- c(
  15, 16, 18, 19, 20
)

group <- factor(
  c(
    rep("Control", 5),
    rep("Treatment", 5)
  )
)

value <- c(
  control,
  treatment
)

experiment <- data.frame(
  group,
  value
)

experiment


# Visualize the Groups

boxplot(
  value ~ group,
  data = experiment,
  xlab = "Group",
  ylab = "Measurement",
  main = "Control vs Treatment"
)


# Randomization

# Randomization means assigning experimental units
# to groups using a random process.

# It helps reduce systematic allocation bias.


# Simple Randomization Example

set.seed(123)

sample(
  c(
    "Control",
    "Treatment"
  ),
  size = 10,
  replace = TRUE
)


# Important:

# This example demonstrates random assignment.

# In a real experiment,
# group sizes and design constraints
# should be planned before randomization.


# Reproducible Randomization

set.seed(123)

sample(
  1:10
)


# Running the same code with the same seed
# produces the same random sequence.


# Blinding

# Blinding reduces the possibility that
# knowledge of group assignment influences measurements
# or assessment.

# Examples:
# Laboratory staff may not know treatment groups.
# Image analysts may not know sample groups.


# Blocking

# Blocking groups similar experimental units
# before randomization or analysis.

# Examples of blocking variables:
# Sex
# Age group
# Experimental batch
# Sequencing run
# Laboratory


# Example Blocking Variable

sample_id <- paste0(
  "S",
  1:12
)

batch <- factor(
  rep(
    c("Batch1", "Batch2", "Batch3"),
    each = 4
  )
)

group <- factor(
  c(
    "Control", "Treatment",
    "Treatment", "Control",
    "Control", "Treatment",
    "Control", "Treatment",
    "Treatment", "Control",
    "Treatment", "Control"
  )
)

design <- data.frame(
  sample_id,
  batch,
  group
)

design


# Why Blocking Helps

# Suppose batch affects the measured outcome.

# If treatment groups are balanced across batches,
# batch effects are less likely to be confused with treatment effects.


# Confounding

# A confounder is a variable associated with both
# the predictor/exposure and the outcome.

# Confounding can create or distort an apparent association.


# Example

# Suppose:
# Disease group = mostly Batch 1
# Control group = mostly Batch 2

# If batch affects gene expression,
# disease status and batch become confounded.


# Simple Confounded Design

confounded_design <- data.frame(
  group = factor(
    c(
      "Control", "Control", "Control",
      "Disease", "Disease", "Disease"
    )
  ),
  batch = factor(
    c(
      "Batch1", "Batch1", "Batch1",
      "Batch2", "Batch2", "Batch2"
    )
  )
)

confounded_design


# Here:
# Control samples occur only in Batch1.
# Disease samples occur only in Batch2.

# Therefore, group and batch are completely confounded.


# Balanced Design

balanced_design <- data.frame(
  group = factor(
    c(
      "Control", "Control", "Control",
      "Disease", "Disease", "Disease"
    )
  ),
  batch = factor(
    c(
      "Batch1", "Batch2", "Batch3",
      "Batch1", "Batch2", "Batch3"
    )
  )
)

balanced_design


# Here:
# Both groups are represented across batches.

# This makes it easier to distinguish
# group effects from batch effects.


# Inspect Experimental Design

table(
  balanced_design$group,
  balanced_design$batch
)


# Contingency Tables Help Identify Confounding

table(
  confounded_design$group,
  confounded_design$batch
)


# Batch Effects

# Batch effects are systematic differences
# introduced by technical or experimental factors.

# Examples:
# Different sequencing dates
# Different laboratories
# Different sequencing platforms
# Different library preparation runs
# Different operators
# Different reagent lots


# Batch Effects in Bioinformatics

# Example:
# Samples processed in January:
# Control group

# Samples processed in February:
# Disease group

# If gene expression differs,
# we cannot easily determine whether the difference
# is caused by disease or processing month.


# Experimental Design Before Analysis

# The best way to handle batch effects
# is to avoid confounding during experimental design.

# For example:
# Randomize samples across batches.
# Balance biological groups across batches.
# Process samples using comparable procedures.


# Batch as a Statistical Variable

# When batch variation remains,
# batch can sometimes be included in a statistical model.

# Example:

value <- c(
  10, 11, 12,
  15, 16, 17,
  13, 14, 15,
  18, 19, 20
)

group <- factor(
  c(
    "Control", "Control", "Control",
    "Disease", "Disease", "Disease",
    "Control", "Control", "Control",
    "Disease", "Disease", "Disease"
  )
)

batch <- factor(
  rep(
    c("Batch1", "Batch2"),
    each = 6
  )
)

batch_data <- data.frame(
  value,
  group,
  batch
)

batch_data


# Model Without Batch

model_without_batch <- lm(
  value ~ group,
  data = batch_data
)

summary(
  model_without_batch
)


# Model With Batch

model_with_batch <- lm(
  value ~ group + batch,
  data = batch_data
)

summary(
  model_with_batch
)


# Interpretation

# The second model estimates the group association
# while accounting for batch in the model.

# However, statistical adjustment cannot fully recover
# information that was lost because of complete confounding.


# Complete Confounding

# If group and batch are perfectly confounded,
# the model cannot reliably separate their effects.

# Example:
# All Controls = Batch1
# All Disease = Batch2

# No statistical method can determine from these data alone
# whether the difference is due to disease or batch.


# Sample Size

# Sample size should be determined based on:
# Research question
# Expected effect size
# Variability
# Desired statistical power
# Significance level
# Study design


# Small Sample Example

small_control <- c(
  10, 11, 12
)

small_treatment <- c(
  15, 16, 17
)

t.test(
  small_control,
  small_treatment
)


# Larger Sample Example

large_control <- c(
  10, 11, 12, 13, 14,
  10, 12, 13, 14, 15
)

large_treatment <- c(
  15, 16, 17, 18, 19,
  16, 17, 18, 19, 20
)

t.test(
  large_control,
  large_treatment
)


# Larger sample sizes generally provide
# more precise estimates when the design is appropriate.


# Statistical Power

# Power is the probability of detecting
# an effect of a specified size when that effect truly exists,
# under the assumptions of the chosen statistical model.

# Power is influenced by:
# Effect size
# Sample size
# Variability
# Significance level
# Study design


# Power Calculation

# R provides power calculation functions
# for common statistical tests.

power.t.test(
  delta = 2,
  sd = 3,
  sig.level = 0.05,
  power = 0.80,
  type = "two.sample",
  alternative = "two.sided"
)


# Calculate Required Sample Size

power_result <- power.t.test(
  delta = 2,
  sd = 3,
  sig.level = 0.05,
  power = 0.80,
  type = "two.sample",
  alternative = "two.sided"
)

power_result


# Important:

# Power calculations should be based on
# scientifically reasonable assumptions.

# Choosing an effect size only to obtain
# a convenient sample size is not appropriate.


# Effect Size

# Experimental design should consider
# how large an effect would be biologically meaningful.

# Statistical significance and biological importance
# are not the same.


# Replication

# Replication improves our ability to estimate
# biological variation and generalize findings.

# More biological replicates generally provide
# more information than simply repeating
# the same measurement technically.


# Technical Replication Example

# One biological sample:
sample_1 <- c(
  10.1,
  10.3,
  10.2
)

mean(sample_1)


# The measurements are technical replicates
# if they come from the same biological sample.


# Biological Replication Example

# Three independent biological samples:

biological_samples <- c(
  10.2,
  12.5,
  9.8
)

mean(
  biological_samples
)

sd(
  biological_samples
)


# The variation among biological samples
# represents biological variability.


# Repeated Measures

# Sometimes the same biological unit
# is measured multiple times.

# Example:
# Patient measured before treatment
# Patient measured after treatment

patient_id <- factor(
  c(
    "P1", "P2", "P3", "P4", "P5"
  )
)

before <- c(
  10, 12, 11, 14, 13
)

after <- c(
  12, 15, 13, 16, 15
)

repeated_data <- data.frame(
  patient_id,
  before,
  after
)

repeated_data


# Paired Analysis

# Because the same patients are measured twice,
# the observations are paired.

t.test(
  before,
  after,
  paired = TRUE
)


# Pairing can reduce the effect of
# between-subject variability.


# Cross-sectional vs Longitudinal

# Cross-sectional:
# Different individuals are measured at one point in time.

# Longitudinal:
# The same individuals are followed over time.


# Example Longitudinal Structure

longitudinal_data <- data.frame(
  patient = factor(
    c(
      "P1", "P1",
      "P2", "P2",
      "P3", "P3"
    )
  ),
  time = factor(
    c(
      "Before", "After",
      "Before", "After",
      "Before", "After"
    ),
    levels = c(
      "Before",
      "After"
    )
  ),
  value = c(
    10, 13,
    12, 15,
    11, 14
  )
)

longitudinal_data


# The study structure determines
# which statistical method is appropriate.


# Inclusion and Exclusion Criteria

# Before data collection,
# define criteria for which observations
# will be included or excluded.

# Criteria should be scientifically justified
# and ideally specified before analysis.


# Avoid Data-driven Exclusion

# Do not remove observations simply because
# they make the result statistically non-significant.

# Exclusion should have a predefined
# scientific or technical reason.


# Missing Data

# Missing data can arise from:
# Failed experiments
# Sample loss
# Measurement failure
# Participant dropout

# Missingness should be investigated
# rather than automatically ignored.


# Data Leakage

# Data leakage occurs when information that should not be available
# enters the analysis or prediction process.

# This is especially important in machine learning.

# Example:
# Using information from the test set
# while selecting or tuning the model.


# Pre-specification

# Important decisions should ideally be made
# before examining the final results.

# Examples:
# Primary outcome
# Main comparison
# Inclusion criteria
# Statistical method
# Main covariates
# Significance threshold


# This reduces opportunities for
# analysis decisions to be influenced by the observed results.


# Experimental Design Checklist

# Before collecting data, ask:

# 1. What is the scientific question?
# 2. What is the experimental unit?
# 3. What is the primary outcome?
# 4. What is the treatment or exposure?
# 5. What is the control?
# 6. How many biological replicates are needed?
# 7. Are technical replicates necessary?
# 8. Will randomization be used?
# 9. Is blinding possible?
# 10. Are there important blocking variables?
# 11. Could batch effects occur?
# 12. Could variables become confounded?
# 13. What statistical model will be used?
# 14. What effect size is biologically meaningful?
# 15. What sample size provides adequate power?


# Bioinformatics Study Design

# In omics experiments, consider:

# Biological replicates
# Sequencing depth
# Library preparation
# Sequencing batch
# Experimental batch
# Tissue type
# Cell type
# Sex
# Age
# Disease status
# Treatment
# Collection site


# Example RNA-seq Design

sample_id <- paste0(
  "Sample",
  1:12
)

condition <- factor(
  rep(
    c("Control", "Disease"),
    each = 6
  )
)

batch <- factor(
  rep(
    c("Batch1", "Batch2", "Batch3"),
    times = 4
  )
)

sex <- factor(
  rep(
    c("Female", "Male"),
    times = 6
  )
)

rna_design <- data.frame(
  sample_id,
  condition,
  batch,
  sex
)

rna_design


# Inspect the Design

table(
  rna_design$condition
)

table(
  rna_design$condition,
  rna_design$batch
)

table(
  rna_design$condition,
  rna_design$sex
)


# A Good Design Attempts to Balance
# Important technical and biological variables
# across experimental groups.


# Design Matrix Concept

# Statistical models often represent
# experimental variables using a design matrix.

design_matrix <- model.matrix(
  ~ condition + batch + sex,
  data = rna_design
)

design_matrix


# The design matrix represents
# the variables included in the statistical model.


# RNA-seq Note

# In RNA-seq differential expression analysis,
# experimental design is specified before model fitting.

# Example conceptual design:
# ~ batch + condition

# This means:
# Account for batch
# Test the condition effect


# Important:

# The exact model depends on:
# Experimental design
# Number of groups
# Paired or repeated measurements
# Batch structure
# Covariates
# Biological question


# Experimental Design vs Statistical Analysis

# Experimental design answers:
# How should data be collected?

# Statistical analysis answers:
# How should collected data be analyzed?

# Good statistical analysis cannot completely compensate
# for poor experimental design.


# Common Mistakes

# Mistake 1:
# Confusing technical replicates with biological replicates.

# Mistake 2:
# Ignoring batch effects.

# Mistake 3:
# Completely confounding treatment and batch.

# Mistake 4:
# Using too few biological replicates.

# Mistake 5:
# Treating repeated measurements as independent.

# Mistake 6:
# Removing observations based only on their effect on p-values.

# Mistake 7:
# Changing the primary analysis after seeing the results
# without clearly documenting the change.

# Mistake 8:
# Ignoring important covariates.

# Mistake 9:
# Assuming statistical adjustment can solve complete confounding.


# Experimental Design Workflow

# 1. Define the scientific question.
# 2. Define the experimental unit.
# 3. Define the outcome.
# 4. Define treatment and control groups.
# 5. Determine biological replication.
# 6. Plan technical replication if needed.
# 7. Randomize when appropriate.
# 8. Identify blocking variables.
# 9. Balance groups across batches.
# 10. Identify potential confounders.
# 11. Estimate sample size and power.
# 12. Pre-specify important analysis decisions.
# 13. Collect data.
# 14. Document the experimental design.
# 15. Analyze according to the study design.


# Key Takeaways

# Experimental design comes before statistical analysis.

# Biological replicates represent independent biological units.

# Technical replicates are repeated measurements
# of the same biological unit.

# Pseudoreplication occurs when non-independent measurements
# are treated as independent observations.

# Randomization helps reduce allocation bias.

# Blinding can reduce measurement or assessment bias.

# Blocking can help control known sources of variation.

# Balanced designs help separate biological effects
# from technical effects.

# Confounding makes it difficult to distinguish
# the effects of different variables.

# Batch effects should ideally be addressed during study design.

# Sample size, effect size, variability, and power
# should be considered before data collection.

# A statistical model cannot fully recover information
# lost through poor experimental design.