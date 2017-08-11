context("as_search")

key <- Sys.getenv("NYTIMES_AS_KEY")

test_that("returns the correct stuff", {
  skip_on_cran()
  
  a <- as_search(q = "bailout", begin_date = "20081001", end_date = '20081201')
  Sys.sleep(1)
  b <- as_search(q = "bailout", facet_field = 'section_name', begin_date = "20081001", 
     end_date = '20081201', fl = 'word_count')
  Sys.sleep(1)
  d <- as_search(q = "money", fq = 'The New York Times')
  Sys.sleep(1)
  e <- as_search(q = "money", fq = 'news_desk:("Sports" "Foreign")')
  
  expect_is(a, "list")
  expect_is(a$copyright, "character")
  expect_match(a$copyright, "Copyright")
  expect_is(a$meta, "data.frame")
  expect_is(a$data, "tbl_df")
  expect_is(a$data$web_url, "character")
  
  expect_is(b, "list")
  expect_is(b$meta, "data.frame")
  expect_is(b$data, "tbl_df")
  expect_named(b, c("copyright", "meta", "data", "facets"))
  expect_named(b$data, c("word_count", "score"))
  
  expect_is(d, "list")
  expect_is(d$meta, "data.frame")
  expect_is(e$data, "tbl_df")
  
  expect_is(e, "list")
  expect_is(e$meta, "data.frame")
  expect_is(e$data, "tbl_df")
})

test_that("fails well", {
  skip_on_cran()
  
  expect_error(as_search(key = key), "is missing, with no default")
  expect_error(as_search(q = "bailout", end_date = "tttt", key = key))
})
