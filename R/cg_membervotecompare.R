#' Get a list of members who have left the Senate or House or have announced plans to do so.
#' 
#' @import httr
#' @template nyt
#' @param memberid_1 The member's unique ID number (alphanumeric). To find a 
#'    member's ID number, get the list of members for the appropriate House 
#'    or Senate. You can also use the Biographical Directory of the United 
#'    States Congress to get a member's ID. In search results, each member's 
#'    name is linked to a record by index ID (e.g., 
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041). 
#'    Use the index ID as member-id in your request.
#' @param memberid_2 See description for memberid_1. 
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_membervotecompare('S001181', 'A000368', 112, 'senate')
#' }
cg_membervotecompare <- function(memberid_1 = NULL, memberid_2 = NULL, 
  congress_no = NULL, chamber = NULL, 
  key = getOption("nytimes_cg_key", stop("need an API key for the NYT Congress API")),
  callopts = list())
{
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/"
  url2 <- paste(url, memberid_1, '/votes/', memberid_2, '/', congress_no, '/', 
                chamber, '.json', sep='')
  args <- list('api-key' = key)
  tt <- GET(url2, query=args, callopts)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}