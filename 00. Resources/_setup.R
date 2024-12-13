#···············································································
# 1) Directories
#···············································································

# Clear all objects
rm(list = ls())

# Get current working directory
wd <- getwd()

# Traverse upward to find the root Git directory
while(!file.exists(file.path(wd, ".git"))) {
  wd <- dirname(wd)
}

# Data load and analysis
data <- paste0(wd, "/01. Data load")
analysis <- paste0(wd, "/02. Analysis")

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

install_and_load_libraries(libraries)