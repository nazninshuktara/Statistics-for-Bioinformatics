# RNA-seq Data Structure
# RNA-seq measures RNA abundance across biological samples.


# What is RNA-seq?

# RNA-seq is a sequencing-based method used to study RNA molecules.

# It can be used to:
# Measure gene expression
# Identify differentially expressed genes
# Study transcript abundance
# Characterize transcriptomes
# Investigate biological pathways


# Basic RNA-seq Workflow

# Biological samples
#        ↓
# RNA extraction
#        ↓
# Library preparation
#        ↓
# Sequencing
#        ↓
# FASTQ files
#        ↓
# Quality control
#        ↓
# Alignment or quantification
#        ↓
# Gene/transcript quantification
#        ↓
# Count or expression matrix
#        ↓
# Statistical analysis
#        ↓
# Biological interpretation


# FASTQ Files

# FASTQ files contain sequencing reads.

# A FASTQ record contains four lines:
#
# @Read_ID
# Nucleotide sequence
# +
# Quality scores


# Example FASTQ-like Record

read_id <- "@READ_001"

sequence <- "ATGCGTACGTAGCTAG"

plus <- "+"

quality <- "FFFFFFFFFFFFFFFF"

read_id
sequence
plus
quality


# FASTQ Components

# Read ID:
# Identifies the sequencing read.

# Sequence:
# Contains nucleotide bases.

# Plus line:
# Separates sequence and quality information.

# Quality string:
# Represents base-calling quality.


# FASTQ Quality Scores

# Sequencing quality scores represent
# confidence in individual base calls.

# Higher quality score:
# Greater confidence in the base call.

# Lower quality score:
# Lower confidence in the base call.


# Phred Quality Score

# Phred score is commonly represented as:

# Q = -10 * log10(P_error)

# Where P_error is the probability
# that the base call is incorrect.


# Example

P_error <- 0.01

Q <- -10 * log10(P_error)

Q


# A Phred score of 20 corresponds approximately
# to a 1% error probability.


# Important:

# FASTQ files contain reads,
# not gene-level expression values.


# Single-end vs Paired-end

# Single-end sequencing:
# One sequence is obtained from each DNA/RNA fragment.

# Paired-end sequencing:
# Both ends of the fragment are sequenced.


# Paired-end Example

read_1 <- "ATGCGTACGTAG"
read_2 <- "CGATCGTAGCTA"

read_1
read_2


# FASTQ File Naming

# A paired-end experiment may contain:

# sample1_R1.fastq.gz
# sample1_R2.fastq.gz

# R1:
# First read.

# R2:
# Second read.


# FASTQ Compression

# .fastq.gz means the FASTQ file is compressed using gzip.

# Compression reduces storage space.

# R can read some compressed files directly,
# but many RNA-seq tools operate through
# command-line workflows.


# Quality Control

# Quality control examines:
# Read quality
# Sequence composition
# Adapter contamination
# Overrepresented sequences
# Read length
# Duplication
# GC content


# Common QC Tools

# FastQC:
# Per-sample sequencing quality assessment.

# MultiQC:
# Combines results from multiple samples
# into a single report.


# Conceptual QC Structure

qc_metrics <- data.frame(
  sample = c(
    "Sample1",
    "Sample2",
    "Sample3",
    "Sample4"
  ),
  mean_quality = c(
    35.2,
    34.8,
    36.1,
    33.9
  ),
  gc_percent = c(
    48,
    50,
    47,
    49
  )
)

qc_metrics


# Examine QC Metrics

summary(
  qc_metrics
)


# Plot Mean Quality

plot(
  qc_metrics$mean_quality,
  type = "b",
  xaxt = "n",
  xlab = "Sample",
  ylab = "Mean Quality",
  main = "Mean Sequencing Quality"
)

axis(
  1,
  at = 1:nrow(qc_metrics),
  labels = qc_metrics$sample
)


# Alignment

# Alignment maps sequencing reads
# to a reference genome.

# Common alignment tools include:
# STAR
# HISAT2


# Conceptual Workflow

# FASTQ
#   ↓
# Quality Control
#   ↓
# Alignment
#   ↓
# BAM file
#   ↓
# Gene counting


# BAM Files

# BAM is a compressed binary format
# for storing sequence alignment information.

# BAM files contain information about:
# Read alignment position
# Mapping quality
# CIGAR information
# Reference sequence
# Paired-end relationships


# Important:

# BAM files contain alignment information,
# not the final gene expression matrix.


# Transcript Quantification

# An alternative to genome alignment
# is transcript-level quantification.

# Common tools include:
# Salmon
# kallisto


# Conceptual Workflow

# FASTQ
#   ↓
# Quality Control
#   ↓
# Transcript Quantification
#   ↓
# Transcript abundance
#   ↓
# Gene-level summarization


# Counts

# Gene-level counts represent
# the number of sequencing fragments
# assigned to each gene.

# Example:

gene_counts <- data.frame(
  gene = c(
    "GeneA",
    "GeneB",
    "GeneC",
    "GeneD"
  ),
  Sample1 = c(
    100,
    250,
    50,
    500
  ),
  Sample2 = c(
    120,
    230,
    45,
    520
  ),
  Sample3 = c(
    90,
    270,
    60,
    480
  )
)

gene_counts


# Gene as Row Identifier

rownames(gene_counts) <- gene_counts$gene

gene_counts$gene <- NULL

gene_counts


# Count Matrix

# A typical count matrix has:

# Rows = genes
# Columns = samples
# Values = counts


# Examine Dimensions

dim(
  gene_counts
)


# Number of Genes

nrow(
  gene_counts
)


# Number of Samples

ncol(
  gene_counts
)


# Gene Names

rownames(
  gene_counts
)


# Sample Names

colnames(
  gene_counts
)


# Access One Gene

gene_counts["GeneA", ]


# Access One Sample

gene_counts[, "Sample1"]


# Access Multiple Genes

gene_counts[
  c("GeneA", "GeneB"),
  c("Sample1", "Sample2")
]


# Count Matrix Structure

#              Sample1 Sample2 Sample3
# GeneA           100     120      90
# GeneB           250     230     270
# GeneC            50      45      60
# GeneD           500     520     480


# Important:

# Rows should represent the same biological feature
# across all samples.

# Columns should represent biological samples.


# Sample Metadata

# Count matrices are not sufficient
# for differential expression analysis.

# We also need sample metadata.


metadata <- data.frame(
  sample = c(
    "Sample1",
    "Sample2",
    "Sample3"
  ),
  condition = c(
    "Control",
    "Control",
    "Disease"
  ),
  batch = c(
    "Batch1",
    "Batch1",
    "Batch2"
  )
)

metadata


# Convert Variables to Factors

metadata$condition <- factor(
  metadata$condition
)

metadata$batch <- factor(
  metadata$batch
)

metadata


# Match Metadata and Count Matrix

colnames(
  gene_counts
)

metadata$sample


# The sample names must correspond.


# Reorder Metadata

metadata <- metadata[
  match(
    colnames(gene_counts),
    metadata$sample
  ),
]

metadata


# Check Matching

all(
  colnames(gene_counts) == metadata$sample
)


# This should return TRUE.


# Sample Information

# Metadata may contain:

# Condition
# Treatment
# Disease status
# Tissue
# Sex
# Age
# Batch
# Sequencing run
# Patient ID


# Example More Complete Metadata

metadata_full <- data.frame(
  sample = paste0(
    "Sample",
    1:6
  ),
  condition = factor(
    c(
      "Control",
      "Control",
      "Control",
      "Disease",
      "Disease",
      "Disease"
    )
  ),
  tissue = factor(
    c(
      "Blood",
      "Blood",
      "Blood",
      "Blood",
      "Blood",
      "Blood"
    )
  ),
  batch = factor(
    c(
      "Batch1",
      "Batch1",
      "Batch2",
      "Batch2",
      "Batch3",
      "Batch3"
    )
  ),
  sex = factor(
    c(
      "F",
      "M",
      "F",
      "M",
      "F",
      "M"
    )
  )
)

metadata_full


# Metadata Structure

str(
  metadata_full
)


# Summary of Metadata

summary(
  metadata_full
)


# Count Matrix and Metadata

# Count matrix:
# Quantitative measurements.

# Metadata:
# Experimental information about samples.


# These two components work together.


# Checking Count Data

summary(
  gene_counts
)


# Total Counts per Sample

sample_total_counts <- colSums(
  gene_counts
)

sample_total_counts


# Plot Library Size

barplot(
  sample_total_counts,
  main = "Total Counts per Sample",
  xlab = "Sample",
  ylab = "Total Counts"
)


# Why Check Library Size?

# Samples may have different sequencing depths.

# One sample may contain:
# 5 million reads.

# Another sample may contain:
# 30 million reads.

# Raw counts are therefore not directly comparable
# without appropriate statistical modeling or normalization.


# Counts per Gene

gene_total_counts <- rowSums(
  gene_counts
)

gene_total_counts


# Genes with Low Counts

low_count_genes <- rowSums(
  gene_counts < 10
)

low_count_genes


# Filter Example

keep <- rowSums(
  gene_counts >= 10
) >= 2

keep


filtered_counts <- gene_counts[
  keep,
]

filtered_counts


# Important:

# Filtering criteria depend on:
# Experimental design
# Number of samples
# Statistical method
# Research question


# Count Distribution

hist(
  as.numeric(
    as.matrix(gene_counts)
  ),
  main = "Distribution of Counts",
  xlab = "Count"
)


# Log Transformation for Visualization

log_counts <- log2(
  gene_counts + 1
)

log_counts


# The +1 avoids log2(0).

# This can be useful for visualization,
# but it is not automatically the correct
# differential expression method.


# Sample Correlation

# Correlation can help assess
# similarity between samples.

sample_correlation <- cor(
  log_counts,
  method = "pearson"
)

sample_correlation


# Visualize Correlation

heatmap(
  sample_correlation,
  main = "Sample Correlation"
)


# Principal Component Analysis

# PCA can help visualize
# major sources of variation among samples.

pca_input <- t(
  log_counts
)

pca_result <- prcomp(
  pca_input,
  scale. = TRUE
)

summary(
  pca_result
)


# PCA Coordinates

pca_result$x


# Plot PC1 and PC2

plot(
  pca_result$x[, 1],
  pca_result$x[, 2],
  xlab = "PC1",
  ylab = "PC2",
  main = "PCA of Samples"
)

text(
  pca_result$x[, 1],
  pca_result$x[, 2],
  labels = rownames(pca_result$x),
  pos = 3
)


# Important:

# PCA is exploratory.

# It can help identify:
# Sample clustering
# Outliers
# Batch effects
# Major biological variation


# PCA Does Not Prove

# PCA does not prove:
# A biological mechanism
# Differential expression
# Causation


# RNA-seq Counts and Normalization

# Raw counts depend on:
# Sequencing depth
# RNA composition
# Library characteristics

# Therefore raw counts should not simply be compared
# between samples using ordinary statistical tests.


# Differential Expression

# Differential expression asks:

# Which genes show evidence of different expression
# between biological conditions?


# Example:

# Control vs Disease


# Conceptual Input

# Count matrix
# +
# Sample metadata
# +
# Experimental design
# ↓
# Differential expression model


# DESeq2

# DESeq2 is a widely used Bioconductor package
# for differential expression analysis of count data.

# A conceptual workflow is:

# Count matrix
# +
# Metadata
# ↓
# DESeqDataSet
# ↓
# Normalization
# ↓
# Model fitting
# ↓
# Statistical testing
# ↓
# Multiple-testing correction
# ↓
# Differential expression results


# DESeq2 Example Structure

# The following code shows the structure
# of a DESeq2 analysis.

# It requires the DESeq2 package.

# library(DESeq2)

# dds <- DESeqDataSetFromMatrix(
#   countData = gene_counts,
#   colData = metadata,
#   design = ~ batch + condition
# )

# dds <- DESeq(dds)

# results_table <- results(
#   dds,
#   contrast = c(
#     "condition",
#     "Disease",
#     "Control"
#   )
# )

# results_table


# Important:

# The DESeq2 workflow should use
# appropriate raw count data and metadata.

# Do not use already normalized expression values
# as the countData input.


# Differential Expression Results

# A typical results table contains:

# BaseMean
# log2FoldChange
# lfcSE
# stat
# pvalue
# padj


# Meaning of Common Columns

# baseMean:
# Average normalized expression across samples.

# log2FoldChange:
# Estimated change between conditions
# on the log2 scale.

# lfcSE:
# Standard error of the log2 fold change.

# stat:
# Test statistic.

# pvalue:
# Unadjusted p-value.

# padj:
# Multiple-testing adjusted p-value.


# Multiple Testing

# RNA-seq can test thousands of genes simultaneously.

# Therefore raw p-values need correction
# for multiple testing.

# False Discovery Rate (FDR) control
# is commonly used.


# Biological Interpretation

# Differential expression results should consider:

# log2 fold change
# adjusted p-value
# expression level
# biological function
# experimental design
# effect size


# Statistical Significance vs Biological Importance

# A gene can have:
# Very small p-value
# Very small fold change

# Another gene can have:
# Larger fold change
# Wider uncertainty

# Therefore statistical significance alone
# should not determine biological importance.


# RNA-seq Data Levels

# It is useful to distinguish:

# Raw reads:
# FASTQ

# Aligned reads:
# BAM

# Quantification:
# Gene or transcript abundance

# Count matrix:
# Genes × samples

# Metadata:
# Sample-level experimental information

# Statistical results:
# Gene-level model output


# From FASTQ to Count Matrix

# FASTQ
# ↓
# Quality Control
# ↓
# Alignment or transcript quantification
# ↓
# Gene-level quantification
# ↓
# Count matrix


# From Count Matrix to Biological Result

# Count matrix
# +
# Metadata
# +
# Experimental design
# ↓
# Normalization
# ↓
# Statistical model
# ↓
# Multiple-testing correction
# ↓
# Differentially expressed genes
# ↓
# Pathway analysis
# ↓
# Biological interpretation


# Sample Metadata Is Critical

# Example:

metadata_full


# If sample labels are incorrect,
# the statistical analysis can also be incorrect.

# Always verify:
# Sample names
# Group labels
# Batch labels
# Tissue labels
# Patient identifiers


# Check for Duplicate Sample Names

anyDuplicated(
  metadata_full$sample
)


# Check for Missing Metadata

colSums(
  is.na(metadata_full)
)


# Check Group Sizes

table(
  metadata_full$condition
)


# Check Batch by Condition

table(
  metadata_full$batch,
  metadata_full$condition
)


# Check Tissue by Condition

table(
  metadata_full$tissue,
  metadata_full$condition
)


# These checks can reveal
# unbalanced or confounded experimental designs.


# Reproducibility

# Keep track of:
# Reference genome
# Annotation version
# Quantification method
# Software versions
# Filtering criteria
# Normalization method
# Statistical model
# Sample metadata


# Different Pipelines Can Produce Different Results

# Differences can arise from:
# Reference annotation
# Alignment method
# Quantification method
# Filtering
# Normalization
# Statistical model


# Therefore document the complete workflow.


# Common Mistakes

# Mistake 1:
# Treating FASTQ files as expression matrices.

# Mistake 2:
# Comparing raw counts directly between samples.

# Mistake 3:
# Losing the connection between count matrix
# and sample metadata.

# Mistake 4:
# Using incorrect sample labels.

# Mistake 5:
# Ignoring batch information.

# Mistake 6:
# Treating technical replicates as biological replicates.

# Mistake 7:
# Using inappropriate statistical tests
# for RNA-seq count data.

# Mistake 8:
# Using raw p-value alone for thousands of genes.

# Mistake 9:
# Treating exploratory PCA as a statistical test.

# Mistake 10:
# Ignoring the experimental design.


# RNA-seq Analysis Checklist

# 1. Verify sample information.
# 2. Inspect FASTQ quality.
# 3. Perform quality control.
# 4. Trim adapters when appropriate.
# 5. Align or quantify reads.
# 6. Generate gene-level measurements.
# 7. Build the count matrix.
# 8. Verify sample names.
# 9. Verify metadata.
# 10. Check library sizes.
# 11. Explore sample relationships.
# 12. Define the statistical design.
# 13. Normalize/model the count data appropriately.
# 14. Perform differential expression analysis.
# 15. Correct for multiple testing.
# 16. Interpret effect sizes and biological relevance.


# Key Takeaways

# FASTQ files contain sequencing reads.

# Quality control evaluates sequencing data quality.

# Alignment maps reads to a reference genome.

# Transcript quantification estimates transcript abundance.

# A count matrix contains features as rows
# and samples as columns.

# Sample metadata describe the biological
# and experimental characteristics of each sample.

# Count matrix and metadata must correspond correctly.

# Library size can differ between samples.

# RNA-seq count data require appropriate statistical methods.

# DESeq2 is commonly used for differential expression
# of RNA-seq count data.

# Thousands of genes are tested,
# so multiple-testing correction is important.

# Experimental design determines how the statistical model
# should be constructed.

# Good RNA-seq analysis connects:
# sequencing data
# +
# sample metadata
# +
# experimental design
# +
# statistical modeling
# +
# biological interpretation.