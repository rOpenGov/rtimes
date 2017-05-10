#' Campaign finance - candidate search
#'
#' @keywords internal
#' @template finance
#' @template nyt
#' @param query Last name of a candidate
#' @references \url{http://propublica.github.io/campaign-finance-api-docs}
#' @examples \dontrun{
#' # cf_candidate_search(campaign_cycle = 2016, query='Wilson')
#' # cf_candidate_search(campaign_cycle = 2008, query='obama')
#' }

`cf_candidate_search` <- function(campaign_cycle=NULL, query=NULL, key = NULL, ...) {
  url <- sprintf("%s/%s/candidates/search.json", cf_base(), campaign_cycle)
  args <- rc(list(query = query))
  ans <- GET(url, query = args, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  res <- jsonlite::fromJSON(tt, simplifyVector = FALSE)
  tmp <- pop(res, "results")
  tmp$data <- dplyr::bind_rows(lapply(res$results, function(x){
    x[sapply(x, is.null)] <- NA
    data.frame(x, stringsAsFactors = FALSE)
  }))
  tmp
}
