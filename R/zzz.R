rtimes_compact <- function (x) Filter(Negate(is.null), x)

nnlcol <- function(x) if(!is.null(x)) paste(x, collapse = ",") else NULL
nnlna <- function(x) if(!is.null(x)) paste(x, collapse = ",") else NA

t_base <- function() "http://api.nytimes.com/svc/"

rtimes_GET <- function(url, args, ...){
  ans <- GET(url, query = args, ...)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  jsonlite::fromJSON(tt, FALSE) 
}
