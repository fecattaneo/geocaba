#···············································································
# 1) Directories
#···············································································

# Clear all objects
rm(list = ls())

# Get working directory for the repository
wd <- getwd() 

# Data load and analysis
data <- paste0(wd, "/00. Data load")
analysis <- paste0(wd, "/01. Analysis")

# Sub-directories
for (folder in c(data, analysis)) {
  for (dir in c("do", "raw", "dta", "out")) {
    if (!dir.exists(paste0(folder, "/", dir))) dir.create(paste0(folder, "/", dir), recursive = TRUE)
    }
  }

#···············································································
# 2) Libraries
#···············································································

libraries <- c("ggplot2", "dplyr", "tidyr", "lubridate", "data.table", "sf")

# Function to check, install, and load libraries
install_and_load_libraries <- function(libs) {
  for (lib in libs) {
    if (!requireNamespace(lib, quietly = TRUE)) {
      cat("Installing library:", lib, "\n")
      install.packages(lib)
    } else {
      cat("Library", lib, "is already installed.\n")
    }
    
    # Load the library
    library(lib, character.only = TRUE)
    cat("Library", lib, "loaded.\n")
  }
}