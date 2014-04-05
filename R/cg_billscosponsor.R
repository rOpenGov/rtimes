#' Get bill cosponsorship data for a particular member.
#' 
#' @import httr
#' @template nyt
#' @param memberid The member's unique ID number (alphanumeric). To find a 
#'    member's ID number, get the list of members for the appropriate House 
#'    or Senate. You can also use the Biographical Directory of the United 
#'    States Congress to get a member's ID. In search results, each member's 
#'    name is linked to a record by index ID (e.g., 
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041). 
#'    Use the index ID as member-id in your request.
#' @param type One of 'cosponsored' (the 20 bills most recently cosponsored 
#'    by member-id) or 'withdrawn' (the 20 most recently withdrawn 
#'    cosponsorships for member-id). 
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_billscosponsor(memberid='S001181', type='cosponsored')
#' }
cg_billscosponsor <- function(memberid = NULL, type = NULL,
  key = getOption("nytimes_cg_key", stop("need an API key for the NYT Congress API")),
  callopts = list()) 
{
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/"
  url2 <- paste(url, memberid, '/bills/', type, '.json', sep='')
  args <- list('api-key' = key)
  tt <- GET(url2, query=args, callopts)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  jsonlite::fromJSON(out, simplifyVector = FALSE)
#   RJSONIO::fromJSON(out)
}