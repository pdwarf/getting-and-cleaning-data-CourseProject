# Course Project README

For detailed information about the data sets, their variables and transformations that are applied, see the codebook.

## Steps to get the script run_analysis.R to work

1. Download the data from the source specified in the codebook and save it to a folder on your local drive. This will create a ```UCI HAR Dataset``` folder.
2. Put ```run_analysis.R``` in the parent folder of ```UCI HAR Dataset```, then set it as your working directory using the ```setwd()``` function in RStudio.
3. Run ```source("run_analysis.R")``` which will generate a new file ```tiny_data.csv``` in your working directory.

## Dependencies

```run_analysis.R``` requires the packages ```reshape2``` and ```data.table```. 