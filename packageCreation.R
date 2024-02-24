

setwd("/Users/bg423/Documents/my_packages")

library(usethis)
# Create a package skeleton named unitConverter
# create_package("unitConverter")

# View and check the R package directory
dir(".")

# Read in distance data
# library(readr)
# distance_data <- read_csv("data-raw/distance_data.csv")

# Print the first six rows of distance_data
# head(distance_data,6)

# Add the distance data to the R package
# use_data(distance_data)

# Make an R Markdown template file
use_rmarkdown_template("Distance Conversion Examples")


