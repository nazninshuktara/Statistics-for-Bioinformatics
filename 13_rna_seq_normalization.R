# RNA-seq Normalization
# Normalization adjusts for systematic differences between RNA-seq samples.

# Why Normalization?
# RNA-seq samples can have different sequencing depths.
# Raw counts are therefore not directly comparable between samples.

# Example library sizes
sample_A <- 1000000
sample_B <- 2000000
sample_C <- 5000000

sample_A
sample_B
sample_C

# A sample with more sequencing reads can have larger raw counts
# even when the underlying expression level is similar.

# Raw Count Example
gene_counts <- c(
  Sample_A = 100,
  Sample_B = 200,
  Sample_C = 500
)

gene_counts

# Counts Per Million (CPM)
# CPM adjusts counts according to the total number of reads in each sample.

# CPM formula:
# CPM = count / total library size * 1,000,000

count <- 100
library_size <- 1000000

cpm <- count / library_size * 1000000
cpm

# Example CPM calculation
count_A <- 100
count_B <- 200

library_A <- 1000000
library_B <- 2000000

cpm_A <- count_A / library_A * 1000000
cpm_B <- count_B / library_B * 1000000

cpm_A
cpm_B

# CPM makes counts easier to compare across sequencing depths.

# CPM for a Count Matrix
counts <- matrix(
  c(
    100, 200, 500,
    50, 100, 250,
    300, 600, 1500,
    20, 40, 100
  ),
  nrow = 4,
  byrow = TRUE
)

rownames(counts) <- c("Gene_A", "Gene_B", "Gene_C", "Gene_D")
colnames(counts) <- c("Sample_A", "Sample_B", "Sample_C")

counts

# Calculate library sizes
library_sizes <- colSums(counts)

library_sizes

# Calculate CPM manually
cpm_matrix <- sweep(
  counts,
  2,
  library_sizes,
  "/"
) * 1000000

cpm_matrix

# CPM is useful for exploratory analysis and visualization.
# It is not the same as the normalization method used by DESeq2.

# Counts vs CPM
# Raw counts are integer read counts.
# CPM is a library-size-adjusted representation.
# Count-based differential expression methods generally use raw counts as input.

# FPKM / RPKM
# FPKM and RPKM account for sequencing depth and transcript length.
# RPKM is commonly used for single-end RNA-seq.
# FPKM is commonly used for paired-end RNA-seq.

# TPM
# TPM also accounts for transcript length and sequencing depth.
# TPM values within a sample sum to approximately one million.

# TPM and FPKM/RPKM are useful for expression abundance summaries.
# They are generally not the default input for count-based DESeq2 analysis.

# Important distinction:
# Raw counts -> count-based differential expression methods
# CPM -> exploratory analysis and visualization
# TPM/FPKM -> expression abundance summaries

# Why Not Simply Divide All Counts by Library Size?
# Simple library-size normalization assumes that total RNA output is
# comparable between samples.
# Strong compositional differences can violate this assumption.

# DESeq2 Normalization
# DESeq2 uses a median-of-ratios method.
# It estimates a size factor for each sample.

# Conceptual idea:
# 1. Calculate a typical expression level for each gene.
# 2. Compare each sample to these typical levels.
# 3. Estimate a size factor from the median of the ratios.
# 4. Use size factors to make samples comparable.

# DESeq2 size factors are not simply the raw library sizes.

# Runnable DESeq2 Example
# This example uses a small artificial RNA-seq count matrix.

if (!requireNamespace("DESeq2", quietly = TRUE)) {
  stop(
    "DESeq2 is not installed. Install it with BiocManager before running this example."
  )
}

library(DESeq2)

# Create example count matrix
dds_counts <- matrix(
  c(
    120, 130, 125, 300, 320, 310,
    500, 520, 510, 480, 490, 500,
    80, 75, 85, 200, 210, 190,
    1000, 950, 1100, 900, 920, 880,
    50, 55, 48, 120, 130, 125,
    250, 260, 245, 600, 620, 590,
    300, 310, 295, 320, 315, 325,
    700, 680, 720, 650, 670, 660,
    40, 45, 42, 100, 110, 105,
    150, 160, 145, 400, 420, 390
  ),
  nrow = 10,
  byrow = TRUE
)

rownames(dds_counts) <- paste0("Gene_", 1:10)

colnames(dds_counts) <- c(
  "Control_1",
  "Control_2",
  "Control_3",
  "Treatment_1",
  "Treatment_2",
  "Treatment_3"
)

dds_counts

# Create sample metadata
metadata <- data.frame(
  condition = factor(
    c(
      "Control",
      "Control",
      "Control",
      "Treatment",
      "Treatment",
      "Treatment"
    ),
    levels = c("Control", "Treatment")
  )
)

rownames(metadata) <- colnames(dds_counts)

metadata

# Check metadata and count matrix
all(rownames(metadata) == colnames(dds_counts))

# Create DESeq2 object
dds <- DESeqDataSetFromMatrix(
  countData = dds_counts,
  colData = metadata,
  design = ~ condition
)

dds

# Estimate size factors
dds <- estimateSizeFactors(dds)

# View size factors
sizeFactors(dds)

# Extract normalized counts
normalized_counts <- counts(
  dds,
  normalized = TRUE
)

normalized_counts

# Compare raw and normalized counts
dds_counts["Gene_1", ]

normalized_counts["Gene_1", ]

# Library sizes before normalization
colSums(dds_counts)

# Normalized column sums
colSums(normalized_counts)

# The normalized column sums are not necessarily identical.
# DESeq2 normalization is not simply total-count scaling.

# Size factors
# Size factors represent sample-specific scaling factors.
# They account for sequencing depth and composition differences.

sizeFactors(dds)

# Normalized count concept:
# normalized count = raw count / size factor

# Verify this concept for one gene
gene1_raw <- dds_counts["Gene_1", ]

gene1_size_factor <- sizeFactors(dds)

gene1_manual <- gene1_raw / gene1_size_factor

round(gene1_manual, 2)

# Compare with DESeq2 output
round(normalized_counts["Gene_1", ], 2)

# The values should match apart from numerical rounding.

# Running the DESeq2 Model
# DESeq2 can also perform differential expression analysis.

dds <- DESeq(
  dds,
  fitType = "mean"
)

# Extract results
results_table <- results(dds)

results_table

# View adjusted p-values
results_table$padj

# View log2 fold changes
results_table$log2FoldChange

# Differential expression is not performed by simply applying
# a t-test to normalized counts.

# Low-count Filtering
# Very low-count genes provide limited statistical information.

gene_total_counts <- rowSums(dds_counts)

gene_total_counts

# Example filtering rule
keep <- rowSums(dds_counts >= 10) >= 3

keep

filtered_counts <- dds_counts[keep, ]

filtered_counts

# Filtering thresholds depend on study design and analysis goals.
# Do not remove genes using an arbitrary threshold without justification.

# Normalization vs Transformation
# Normalization adjusts for systematic differences between samples.
# Transformation changes the scale or distribution of the data.

# Examples:
# Normalization -> DESeq2 size factors
# Transformation -> log2, VST, rlog

# Log Transformation
normalized_values <- c(10, 100, 1000, 10000)

log2_values <- log2(normalized_values + 1)

log2_values

# Log transformation compresses large values.
# It is useful for visualization and exploratory analysis.

# RNA-seq Visualization
# Normalized counts can be transformed before visualization.

log2_normalized <- log2(cpm_matrix + 1)

log2_normalized

# Heatmap
heatmap(
  log2_normalized,
  main = "Log2 Transformed Normalized Expression"
)

# Visualization transformations are not automatically appropriate
# for differential expression testing.

# Variance Stabilizing Transformation
# DESeq2 provides variance stabilizing transformation (VST).

vsd <- varianceStabilizingTransformation(
  dds,
  blind = FALSE
)

vsd_matrix <- assay(vsd)

head(vsd_matrix)

# VST helps make expression values more suitable for:
# PCA
# clustering
# heatmaps
# sample-level visualization

# PCA
plotPCA(
  vsd,
  intgroup = "condition"
)

# rlog
# DESeq2 also provides regularized log transformation.
#
# rld <- rlog(dds, blind = FALSE)
# rld_matrix <- assay(rld)

# VST and rlog are transformations, not replacements for
# DESeq2's count-based differential expression model.

# Normalization and Batch Effects
# Normalization does not automatically remove batch effects.

metadata_batch <- data.frame(
  condition = factor(
    c(
      "Control",
      "Control",
      "Control",
      "Treatment",
      "Treatment",
      "Treatment"
    ),
    levels = c("Control", "Treatment")
  ),
  batch = factor(
    c(
      "Batch1",
      "Batch1",
      "Batch2",
      "Batch1",
      "Batch2",
      "Batch2"
    )
  )
)

rownames(metadata_batch) <- colnames(dds_counts)

metadata_batch

# Batch can be included in the DESeq2 design:
#
# dds_batch <- DESeqDataSetFromMatrix(
#   countData = dds_counts,
#   colData = metadata_batch,
#   design = ~ batch + condition
# )

# batch accounts for systematic batch differences.
# condition estimates the biological effect of interest.

# Important:
# Normalization != Batch Correction
# Transformation != Batch Correction

# Compositional Effects
# RNA-seq data are compositional.
# A small number of highly expressed genes can affect
# the relative abundance of other genes.

# This is one reason specialized RNA-seq normalization methods
# are preferred over simple total-count scaling for differential analysis.

# Differential Expression Workflow
# 1. Start with raw count matrix.
# 2. Check sample metadata.
# 3. Filter very low-count genes when appropriate.
# 4. Estimate normalization factors.
# 5. Build the statistical model.
# 6. Perform differential expression analysis.
# 7. Apply multiple-testing correction.
# 8. Transform data for visualization when appropriate.
# 9. Interpret biological effect size and statistical evidence.

# Common Mistakes

# Mistake 1:
# Using raw counts directly for plots comparing samples with
# very different library sizes.

# Mistake 2:
# Treating TPM as automatically interchangeable with raw counts.

# Mistake 3:
# Using log2(count + 1) as a replacement for RNA-seq normalization.

# Mistake 4:
# Using normalized expression values as direct input to DESeq2
# instead of raw count data.

# Mistake 5:
# Assuming normalization removes batch effects.

# Mistake 6:
# Removing biological differences during aggressive correction.

# Mistake 7:
# Filtering genes without considering the experimental design.

# Bioinformatics Example
# Suppose two RNA-seq samples have:
#
# Sample 1: 10 million reads
# Sample 2: 20 million reads
#
# A gene has:
#
# Sample 1: 100 reads
# Sample 2: 200 reads
#
# Raw counts suggest a two-fold difference.
# After accounting for library size, the relative abundance can be similar.
#
# This illustrates why sequencing depth must be considered.

# Key Takeaways

# 1. RNA-seq samples can have different library sizes.
# 2. Raw counts are affected by sequencing depth.
# 3. CPM provides simple library-size adjustment.
# 4. TPM/FPKM/RPKM describe expression abundance but are not
#    interchangeable with raw counts for count-based DE analysis.
# 5. DESeq2 estimates sample-specific size factors using
#    a median-of-ratios approach.
# 6. Normalization and transformation are different concepts.
# 7. Normalization does not automatically remove batch effects.
# 8. Raw counts are typically used as input for DESeq2.
# 9. VST/rlog can be useful for visualization and exploratory analysis.
# 10. Statistical normalization should preserve genuine biological variation.