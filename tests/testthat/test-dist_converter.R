test_that("Conversion from feet to meters and meters to feet works", {
  # Convert the example to a unit test comparing sameness
  expect_equal(dist_converter(100, unit_from = "meters", unit_to = "feet"), 328)
  expect_warning(dist_converter(25, unit_from = "feet", unit_to = "feet"))
  # Error for cold feet
  expect_error(dist_converter("cold", unit_from="feet", unit_to="meters"))
})
