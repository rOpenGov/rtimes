context("as_search")

key <- Sys.getenv("NYTIMES_AS_KEY")

test_that("returns the correct stuff", {
  skip_on_cran()
  
  a <- as_search(q = "bailout", begin_date = "20081001", end_date = '20081201')
  b <- as_search(q = "bailout", facet_field = 'section_name', begin_date = "20081001", 
     end_date = '20081201', fl = 'word_count')
  d <- as_search(q = "money", fq = 'The New York Times')
  e <- as_search(q = "money", fq = 'news_desk:("Sports" "Foreign")')
  
  expect_is(a, "list")
  expect_is(a$copyright, "character")
  expect_match(a$copyright, "Copyright")
  expect_is(a$meta, "data.frame")
  expect_is(a$data, "list")
  expect_is(a$data[[1]], "as_search")
  
  expect_is(b, "list")
  expect_is(b$meta, "data.frame")
  expect_is(b$data, "list")
  expect_named(b$data, c("meta", "docs", "facets"))
  
  expect_is(d, "list")
  expect_is(d$meta, "data.frame")
  expect_is(e$data, "list")
  
  expect_is(e, "list")
  expect_is(e$meta, "data.frame")
  expect_is(e$data, "list")
})

test_that("fails well", {
  skip_on_cran()
  
  expect_error(as_search(key = key), "is missing, with no default")
  expect_error(as_search(q = "bailout", end_date = "tttt", key = key))
})
