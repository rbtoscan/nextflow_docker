FROM r-base:latest
    RUN R -e "install.packages('dplyr',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
    RUN R -e "install.packages('SummarizedExperiment',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
    RUN R -e "install.packages('biomaRt',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
    RUN R -e "install.packages('readr',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
    RUN R -e "install.packages('DT',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
    RUN R -e "install.packages('BiocManager',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
    RUN R -q -e 'BiocManager::install("TCGAbiolinks")' 
