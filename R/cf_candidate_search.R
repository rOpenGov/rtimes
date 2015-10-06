#' Campaign finance NYTimes API - candidate search
#' 
#' @keywords internal
#' @template finance
#' @template nyt
#' @param query Last name of a candidate
#' @references \url{http://developer.nytimes.com/docs/campaign_finance_api/}
#' @examples \dontrun{
#' # cf_candidate_search(campaign_cycle = 2010, query='smith')
#' # cf_candidate_search(campaign_cycle = 2008, query='obama')
#' }

`cf_candidate_search` <- function(campaign_cycle=NULL, query=NULL, key = NULL, ...) {
  url <- sprintf("%s%s/candidates/search.json", cf_base(), campaign_cycle)
  args <- rc(list(query = query,`api-key` = check_key(key, "nytimes_cf_key")))
  ans <- GET(url, query = args, ...)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  res <- jsonlite::fromJSON(tt, simplifyVector = FALSE)
  tmp <- pop(res, "results")
  tmp$data <- dplyr::rbind_all(lapply(res$results, function(x){
    x[sapply(x, is.null)] <- NA
    data.frame(x, stringsAsFactors = FALSE)
  }))
  tmp
}
