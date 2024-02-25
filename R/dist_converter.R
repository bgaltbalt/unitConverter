# Add the title
#' Convert between distances
#'
# Add the description
#' Performs the conversion based on specified unit_from and unit_to values.
#'
# Add appropriate tag and details to document the first argument
#' @param dist_converter() A numerical distance value to be converted.
#' @param dist_value value to be converted
#' @param unit_from which unit you're converting from
#' @param unit_to which unit you're converting to
#' @returns A numeric distance value in the unit specified as unit_to.
#' @export
#' @examples
#' # Meters to feet
#' dist_converter(4, "meters", "feet")
#' # Feet to meters
#' dist_converter(10.5, "feet", "meters")
#' \dontrun{
#' # Feet to feet (gives warning)
#' dist_converter(100, "feet", "feet")
#' # Non-numeric `dist_value` gives error
#' dist_converter("short", "feet", "meters")
#' }

dist_converter <-
function(dist_value, unit_from, unit_to) {
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
