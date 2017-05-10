rc <- function(x) Filter(Negate(is.null), x)

nnlcol <- function(x) if (!is.null(x)) paste(x, collapse = ",") else NULL
nnlna <- function(x) if (!is.null(x)) paste(x, collapse = ",") else NA

t_base <- function() "https://api.nytimes.com/svc/"
#cg_base <- function() paste0(t_base(), "politics/v3/us/legislative/congress/")

p_base <- function() "https://api.propublica.org/"
cf_base <- function(version = "v1") paste0(p_base(), "campaign-finance/", version)
cg_base <- function(version = "v1") paste0(p_base(), "congress/", version)
add_key <- function(x) httr::add_headers('X-API-Key' = x)

rtimes_GET <- function(url, args, parse = TRUE, ...) {
  ans <- GET(url, query = args, ...)
  stop_for_status(ans)
  if (parse) return(jsonlite::fromJSON(cu8(ans), TRUE, flatten = TRUE))
  jsonlite::fromJSON(cu8(ans), FALSE)
}

cu8 <- function(x) content(x, as = "text", encoding = "UTF-8")

meta <- function(x){
  data.frame(pop(x, c("results","copyright")), stringsAsFactors = FALSE)
}

as_meta <- function(x){
  tibble::as_data_frame(x$response$meta)
}

cright <- function() "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."

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

check_key <- function(x, y = "NYTIMES_GEO_KEY"){
  tmp <- if (is.null(x)) Sys.getenv(y, "") else x
  if (tmp == "") stop("need an API key for ", y, call. = FALSE) else tmp
}

do_data_frame <- function(x, z = "members") {
  tmp <- pop(x$results[[1]], z)
  tmp <- as.list(unlist(tmp, TRUE))
  tibble::as_data_frame(tmp)
}

rbind_all_df <- function(x) {
  tmpdf <- dplyr::bind_rows(lapply(x, data.frame, stringsAsFactors = FALSE))
  tmpdf$label <- names(x)
  tmpdf
}

to_df <- function(x) {
  dplyr::bind_rows(lapply(x, function(x) {
    x[sapply(x, is.null)] <- NA
    data.frame(x, stringsAsFactors = FALSE)
  }))
}

null_to_na <- function(y) {
  y[sapply(y, is.null)] <- NA
  y
}
