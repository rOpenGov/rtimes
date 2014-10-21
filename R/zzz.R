rtimes_compact <- function (x) Filter(Negate(is.null), x)

nnlcol <- function(x) if(!is.null(x)) paste(x, collapse = ",") else NULL
nnlna <- function(x) if(!is.null(x)) paste(x, collapse = ",") else NA

t_base <- function() "http://api.nytimes.com/svc/"

rtimes_GET <- function(url, args, callopts, ...){
  ans <- GET(url, query = args, callopts, ...)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  jsonlite::fromJSON(tt, FALSE) 
}

meta <- function(x){
  data.frame(pop(x, c("results","copyright")), stringsAsFactors = FALSE)
}

as_meta <- function(x){
  data.frame(x$response$meta, stringsAsFactors = FALSE)
}

cright <- function() "Copyright (c) 2013 The New York Times Company.  All Rights Reserved."

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}

pop <- function(x, namez) {
  getnames <- names(x)[!names(x) %in% namez]
  x[ getnames ]
}
