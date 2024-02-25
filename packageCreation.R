

# setwd("/Users/bg423/Documents/my_packages")

library(usethis)
library(devtools)

# Create a package skeleton named unitConverter
create_package("unitConverter")

# View and check the R package directory
dir(".")

# Read in distance data
library(readr)
distance_data <- read_csv("data-raw/distance_data.csv")

# Print the first six rows of distance_data
head(distance_data,6)

# Add the distance data to the R package
use_data(distance_data)

# Make an R Markdown template file
use_rmarkdown_template("Distance Conversion Examples")

####
####  Adding function to package -----------------------------
####
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

####
#### Isntall the created R package and try it out ----------------------------
####

devtools::install()
library(unitConverter)

# Call the dist_converter function from the unitConverter package
unitConverter:::dist_converter(dist_value = distance_data$value[2],
                               # Access the second row for unit
                               unit_from = distance_data$unit[2],
                               unit_to = "feet")

# Check if gg_plot2 meets CRAN naming standards
available("gg_plot2")

# add license
usethis::use_mit_license()

####
####   adding functions ---------------------------------------------------
####

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

# Import package files to current R session, This will indicate if there is error in package functions
devtools::load_all()

####
####   Set package dependencies ---------------------------------------------------
####

# set package dependencies
# Suggest ggplot2 >= 3.0.0
usethis::use_package("ggplot2", type = "suggest", min_version = "3.0.0")
use_package("dplyr", type = "Import", min_version = "1.1.0")

####
####   Help file. Documentation with roxygen2 ---------------------------------------------------
####

# add roxygen comment #' in function header of each function.R in R folder (see dist_converter.R)
# then, call:
library(roxygen2)
roxygenize() # this will create help file in the man directory!

####
####   Creating Vignettes ---------------------------------------------------
####

# create vignettes for the package. First, have a look into examples:
browseVignettes("ggplot2")

# it creates the vignette
use_vignette("dist_conversion", title = "Distance Conversion Examples")

# now, build vignette
build_vignettes()

####
####    Unit testing    ---------------------------------------------------
####

# use_testthat() creates the testing framework
# It is important for catching bugs and validate its functionality!
library(testthat)

use_testthat()

# create test file
use_test("dist_converter.R")
use_test("weight_converter.R")

# Convert an example into a test
# Review the example
dist_converter(100, unit_from = "meters", unit_to = "feet")
# Convert the example to a unit test comparing sameness
# Perhaps, I have to add these checks into relevant scripts created by use_test()
expect_equal(dist_converter(100, unit_from = "meters", unit_to = "feet"), 328)
expect_warning(dist_converter(25, unit_from = "feet", unit_to = "feet"))
# Error for cold feet
expect_error(dist_converter("cold", unit_from="feet", unit_to="meters"))

# Running test using test file creater earlier (i.e., for specific function)
test_file("tests/testthat/test-dist_converter.R")
# Running tests on examples of help is good idea!
test_example("man/dist_converter.Rd")

# Run all package tests
test_package("unitConverter")


####
####   Add description into description file, and Document data -----------------
####

# Enter and modify description file as needed.

# create R/distance_data.R file to describe the data in the package (if any)
use_r("distance_data")

# Below is an example entries for example data:

# Add header and description
#' Distance values and units
#'
#' Distance values and corresponding unit (feet, meters, or inches)
# Update format
#' @format Data frame with two columns and 1000 rows
# Document column names and information
#' \describe{
#' \item{value}{Numeric distance value}
#' \item{unit}{Distance unit}
#' }
# Add example and string of data name
#' @example
#'  distance_data
"distance_data"

# After adding above description for data file, run roxynize to add Rd file in man(manual)
roxygen2::roxygenize()


####
####  Final check of newly created R package  -------------------------------------------
####

# You've done it! You've successfully built an R package from beginning to end.
# You've added functions and data, documented them, learned about licensing your package,
# updated the DESCRIPTION file, set package dependencies, and so much more! As one final assurance,
# we can run a function from the devtools package.
# This function goes through an exhaustive list of diagnostics to ensure package integrity.

# Note that this exercise will take up to 30 seconds to initialize.
# It could take up to 15 seconds to run your code too. Be patient and you'll get all the lovely messages
# with a summary at the end of your package's assessment.
# Assess the package
devtools::check()



