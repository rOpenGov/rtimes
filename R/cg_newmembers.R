#' Get a list of the most recent new members of the current Congress.
#' 
#' @import httr
#' @template nytcgkey
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_newmembers()
#' }
cg_newmembers <- function(key = NULL, ...) {
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/new"
  url2 <- paste(url, '.json', sep='')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  tt <- GET(url2, query=args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
