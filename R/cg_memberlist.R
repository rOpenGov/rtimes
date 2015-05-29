#' Get a list of members of a particular chamber in a particular Congress.
#' 
#' @import httr
#' @template nytcgkey
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @param state Limits the list of members by state; two-letter state code (e.g., CA).
#' @param district Limits the list of members by district (House only). If you specify
#'    a district, you must also specify a state. If the district number you 
#'    specify is higher than the total number of districts for that state, 
#'    a 404 response will be returned.
#' @return List of members of a particular chamber in a particular Congress.
#' @export
#' @examples \dontrun{
#' cg_memberslist(112, 'senate')
#' cg_memberslist(112, 'senate', 'NH')
#' cg_memberslist(110, 'senate', 'NH')
#' }
cg_memberslist <- function(congress_no = NULL, chamber = NULL, state = NULL, 
  district = NULL, key = NULL, ...) {
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/"
  url2 <- paste(url, congress_no, '/', chamber, '/members.json', sep='')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"), state = state, district = district)
  tt <- GET(url2, query=args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
