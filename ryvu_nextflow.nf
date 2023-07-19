nextflow.enable.dsl=2

// declaration of two inputs necessary to run this script. they can be overriden when running by adding the --input <library.fa> and --ref_genome <ref_genome> to the $ nextflow run ryvu_nextflow.nf command

params.input = '/Users/rodolfotoscan/Documents/trabalho/busca/applications/2023/ryvu/test/workdir/library.fa'
params.ref_genome = '/Users/rodolfotoscan/Documents/trabalho/busca/applications/2023/ryvu/test/ref_information/GRCh38_28122022/GCF_000001405.40_GRCh38.p14_genomic'

process task1_mapping {
    container = 'staphb/bowtie2'
    output:
      path 'mapping.sam'
    script:
      """
      bowtie2 -p 2 -x '${params.ref_genome}' -f '${params.input}' > mapping.sam
      """
}

process task2_fetchCoords {
    container = 'staphb/samtools'
    input:
      path mapping
    output:
      path 'mapping_coords.tsv'
    script:
      """
      cat $mapping | samtools view -F 4   | cut -f2,3,4,6 | sed 's/.\$//' | awk '{  if (\$1 == 16) (\$1 = "r") ; else \$1 = "f"  ; { print \$2"\t"\$3"\t"\$3+\$4"\t"\$1 } }' > mapping_coords.tsv      
      """
}

process task3_fetchGenes {
    container = 'staphb/samtools'
    input:
      path mapping
    output:
      path 'gene_list.txt'
    script:
      """
      cat $mapping | samtools view -F 4 | cut -f1 | cut -f3 -d'|' | sort | uniq > gene_list.txt
      """
}


process task4_getGeneExpression {
    container = 'task4_image'

    input:
      path gene_list

    output:
      path 'gene_expression.csv'

     script:
    """
    task4_genExpress.R $gene_list  | sed '1,/final_table/d'  > gene_expression.csv
    
    """
}


workflow {
	task1_mapping()
	def mapping = task1_mapping.out.view()
	task2_fetchCoords(mapping)
	task2_fetchCoords.out.view()
	task3_fetchGenes(mapping)
	def gene_list = task3_fetchGenes.out.view()
	task4_getGeneExpression(gene_list)
  task4_getGeneExpression.out.view()
}
