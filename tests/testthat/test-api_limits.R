context("api_limits")

test_that("returns list with limits", {
  vcr::use_cassette("api_limits", {
    expect_is(api_limits("as"), "list")
    expect_is(api_limits("geo"), "list")
  })
})

test_that("fails well", {
  skip_on_cran()
  
  expect_error(api_limits(key = ""), "need an API key for NYTIMES_AS_KEY")
  expect_error(api_limits(api = "foo"), "only works for")
})
