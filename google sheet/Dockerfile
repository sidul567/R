FROM rocker/shiny:4
# install R packages required 
# Change the packages list to suit your needs
RUN R -e "install.packages(c('shiny', 'googlesheets4', 'httr'), dependencies=TRUE)"

WORKDIR /home/shinyusr
COPY app.R app.R 
COPY .secrets .secrets
CMD Rscript app.R
