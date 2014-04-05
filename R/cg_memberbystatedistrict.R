#' Get a list of the most recent new members of the current Congress.
#' 
#' @import httr
#' @importFrom plyr compact
#' @template nyt
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
cg_memberbystatedistrict <- function(chamber = NULL, state = NULL, 
  district = NULL,
  key = getOption("NYTCongressKey", stop("need an API key for the NYT Congress API")),
  callopts = list()) 
{
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/"
  url2 <- paste(url, chamber, '/', state, '/', district, 'current.json', sep='')
  args <- list('api-key' = key)
  content(GET(url2, query=args, callopts))
}