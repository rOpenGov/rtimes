#' Get a specific roll-call vote, including a complete list of member positions.
#' 
#' @import httr
#' @importFrom plyr compact
#' @template nyt
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @param session_no 1, 2, or special session number (For a detailed list of 
#'    Congressional sessions, see 
#'    http://www.senate.gov/reference/resources/pdf/congresses2.pdf).
#' @param rollcall_no Integer. To get roll-call numbers, see the official sites 
#'    of the US Senate 
#'    (http://www.senate.gov/pagelayout/legislative/a_three_sections_with_teasers/votes.htm),
#'    and US House (http://artandhistory.house.gov/house_history/index.aspx).
#' @return Get a specific roll-call vote, including a complete list of member 
#'    positions. 
#' @export
#' @examples \dontrun{
#' nyt_cg_rollcallvote(112, 'house', 1, 00235)
#' }
nyt_cg_rollcallvote <- function(congress_no = NULL, chamber = NULL, 
  session_no = NULL, rollcall_no = NULL,
  key = getOption("NYTCongressKey", stop("need an API key for the NYT Congress API")),
  callopts = list())
{
  url = "http://api.nytimes.com/svc/politics/v3/us/legislative/congress/"
  url2 <- paste(url, congress_no, '/', chamber, '/sessions/', session_no, 
                '/votes/', rollcall_no, '.json', sep='')
  args <- list('api-key' = key)
  content(GET(url2, query=args, callopts))
}