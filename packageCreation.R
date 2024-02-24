

setwd("/Users/bg423/Documents/my_packages")

library(usethis)
library(devtools)
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


# Define the dist_converter function
dist_converter <- function(dist_value, unit_from, unit_to) {
  # Fill in the missing parts of the if-else if-else flow
  if (unit_from == "feet" && unit_to == "meters") {
    return(dist_value / 3.28)
  } else if (unit_from == "meters" && unit_to=="feet") {
    return(dist_value * 3.28)
  } else if (unit_from == unit_to) {
    warning("unit_from and unit_to are the same, returning dist_value")
    return(dist_value)
  } else {
    stop("This function only supports conversions between feet and meters.")
  }
}

# Use dist_converter to convert 100 meters to feet
dist_converter(100, unit_from="meters", unit_to="feet")

# Save the dist_converter function to an R file using base R
dump("dist_converter", file="R/dist_converter.R")

# isntall the R package and ry it out
devtools::install()

# Call the dist_converter function from the unitConverter package
unitConverter:::dist_converter(dist_value = distance_data$value[2],
                               # Access the second row for unit
                               unit_from = distance_data$unit[2],
                               unit_to = "feet")

# Check if gg_plot2 meets CRAN naming standards
available("gg_plot2")

usethis::use_mit_license()

# add weight_converter function
weight_converter <- function(weight_value, unit_from, unit_to) {
  # Conversion factors for different weight units
  conversion_factors <- c(gram = 1, kilogram = 1000,
                          pound = 453.592, ounce = 28.3495)

  # Convert value from the unit_from to gram
  in_grams <- weight_value * conversion_factors[unit_from]

  # Convert value from gram to the unit_to
  return(unname(in_grams / conversion_factors[unit_to]))
}

dump("weight_converter", file="R/weight_converter.R")

# test it
weight_converter(100, unit_from = "kilogram", unit_to = "pound")

# Import package files to current R session
devtools::load_all()

