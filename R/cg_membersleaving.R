#' Get a list of members who have left the Senate or House or have announced plans to do so.
#' 
#' @import httr
#' @template nyt
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_membersleaving(112, 'house')
#' }
cg_membersleaving <- function(congress_no = NULL, chamber = NULL,
  key = getOption("nytimes_cg_key", stop("need an API key for the NYT Congress API")), ...) {
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/"
  url2 <- paste(url, congress_no, '/', chamber, '/members/leaving.json', sep='')
  args <- list('api-key' = key)
  tt <- GET(url2, query=args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
