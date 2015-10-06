context("geo_search")

key <- Sys.getenv("NYTIMES_GEO_KEY")

test_that("returns the correct stuff", {
  skip_on_cran()
  
  a <- geo_search(country_code = 'US', key = key)
  # b <- geo_search(elevation = '1_', feature_class = 'P', key = key, limit = 2)
  # d <- geo_search(elevation = '_3000', feature_class = 'P', key = key, limit = 2)
  e <- geo_search(feature_class = 'P', country_code = 'US', population = '50000_', key = key)
  
  # retruns the correct classes
  expect_is(a, "list")
  expect_is(a$copyright, "character")
  expect_match(a$copyright, "Copyright")
  expect_is(a$data, "data.frame")
  
  # expect_is(b, "list")
  # expect_is(b$meta, "data.frame")
  # expect_is(b$data, "data.frame")
  # 
  # expect_is(d, "list")
  # expect_is(d$meta, "data.frame")
  expect_is(e$data, "data.frame")
  
  expect_is(e, "list")
  expect_is(e$meta, "data.frame")
  expect_is(e$data, "data.frame")
  
  # returns correct results
  expect_equal(unique(a$data$country_code), "US")
  # FIXME - i think elevation parameter is being ignored
  ## expect_more_than(min(na.omit(as.numeric(b$data$elevation))), 2000)
  # expect_less_than(max(na.omit(as.numeric(d$data$elevation))), 3000)
  expect_equal(unique(e$data$country_code), "US")
  # expect_more_than(min(na.omit(e$data$population)), 50000L)
  
  # returns the correct dimensions
  expect_equal(length(a), 3)
  expect_equal(NCOL(a$meta), 2)
})

test_that("fails well", {
  skip_on_cran()
  
  # bad latitude input
  expect_error(geo_search(latitude = "asdf", key = key), "Internal Server Error")
  # bad countr name doesnt error, but returns no results
  expect_equal(NROW(geo_search(country_name = 45, key = key)$data), 0)
})
