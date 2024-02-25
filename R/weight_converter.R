weight_converter <-
function(weight_value, unit_from, unit_to) {
  # Conversion factors for different weight units
  conversion_factors <- c(gram = 1, kilogram = 1000,
                          pound = 453.592, ounce = 28.3495)
  
  # Convert value from the unit_from to gram
  in_grams <- weight_value * conversion_factors[unit_from]
  
  # Convert value from gram to the unit_to
  return(unname(in_grams / conversion_factors[unit_to]))
}
