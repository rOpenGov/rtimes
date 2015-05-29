#' Get a list of the most recent new members of the current Congress.
#' 
#' @import httr
#' @template nytcgkey
#' @param chamber One of 'house' or 'senate.
#' @param state Limits the list of members by state; two-letter state code (e.g., CA).
#' @param district Limits the list of members by district (House only). If you specify
#'    a district, you must also specify a state. If the district number you 
#'    specify is higher than the total number of districts for that state, 
#'    a 404 response will be returned.
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_memberbystatedistrict('senate', 'NH')
#' }
`cg_memberbystatedistrict` <- function(chamber = NULL, state = NULL, 
                                     district = NULL, key = NULL, ...) {
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/"
  url2 <- paste(url, chamber, '/', state, '/', district, 'current.json', sep='')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  tt <- GET(url2, query=args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
