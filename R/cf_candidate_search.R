#' Campaign finance NYTimes API - candidate search
#' 
#' See \url{http://developer.nytimes.com/docs/campaign_finance_api/}
#' 
#' @import jsonlite httr 
#' @export
#' @template finance
#' @template nyt
#' @param query Last name of a candidate
#' @examples \dontrun{
#' cf_candidate_search(campaign_cycle = 2010, query='smith')
#' cf_candidate_search(campaign_cycle = 2008, query='obama')
#' }

`cf_candidate_search` <- function(campaign_cycle=NULL,query=NULL,
  key=getOption("nytimes_cf_key"),callopts=list())
{
  url <- sprintf("http://api.nytimes.com/svc/elections/us/v3/finances/%s/candidates/search.json", campaign_cycle)
  args <- rtimes_compact(list(query=query,`api-key`=key))
  ans <- GET(url, query = args, callopts)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  jsonlite::fromJSON(tt, simplifyVector = FALSE)
}