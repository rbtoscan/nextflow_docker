library(TCGAbiolinks)
library(dplyr)
library(DT)
library(SummarizedExperiment)
library(biomaRt)
library(readr)

# input parameter - the gene list
args = commandArgs(trailingOnly=TRUE)
gene_list <- args[1]


listSamples <- c(
  "TCGA-A7-A13D-01A-13R-A12P-07","TCGA-E9-A1RH-11A-34R-A169-07")

# Query platform Illumina HiSeq with a list of barcode 
query <- GDCquery(
  project = "TCGA-BRCA", 
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  barcode = listSamples
)

print ('query')
# Download a list of barcodes with platform IlluminaHiSeq_RNASeqV2
GDCdownload(query)

print ('prepare')
# prepare expression matrix with geneID in the rows and samples (barcode) in the columns
BRCA.Rnaseq.SE <- GDCprepare(query)

print ('create')
# create a matrix that can be manipulated
BRCAMatrix <- data.frame(assay(BRCA.Rnaseq.SE,"unstranded"))

print ('convert')
# convert the index column into a separate column
BRCAMatrix <- tibble::rownames_to_column(BRCAMatrix, var = "ensembl_gene_id_version")

print ('fetch')
# fetch gene ids from samples in ensembl format
gene_ids <- rownames(assay(BRCA.Rnaseq.SE, "unstranded"))

print ('mart')
# make query using mart
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
query_result <- getBM(attributes = c('ensembl_gene_id_version',
                                     'hgnc_symbol'),
                      filters = 'ensembl_gene_id_version',
                      values = gene_ids,
                      mart = mart)
args = commandArgs(trailingOnly=TRUE)
gene_list <- args[1]

# merge results
samples_expression <- merge(BRCAMatrix,query_result,by='ensembl_gene_id_version')
samples_expression <- samples_expression[,c(4,2,3)]

# clean up vars
rm(BRCAMatrix,mart,query,query_result,BRCA.Rnaseq.SE,gene_ids,listSamples)

genes.mapped <- read.csv(gene_list)
colnames(genes.mapped) <- "gene"

# filtering expression table based on genes of interest
samples_expression_gene_filtered <- samples_expression %>%
  filter(hgnc_symbol %in% genes.mapped$gene)

print ('final_table')
cat(format_csv(samples_expression_gene_filtered))

