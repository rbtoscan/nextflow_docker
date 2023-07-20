# Documentation


## Installing

Before moving forward, make sure you have both docker and nextflow installed in your machine. 

Check here to for [nextflow](https://www.nextflow.io/docs/latest/getstarted.html) and [docker](https://docs.docker.com/engine/install/) installation instructions.
```bash
# check for docker version
docker -v
Docker version 24.0.2, build cb74dfc

# check for nextflow version
nextflow -v
nextflow version 23.04.2.5870
```

Then, clone the repository:
```bash
git clone git@github.com:rbtoscan/nextflow_docker.git
```

After cloning, cd into the repository folder and run the [install.sh](http://install.sh) script. It will create the necessary docker images so that they can be used in the script. This might take from 10 to 20 minutes. If you have a docker image with the same R packages contained in the install/dockerfile/r_task4/Dockerfile, you may consider commenting out this docker build in the install.sh script and replacing the container for an appropriate one in the ryvu_nextflow.nf script. 

The script will also attempt to copy one external R script to the /usr/local/bin folder. 
This might not work for all filesystems, so please copy this file to an appropriate /bin folder so that nextflow can find it later. 
```bash
cd nextflow_docker/
bash install.sh
```


Before running

- Check if the docker images are ready. Run “docker images ls” and you should see something like that :
    
```bash
$ docker image ls
REPOSITORY                 TAG       IMAGE ID       CREATED        SIZE
r_task4                    latest    349887f4b439   2 hours ago    1.12GB
r-base                     latest    5441619af0c0   2 weeks ago    822MB
staphb/samtools            latest    1f1fe155547d   5 weeks ago    145MB
staphb/bowtie2             latest    9fb017126d39   3 months ago   734MB
```
    
- Check if the task4.R script is accessible. Run  “which task4.R” and see if file is found with its path.
    
```bash
$ which task4_genExpress.R
/usr/local/bin/task4_genExpress.R  
```
    
- Make sure you have a reference genome to be used for task 1. You may use one of your choice but the reproduce the exact same results, please use the release14. Create a directory, download the genome from [NCBI](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/), copy it into it and index it using bowtie2 like so:
```bash
bowtie2 GCA_000001405.15_GRCh38_genomic.fna GCA_000001405.15_GRCh38_genomic
```
Keep track of the location of this folder. 


## Running

To run the tool
```bash
./nextflow run ryvu_nextflow.nf --ref_genome <full path to ref_genome index> --input <full path to library.fa>
```

Example:
```bash
./nextflow run ryvu_nextflow.nf --ref_genome /home/storage/files/ref_genome/GCA_000001405.15_GRCh38_genomic --input /home/storage/files/library.fa
```
You may also edit the ryvu_nextflow.nf script at the top and replace the param.ref_genome and param.input variables for their corresponding paths. If you do that, you may run without any additional parameters:

```bash
./nextflow run ryvu_nextflow.nf 
```

