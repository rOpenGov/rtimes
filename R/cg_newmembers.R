#' Get a list of the most recent new members of the current Congress.
#' 
#' @import httr
#' @template nyt
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_newmembers()
#' }
cg_newmembers <- function(
  key = getOption("nytimes_cg_key", stop("need an API key for the NYT Congress API")), ...) {
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/new"
  url2 <- paste(url, '.json', sep='')
  args <- list('api-key' = key)
  tt <- GET(url2, query=args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
