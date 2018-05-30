context("geo_search")

key <- Sys.getenv("NYTIMES_GEO_KEY")

test_that("returns the correct stuff", {  
  vcr::use_cassette("geo_search", {
    a <- geo_search(country_code = 'US', key = key)
    expect_is(a, "list")
    expect_is(a$copyright, "character")
    expect_match(a$copyright, "Copyright")
    expect_is(a$data, "data.frame")
    expect_equal(unique(a$data$country_code), "US")
    expect_equal(length(a), 3)
    expect_equal(NCOL(a$meta), 2)
  })

  vcr::use_cassette("geo_search_params", {
    e <- geo_search(feature_class = 'P', country_code = 'US', population = '50000_', key = key)
    expect_is(e$data, "data.frame")
    expect_is(e, "list")
    expect_is(e$meta, "data.frame")
    expect_is(e$data, "data.frame")
    expect_equal(unique(e$data$country_code), "US")
  })
})

test_that("fails well", {
  skip_on_cran()
  
  # bad latitude input
  expect_error(geo_search(latitude = "asdf", key = key), "Internal Server Error")
  # bad countr name doesnt error, but returns no results
  expect_equal(NROW(geo_search(country_name = 45, key = key)$data), 0)
})
