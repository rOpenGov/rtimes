context("api_limits")

key <- Sys.getenv("NYTIMES_AS_KEY")

test_that("returns list with limits", {
  skip_on_cran()
  
  expect_is(api_limits("as"), "list")
})

test_that("fails well", {
  skip_on_cran()
  
  expect_error(api_limits(key = ""), "need an API key for NYTIMES_AS_KEY")
  expect_error(api_limits(api = "foo"), "only works for")
})
