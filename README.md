# Documentation


## Installation and how to run

Before moving forward, make sure you have both docker and nextflow installed in your machine. 
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

After cloning, cd into the repository folder and run the [install.sh](http://install.sh) script. It will create the necessary docker images so that they can be used in the script. It will also attempt to copy one external R script to the /usr/local/bin folder. This might not work for all filesystems, so please copy this file to an appropriate /bin folder so that nextflow can find it later. 
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
$ which task4.R
/usr/local/bin/task4.R    
```
    
- Make sure you have a reference genome to be used for task 1.  You may use one of your choice but the reproduce the exact same results, we may use the same release. I am making my version available in a google drive. Downlod

## Results
