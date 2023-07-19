
# pulling necessary docker images
docker pull staphb/samtools
docker pull staphb/bowtie2
docker pull r-base

# creating a custom docker image
docker build -t task4_image  install/dockerfiles/r_task4/

# copy R script to /bin folder. Replace path accordingly
chmod +x install/script/task4_genExpress.R
cp install/script/task4_genExpress.R /usr/local/bin
cp install/script/nextflow /usr/local/bin

echo "location of the auxiliary script:" "$(which task4_genExpress.R)"
echo "location of the nextflow script :" "$(which nextflow)"
