# Statistics for Bioinformatics

A structured learning repository covering statistical concepts and their practical application in bioinformatics using R.

## About

Statistics is an essential component of bioinformatics for summarizing biological data, evaluating experimental results, identifying meaningful patterns, and supporting reproducible analysis.

This repository documents practical learning materials, R implementations, and bioinformatics-oriented examples covering fundamental statistics through introductory RNA-seq analysis concepts.

## Topics

### Statistical Foundations
- Descriptive Statistics
- Probability and Hypothesis Testing
- p-values and Statistical Significance
- t-tests
- ANOVA
- Multiple Testing and False Discovery Rate (FDR)

### Statistical Association and Modeling
- Correlation Analysis
- Linear Regression
- Categorical Data Analysis
- Chi-square Test
- Fisher's Exact Test
- Odds Ratio

### Data and Experimental Design
- Data Transformation and Normalization
- Experimental Design
- Biological and Technical Replicates
- Confounding and Batch Effects

### RNA-seq Statistics
- RNA-seq Data Structure
- Count Matrices and Sample Metadata
- RNA-seq Normalization
- DESeq2-based Differential Expression Concepts
- Variance Stabilizing Transformation (VST)

## Repository Structure

```text
Statistics-for-Bioinformatics/
│
├── 00_Introduction_to_Statistics.md
├── 01_descriptive_statistics.R
├── 02_hypothesis_testing.R
├── 03_t_test.R
├── 04_anova.R
├── 05_multiple_testing_fdr.R
├── 06_correlation.R
├── 07_regression.R
├── 08_categorical_data.R
├── 09_odds_ratio.R
├── 10_data_transformation.R
├── 11_experimental_design.R
├── 12_rna_seq_data_structure.R
├── 13_rna_seq_normalization.R
├── README.md
└── LICENSE
```
## Learning Approach

The repository follows a progressive approach:

**Statistical Foundations → Statistical Tests → Association & Modeling → Experimental Design → RNA-seq Analysis**

Each R script combines statistical concepts with practical examples and R implementations. Bioinformatics-oriented examples are included to connect statistical methods with real analytical contexts.

## Software and Packages

### Core

- R
- RStudio

### Bioconductor

- DESeq2

The examples are designed primarily for learning and demonstration. The RNA-seq examples use small simulated datasets to illustrate statistical concepts and workflows.

## Getting Started

Clone the repository:

```bash
git clone https://github.com/nazninshuktara/Statistics-for-Bioinformatics.git
```
Move into the repository:
```bash
cd Statistics-for-Bioinformatics
```
Open the `.R` scripts in RStudio and run them step by step.

## Purpose

This repository is intended as a practical reference for building statistical foundations for bioinformatics and developing confidence in applying statistical methods using R.

## Author
[Naznin Shuktara](https://github.com/nazninshuktara)

## License

See the `LICENSE` file for licensing information.
